# @author: Shubha Bhardwaj
# EMR-DSS
# EMR-DSS
Procedure:
1. Bring the network up by running the docker file at hlf_emr/artifact
run: docker-compose up -d
2. Implement SmartContract by running deploy-chaincode.sh
run: the script has functions in the sequence of how they should be invoked.
3. The SmartContract implemented in the chaincode can be found at:
artifacts/src/github.com/emr/go/emr.go 


 ├── artifacts
    │   ├── base.yaml
    │   ├── channel
    │   │   ├── config
    │   │   │   └── core.yaml
    │   │   ├── configtx.yaml
    │   │   ├── create-artifacts.sh
    │   │   ├── create-certificates.sh
    │   │   ├── crypto-config
    │   │   │   ├── ordererOrganizations
    │   │   │   │   └── orderer.com
    │   │   │   │       └── orderers
    │   │   │   │           ├── orderer1.orderer.com
    │   │   │   │           │   ├── msp
    │   │   │   │           │   └── tls
    │   │   │   │           ├── orderer2.orderer.com
    │   │   │   │           │   ├── msp
    │   │   │   │           │   └── tls
    │   │   │   │           └── orderer3.orderer.com
    │   │   │   │               ├── msp
    │   │   │   │               └── tls
    │   │   │   └── peerOrganizations
    │   │   │       ├── clinic.com
    │   │   │       │   └── peers
    │   │   │       │       ├── peer0.clinic.com
    │   │   │       │       │   ├── msp
    │   │   │       │       │   └── tls
    │   │   │       │       └── peer1.clinic.com
    │   │   │       │           ├── msp
    │   │   │       │           └── tls
    │   │   │       ├── hospital.com
    │   │   │       │   └── peers
    │   │   │       │       ├── peer0.hospital.com
    │   │   │       │       │   ├── msp
    │   │   │       │       │   └── tls
    │   │   │       │       └── peer1.hospital.com
    │   │   │       │           ├── msp
    │   │   │       │           └── tls
    │   │   │       └── insuranceCompany.com
    │   │   │           └── peers
    │   │   │               ├── peer0.insuranceCompany.com
    │   │   │               │   ├── msp
    │   │   │               │   └── tls
    │   │   │               └── peer1.insuranceCompany.com
    │   │   │                   ├── msp
    │   │   │                   └── tls
    │   │   ├── docker-compose.yaml
    │   │   ├── fabric-ca
    │   │   │   ├── clinicOrg
    │   │   │   ├── hospitalOrg
    │   │   │   ├── insuranceCompanyOrg
    │   │   │   └── ordererOrg
    │   │   └── genesis.block
    │   └── docker-compose.yaml
    ├── channel-artifacts
    ├── channel.sh
    ├── create-channel.sh
    └── deploy-chaincode.sh
