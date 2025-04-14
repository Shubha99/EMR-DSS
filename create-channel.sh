export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
export PEER_HOSPITAL_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt
export PEER_INSURANCE_COMPANY_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/ca.crt
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

setGlobalsForPeer0InsuranceCompany() {
    export CORE_PEER_LOCALMSPID="InsuranceCompanyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_INSURANCE_COMPANY_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setGlobalsForPeer1InsuranceCompany() {
    export CORE_PEER_LOCALMSPID="InsuranceCompanyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER_INSURANCE_COMPANY_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

createChannel() {
    mkdir -p ${PWD}/channel-artifacts/
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Hospital

    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer1.orderer.com \
    -f ./artifacts/channel/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 

}

joinChannel() {
    setGlobalsForPeer0Hospital
    peer channel join -b ./channel-artifacts/${CHANNEL_NAME}.block 

    setGlobalsForPeer1Hospital
    peer channel join -b ./channel-artifacts/${CHANNEL_NAME}.block 

    setGlobalsForPeer0InsuranceCompany
    peer channel join -b ./channel-artifacts/${CHANNEL_NAME}.block 

    setGlobalsForPeer1InsuranceCompany
    peer channel join -b ./channel-artifacts/${CHANNEL_NAME}.block 
}

updateAnchorPeers() {
    setGlobalsForPeer0Hospital
    peer channel update -o localhost:7050 -c ${CHANNEL_NAME} --ordererTLSHostnameOverride orderer1.orderer.com \
    -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls ${CORE_PEER_TLS_ENABLED} --cafile $ORDERER_CA

    setGlobalsForPeer0InsuranceCompany
    peer channel update -o localhost:7050 -c ${CHANNEL_NAME} --ordererTLSHostnameOverride orderer1.orderer.com \
    -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls ${CORE_PEER_TLS_ENABLED} --cafile $ORDERER_CA
}

# createChannel
#  joinChannel
updateAnchorPeers