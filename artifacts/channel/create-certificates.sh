####################### FOR LINUX ##############################

# createCertificateForHospital() {
#     echo
#     echo "Enroll CA Admin"
#     echo
#     mkdir -p crypto-config/peerOrganizations/hospital.com/

#     export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/hospital.com/

#     fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem


#     echo 'NodeOUs:
#     Enable: true
#     ClientOUIdentifier:
#         Certificate: cacerts/localhost-7054-ca.hospital.com.pem
#         OrganizationalUnitIdentifier: client
#     PeerOUIdentifier:
#         Certificate: cacerts/localhost-7054-ca.hospital.com.pem
#         OrganizationalUnitIdentifier: peer
#     AdminOUIdentifier:
#         Certificate: cacerts/localhost-7054-ca.hospital.com.pem
#         OrganizationalUnitIdentifier: admin
#     OrdererOUIdentifier:
#         Certificate: cacerts/localhost-7054-ca.hospital.com.pem
#         OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/hospital.com/msp/config.yaml


#     echo 
#     echo "Register Peer0"
#     echo
#     fabric-ca-client register --caname ca.hospital.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     echo 
#     echo "Register Peer1"
#     echo
#     fabric-ca-client register --caname ca.hospital.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     echo 
#     echo "Register Admin"
#     echo
#     fabric-ca-client register --caname ca.hospital.com --id.name adminHospital --id.secret adminHospitalpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     mkdir -p crypto-config/peerOrganizations/hospital.com/peers

#     echo
#     echo "peer0 enrollment"
#     echo
#     mkdir -p crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/

#     echo 
#     echo "Generating peer0 msp"
#     echo
#     fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.hospital.com -M ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp --csr.hosts peer0.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp/config.yaml

#     echo 
#     echo "Generating peer0-tls certs"
#     echo
#     fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.hospital.com -M ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls --enrollment.profile tls --csr.hosts peer0.hospital.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem


#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/signcerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/server.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/keystore -type f)" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/server.key"

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/hospital.com/msp/tlscacerts
#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/hospital.com/msp/tlscacerts/ca.crt

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/hospital.com/tlsca
#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/hospital.com/tlsca/tlsca.hospital.com-cert.pem

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/hospital.com/ca
#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/hospital.com/ca/ca.hospital.com-cert.pem


#     echo
#     echo "peer1 enrollment"
#     echo
#     mkdir -p crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/

#     echo 
#     echo "Generating peer1 msp"
#     echo
#     fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.hospital.com -M ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/msp --csr.hosts peer1.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/msp/config.yaml

#     echo 
#     echo "Generating peer1-tls certs"
#     echo
#     fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.hospital.com -M ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls --enrollment.profile tls --csr.hosts peer1.hospital.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem


#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/tlscacerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/ca.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/signcerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/server.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/keystore -type f)" "${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/server.key"


#     echo 
#     echo "Admin Enrollment"
#     echo  
#     mkdir -p crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com

#     echo 
#     echo "Generating Admin Certs"
#     echo
#     fabric-ca-client enroll -u https://adminHospital:adminHospitalpw@localhost:7054 --caname ca.hospital.com -M ${PWD}/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp --tls.certfiles ${PWD}/fabric-ca/hospitalOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp/config.yaml
# }


# createCertificateForInsuranceCompany() {

#     echo
#     echo "Enroll CA Admin"
#     echo
#     mkdir -p crypto-config/peerOrganizations/insurancecompany.com/

#     export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/insurancecompany.com/

#     fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.insurancecompany.com --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem


#     echo 'NodeOUs:
#     Enable: true
#     ClientOUIdentifier:
#         Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
#         OrganizationalUnitIdentifier: client
#     PeerOUIdentifier:
#         Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
#         OrganizationalUnitIdentifier: peer
#     AdminOUIdentifier:
#         Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
#         OrganizationalUnitIdentifier: admin
#     OrdererOUIdentifier:
#         Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
#         OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/config.yaml


#     echo 
#     echo "Register Peer0"
#     echo
#     fabric-ca-client register --caname ca.insurancecompany.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     echo 
#     echo "Register Peer1"
#     echo
#     fabric-ca-client register --caname ca.insurancecompany.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     echo 
#     echo "Register Admin"
#     echo
#     fabric-ca-client register --caname ca.insurancecompany.com --id.name adminInsurance --id.secret adminInsurancepw --id.type admin --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     mkdir -p crypto-config/peerOrganizations/insurancecompany.com/peers

#     echo
#     echo "peer0 enrollment"
#     echo
#     mkdir -p crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/

#     echo 
#     echo "Generating peer0 msp"
#     echo
#     fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.insurancecompany.com -M ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/msp --csr.hosts peer0.insurancecompany.com --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/msp/config.yaml

#     echo 
#     echo "Generating peer0-tls certs"
#     echo
#     fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.insurancecompany.com -M ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls --enrollment.profile tls --csr.hosts peer0.insurancecompany.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem


#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/tlscacerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/ca.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/signcerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/server.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/keystore -type f)" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/server.key"

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/tlscacerts
#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/tlscacerts/ca.crt

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/tlsca
#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/tlsca/tlsca.insurancecompany.com-cert.pem

#     mkdir -p ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/ca
#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/ca/ca.insurancecompany.com-cert.pem


#     echo
#     echo "peer1 enrollment"
#     echo
#     mkdir -p crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/

#     echo 
#     echo "Generating peer1 msp"
#     echo
#     fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.insurancecompany.com -M ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/msp --csr.hosts peer1.insurancecompany.com --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/msp/config.yaml

#     echo 
#     echo "Generating peer1-tls certs"
#     echo
#     fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.insurancecompany.com -M ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls --enrollment.profile tls --csr.hosts peer1.insurancecompany.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem


#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/tlscacerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/ca.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/signcerts -name \'*.pem\')" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/server.crt"
#     cp "$(find ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/keystore -type f)" "${PWD}/crypto-config/peerOrganizations/insurancecompany.com/peers/peer1.insurancecompany.com/tls/server.key"


#     echo 
#     echo "Admin Enrollment"
#     echo  
#     mkdir -p crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com

#     echo 
#     echo "Generating Admin Certs"
#     echo
#     fabric-ca-client enroll -u https://adminInsurance:adminInsurancepw@localhost:8054 --caname ca.insurancecompany.com -M ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp --tls.certfiles ${PWD}/fabric-ca/insurancecompanyOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com/msp/config.yaml

# }

# createCertificateForOrderer() {
#     echo
#     echo "Enroll CA Admin"
#     echo
#     mkdir -p crypto-config/ordererOrganizations/orderer.com/

#     export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/orderer.com/

#     fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.orderer.com --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     echo 'NodeOUs:
#     Enable: true
#     ClientOUIdentifier:
#         Certificate: cacerts/localhost-9054-ca-orderer-com.pem
#         OrganizationalUnitIdentifier: client
#     PeerOUIdentifier:
#         Certificate: cacerts/localhost-9054-ca-orderer-com.pem
#         OrganizationalUnitIdentifier: peer
#     AdminOUIdentifier:
#         Certificate: cacerts/localhost-9054-ca-orderer-com.pem
#         OrganizationalUnitIdentifier: admin
#     OrdererOUIdentifier:
#         Certificate: cacerts/localhost-9054-ca-orderer-com.pem
#         OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/config.yaml

#     echo 
#     echo "Register orderer1"
#     echo
#     fabric-ca-client register --caname ca.orderer.com --id.name orderer1 --id.secret orderer1pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     echo 
#     echo "Register orderer2"
#     echo
#     fabric-ca-client register --caname ca.orderer.com --id.name orderer2 --id.secret orderer2pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     echo 
#     echo "Register orderer3"
#     echo
#     fabric-ca-client register --caname ca.orderer.com --id.name orderer3 --id.secret orderer3pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     echo 
#     echo "Register Admin"
#     echo
#     fabric-ca-client register --caname ca.orderer.com --id.name adminOrderer --id.secret adminOrdererpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/

#     echo '-------------------------------------------------'
#     echo "orderer1 enrollment"

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com

#     echo 
#     echo "Generating the orderer1 msp"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer1:orderer1pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp --csr.hosts orderer1.orderer.com --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp/config.yaml

#     echo 
#     echo "Generating the orderer1-tls certs"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer1:orderer1pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls --enrollment.profile tls --csr.hosts orderer1.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/ca.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/server.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/server.key

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp/tlscacerts/
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/ca/
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp/cacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/ca/ca.orderer.com-cert.pem


#     echo '-------------------------------------------------'
#     echo "orderer2 enrollment"

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com

#     echo 
#     echo "Generating the orderer2 msp"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer2:orderer2pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp --csr.hosts orderer2.orderer.com --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/config.yaml

#     echo 
#     echo "Generating the orderer2-tls certs"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer2:orderer2pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls --enrollment.profile tls --csr.hosts orderer2.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/ca.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/server.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/server.key

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/tlscacerts/
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem


#     echo '-------------------------------------------------'
#     echo "orderer3 enrollment"

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com

#     echo 
#     echo "Generating the orderer3 msp"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer3:orderer3pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp --csr.hosts orderer3.orderer.com --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/config.yaml

#     echo 
#     echo "Generating the orderer3-tls certs"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://orderer3:orderer3pw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls --enrollment.profile tls --csr.hosts orderer3.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/ca.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/server.crt
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/server.key

#     mkdir -p crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/tlscacerts/
#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem


#     mkdir -p crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/

#     echo 
#     echo "Generating the Admin msp"
#     echo
#     fabric-ca-client enroll --caname ca.orderer.com -u https://adminOrderer:adminOrdererpw@localhost:9054 -M ${PWD}/crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

#     cp ${PWD}/crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp/config.yaml

# }

# createCertificateForHospital
# createCertificateForInsuranceCompany
# createCertificateForOrderer


################################# FOR MACOS #################################

BASE_DIR="$(pwd)"

createCertificateForHospital() {
    echo "\nEnroll CA Admin"
    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/"
    export FABRIC_CA_CLIENT_HOME="$BASE_DIR/crypto-config/peerOrganizations/hospital.com/"

    fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.hospital.com --tls.certfiles "$BASE_DIR/fabric-ca/hospitalOrg/tls-cert.pem"

    cat > "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" <<EOF
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca.hospital.com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca.hospital.com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca.hospital.com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca.hospital.com.pem
    OrganizationalUnitIdentifier: orderer
EOF

    echo "\nRegistering identities"
    for i in peer0 peer1 adminHospital; do
        TYPE="peer"
        [ "$i" = "adminHospital" ] && TYPE="admin"
        fabric-ca-client register --caname ca.hospital.com --id.name "$i" --id.secret "$i"pw --id.type "$TYPE" --tls.certfiles "$BASE_DIR/fabric-ca/hospitalOrg/tls-cert.pem"
    done

    for i in peer0 peer1; do
        PEER_DIR="$BASE_DIR/crypto-config/peerOrganizations/hospital.com/peers/$i.hospital.com"
        mkdir -p "$PEER_DIR"

        echo "\nGenerating $i MSP"
        fabric-ca-client enroll -u https://$i:${i}pw@localhost:7054 --caname ca.hospital.com -M "$PEER_DIR/msp" --csr.hosts "$i.hospital.com" --tls.certfiles "$BASE_DIR/fabric-ca/hospitalOrg/tls-cert.pem"
        cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$PEER_DIR/msp/config.yaml"

        echo "\nGenerating $i TLS certs"
        fabric-ca-client enroll -u https://$i:${i}pw@localhost:7054 --caname ca.hospital.com -M "$PEER_DIR/tls" --enrollment.profile tls --csr.hosts "$i.hospital.com" --csr.hosts localhost --tls.certfiles "$BASE_DIR/fabric-ca/hospitalOrg/tls-cert.pem"

        cp "$(find "$PEER_DIR/tls/tlscacerts" -name '*.pem' -print -quit)" "$PEER_DIR/tls/ca.crt"
        cp "$(find "$PEER_DIR/tls/signcerts" -name '*.pem' -print -quit)" "$PEER_DIR/tls/server.crt"
        cp "$(find "$PEER_DIR/tls/keystore" -type f -print -quit)" "$PEER_DIR/tls/server.key"
    done

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/msp/tlscacerts"
    cp "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt" "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/msp/tlscacerts/ca.crt"

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/tlsca"
    cp "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt" "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/tlsca/tlsca.hospital.com-cert.pem"

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/ca"
    cp "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp/cacerts/localhost-7054-ca.hospital.com.pem" "$BASE_DIR/crypto-config/peerOrganizations/hospital.com/ca/ca.hospital.com-cert.pem"

    echo "\nAdmin Enrollment"
    ADMIN_DIR="$BASE_DIR/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com"
    mkdir -p "$ADMIN_DIR"
    fabric-ca-client enroll -u https://adminHospital:adminHospitalpw@localhost:7054 --caname ca.hospital.com -M "$ADMIN_DIR/msp" --tls.certfiles "$BASE_DIR/fabric-ca/hospitalOrg/tls-cert.pem"
    cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$ADMIN_DIR/msp/config.yaml"
}

createCertificateForInsuranceCompany() {
    echo "\nEnroll CA Admin"
    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/"
    export FABRIC_CA_CLIENT_HOME="$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/"

    fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.insurancecompany.com --tls.certfiles "$BASE_DIR/fabric-ca/insurancecompanyOrg/tls-cert.pem"

    cat > "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" <<EOF
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca.insurancecompany.com.pem
    OrganizationalUnitIdentifier: orderer
EOF

    for i in peer0 peer1 adminInsurance; do
        TYPE="peer"
        [ "$i" = "adminInsurance" ] && TYPE="admin"
        fabric-ca-client register --caname ca.insurancecompany.com --id.name "$i" --id.secret "$i"pw --id.type "$TYPE" --tls.certfiles "$BASE_DIR/fabric-ca/insurancecompanyOrg/tls-cert.pem"
    done

    for i in peer0 peer1; do
        PEER_DIR="$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/peers/$i.insurancecompany.com"
        mkdir -p "$PEER_DIR"

        fabric-ca-client enroll -u https://$i:${i}pw@localhost:8054 --caname ca.insurancecompany.com -M "$PEER_DIR/msp" --csr.hosts "$i.insurancecompany.com" --tls.certfiles "$BASE_DIR/fabric-ca/insurancecompanyOrg/tls-cert.pem"
        cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$PEER_DIR/msp/config.yaml"

        fabric-ca-client enroll -u https://$i:${i}pw@localhost:8054 --caname ca.insurancecompany.com -M "$PEER_DIR/tls" --enrollment.profile tls --csr.hosts "$i.insurancecompany.com" --csr.hosts localhost --tls.certfiles "$BASE_DIR/fabric-ca/insurancecompanyOrg/tls-cert.pem"

        cp "$(find "$PEER_DIR/tls/tlscacerts" -name '*.pem' -print -quit)" "$PEER_DIR/tls/ca.crt"
        cp "$(find "$PEER_DIR/tls/signcerts" -name '*.pem' -print -quit)" "$PEER_DIR/tls/server.crt"
        cp "$(find "$PEER_DIR/tls/keystore" -type f -print -quit)" "$PEER_DIR/tls/server.key"
    done

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/msp/tlscacerts"
    cp "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/ca.crt" "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/msp/tlscacerts/ca.crt"

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/tlsca"
    cp "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/tls/ca.crt" "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/tlsca/tlsca.insurancecompany.com-cert.pem"

    mkdir -p "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/ca"
    cp "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/peers/peer0.insurancecompany.com/msp/cacerts/localhost-8054-ca.insurancecompany.com.pem" "$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/ca/ca.insurancecompany.com-cert.pem"

    echo "\nAdmin Enrollment"
    ADMIN_DIR="$BASE_DIR/crypto-config/peerOrganizations/insurancecompany.com/users/Admin@insurancecompany.com"
    mkdir -p "$ADMIN_DIR"
    fabric-ca-client enroll -u https://adminInsurance:adminInsurancepw@localhost:8054 --caname ca.insurancecompany.com -M "$ADMIN_DIR/msp" --tls.certfiles "$BASE_DIR/fabric-ca/insurancecompanyOrg/tls-cert.pem"
    cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$ADMIN_DIR/msp/config.yaml"
}


createCertificateForOrderer() {
    echo "\nEnroll CA Admin"
    mkdir -p "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/"
    export FABRIC_CA_CLIENT_HOME="$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/"

    fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.orderer.com --tls.certfiles "$BASE_DIR/fabric-ca/ordererOrg/tls-cert.pem"

    cat > "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" <<EOF
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer-com.pem
    OrganizationalUnitIdentifier: orderer
EOF

    for i in orderer1 orderer2 orderer3 adminOrderer; do
        TYPE="orderer"
        [ "$i" = "adminOrderer" ] && TYPE="admin"
        fabric-ca-client register --caname ca.orderer.com --id.name "$i" --id.secret "$i"pw --id.type "$TYPE" --tls.certfiles "$BASE_DIR/fabric-ca/ordererOrg/tls-cert.pem"
    done

    for i in orderer1 orderer2 orderer3; do
        ORDERER_DIR="$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/orderers/$i.orderer.com"
        mkdir -p "$ORDERER_DIR"

        fabric-ca-client enroll -u https://$i:${i}pw@localhost:9054 --caname ca.orderer.com -M "$ORDERER_DIR/msp" --csr.hosts "$i.orderer.com" --tls.certfiles "$BASE_DIR/fabric-ca/ordererOrg/tls-cert.pem"
        cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$ORDERER_DIR/msp/config.yaml"

        fabric-ca-client enroll -u https://$i:${i}pw@localhost:9054 --caname ca.orderer.com -M "$ORDERER_DIR/tls" --enrollment.profile tls --csr.hosts "$i.orderer.com" --csr.hosts localhost --tls.certfiles "$BASE_DIR/fabric-ca/ordererOrg/tls-cert.pem"

        cp "$(find "$ORDERER_DIR/tls/tlscacerts" -name '*.pem' -print -quit)" "$ORDERER_DIR/tls/ca.crt"
        cp "$(find "$ORDERER_DIR/tls/signcerts" -name '*.pem' -print -quit)" "$ORDERER_DIR/tls/server.crt"
        cp "$(find "$ORDERER_DIR/tls/keystore" -type f -print -quit)" "$ORDERER_DIR/tls/server.key"

        mkdir -p "$ORDERER_DIR/msp/tlscacerts"
        cp "$ORDERER_DIR/tls/ca.crt" "$ORDERER_DIR/msp/tlscacerts/tlsca.orderer.com-cert.pem"
    done

    mkdir -p "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts"
    cp "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/tls/ca.crt" "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem"

    mkdir -p "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/ca"
    cp "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/orderers/orderer1.orderer.com/msp/cacerts/localhost-9054-ca-orderer-com.pem" "$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/ca/ca.orderer.com-cert.pem"

    echo "\nAdmin Enrollment"
    ADMIN_DIR="$BASE_DIR/crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com"
    mkdir -p "$ADMIN_DIR"
    fabric-ca-client enroll -u https://adminOrderer:adminOrdererpw@localhost:9054 --caname ca.orderer.com -M "$ADMIN_DIR/msp" --tls.certfiles "$BASE_DIR/fabric-ca/ordererOrg/tls-cert.pem"
    cp "$FABRIC_CA_CLIENT_HOME/msp/config.yaml" "$ADMIN_DIR/msp/config.yaml"
}

createCertificateForHospital
createCertificateForInsuranceCompany
createCertificateForOrderer