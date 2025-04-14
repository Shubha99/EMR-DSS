# System channel name 
SYS_CHANNEL="system-channel"

# Channel name 
CHANNEL_NAME="generalchannel"

echo $CHANNEL_NAME


# Generate system Genesis block
echo
echo "Generating system Genesis block"
echo
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL -outputBlock ./genesis.block

# Generate channel configuration block
echo
echo "Generating channel configuration block"
echo
configtxgen -profile BasicChannel -configPath . -channelID $CHANNEL_NAME -outputCreateChannelTx ./generalchannel.tx 

# Generate Anchor peer Update Tx
echo
echo "Generating Anchor peer Update Tx"
echo

echo "For Org1"
configtxgen -profile BasicChannel -configPath . -channelID $CHANNEL_NAME -outputAnchorPeersUpdate ./HospitalMSPanchors.tx -asOrg HospitalOrg

echo "For Org2"
configtxgen -profile BasicChannel -configPath . -channelID $CHANNEL_NAME -outputAnchorPeersUpdate ./InsuranceCompanyMSPanchors.tx -asOrg InsuranceCompanyOrg
