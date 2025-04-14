export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
export PEER_HOSPITAL_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt
export PEER_INSURANCE_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export CHANNEL_NAME=generalchannel

setGlobalsForOrderer() {
    export CORE_PEER_LOCALMSPID="OrdererMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$ORDERER_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp
}

setGlobalsForPeer0Hospital() {
    export CORE_PEER_LOCALMSPID="HospitalMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_HOSPITAL_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Hospital() {
    export CORE_PEER_LOCALMSPID="HospitalMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_HOSPITAL_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setGlobalsForPeer0Insurance() {
    export CORE_PEER_LOCALMSPID="InsuranceCompanyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_INSURANCE_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setGlobalsForPeer1Insurance() {
    export CORE_PEER_LOCALMSPID="InsuranceCompanyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_INSURANCE_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

presetup() {
    echo Vendoring Go dependencies ...
    pushd ./artifacts/src/github.com/emr/go
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}


CHANNEL_NAME="generalchannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./artifacts/src/github.com/emr/go"
CC_NAME="emr"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Hospital
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
    --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
    --label ${CC_NAME}_${VERSION}

    echo "=================== Chaincode is packaged on peer0.hospital ==================="
}

installChaincode() {
    setGlobalsForPeer0Hospital
    peer lifecycle chaincode install ${CC_NAME}.tar.gz 
    echo "=================== Chaincode is installed on peer0.hospital ==================="

    setGlobalsForPeer0Insurance
    peer lifecycle chaincode install ${CC_NAME}.tar.gz 
    echo "=================== Chaincode is installed on peer0.insurance ==================="
}

queryInstalled() {
    setGlobalsForPeer0Hospital
    peer lifecycle chaincode queryinstalled >log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo Package ID is ${PACKAGE_ID}
    echo "=================== Query installed successful on peer0.hospital on generalchannel ==================="
}

approveForHospitalOrg() {
    setGlobalsForPeer0Hospital

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.orderer.com --tls \
    --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}

    echo "=================== Chaincode approved from Hospital ==================="
}

checkCommitReadiness() {
    setGlobalsForPeer0Hospital

    peer lifecycle chaincode checkcommitreadiness --channelID ${CHANNEL_NAME} \
    --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} \
    --output json --init-required
    echo "=================== Checking commit readiness from Hospital ==================="
}

approveForInsuranceOrg() {
    setGlobalsForPeer0Insurance

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.orderer.com --tls \
    --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id ${PACKAGE_ID} --sequence ${VERSION}

    echo "=================== Chaincode approved from Insurance ==================="
}

commitChaincodeDefinition() {
    setGlobalsForPeer0Hospital

    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer1.orderer.com \
    --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} \
    --channelID ${CHANNEL_NAME} --name ${CC_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles $PEER_HOSPITAL_CA \
    --peerAddresses localhost:9051 --tlsRootCertFiles $PEER_INSURANCE_CA \
    --version ${VERSION} --sequence ${VERSION} --init-required
    echo "=================== Chaincode Committed Successfully ==================="
}

chaincodeInvokeInit() {
    setGlobalsForPeer0Hospital

    peer chaincode invoke -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.orderer.com \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
    -C ${CHANNEL_NAME} -n ${CC_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles $PEER_HOSPITAL_CA \
    --peerAddresses localhost:9051 --tlsRootCertFiles $PEER_INSURANCE_CA \
    --isInit -c '{"Args":[]}'
}

chaincodeInvoke() {
    setGlobalsForPeer0Hospital

    peer chaincode invoke -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1.orderer.com \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
    -C ${CHANNEL_NAME} -n ${CC_NAME} \
    --peerAddresses localhost:7051 --tlsRootCertFiles $PEER_HOSPITAL_CA \
    --peerAddresses localhost:9051 --tlsRootCertFiles $PEER_INSURANCE_CA \
    -c '{"function":"GetHistoryForRecord", "Args":["record1"]}'
}

chaincodeQuery() {
    setGlobalsForPeer0Hospital

    peer chaincode query -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"function":"GetAllEMRRecords", "Args":[]}'
}

# Call any function as needed:

# presetup

# packageChaincode
installChaincode
# queryInstalled
# approveForHospitalOrg
# approveForInsuranceOrg
# checkCommitReadiness
# commitChaincodeDefinition
# chaincodeInvokeInit
# chaincodeInvoke
# chaincodeQuery