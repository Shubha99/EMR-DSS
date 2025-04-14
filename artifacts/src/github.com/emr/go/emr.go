package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"time"

	"github.com/hyperledger/fabric-chaincode-go/shim"
	peer "github.com/hyperledger/fabric-protos-go/peer"
)

type SmartContract struct{}

type EMRRecord struct {
	RecordID      string `json:"recordId"`
	PatientID     string `json:"patientId"`
	DoctorID      string `json:"doctorId"`
	Diagnosis     string `json:"diagnosis"`
	Prescriptions string `json:"prescriptions"`
	Notes         string `json:"notes"`
	CreatedAt     string `json:"createdAt"`
	UpdatedAt     string `json:"updatedAt"`
}

func (s *SmartContract) Init(stub shim.ChaincodeStubInterface) peer.Response {
	return shim.Success(nil)
}

func (s *SmartContract) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	fcn, params := stub.GetFunctionAndParameters()
	var result []byte
	var err error

	switch fcn {
	case "CreateEMRRecord":
		result, err = s.CreateEMRRecord(stub, params)
	case "UpdateEMRRecord":
		result, err = s.UpdateEMRRecord(stub, params)
	case "GetAllEMRRecords":
		result, err = s.GetAllEMRRecords(stub)
	case "GetHistoryForRecord":
		result, err = s.GetHistoryForRecord(stub, params)
	default:
		return shim.Error("Invalid function name.")
	}

	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(result)
}

func (s *SmartContract) CreateEMRRecord(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
	if len(args) != 5 {
		return nil, fmt.Errorf("Invalid number of arguments. Expected 5")
	}

	timestamp, _ := stub.GetTxTimestamp()
	record := EMRRecord{
		RecordID:      args[0],
		PatientID:     args[1],
		DoctorID:      args[2],
		Diagnosis:     args[3],
		Prescriptions: args[4],
		Notes:         "",
		CreatedAt:     time.Unix(timestamp.Seconds, int64(timestamp.Nanos)).String(),
		UpdatedAt:     time.Unix(timestamp.Seconds, int64(timestamp.Nanos)).String(),
	}

	recordAsBytes, err := json.Marshal(record)
	if err != nil {
		return nil, err
	}

	err = stub.PutState(args[0], recordAsBytes)
	if err != nil {
		return nil, err
	}

	return recordAsBytes, nil
}

func (s *SmartContract) UpdateEMRRecord(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
	if len(args) != 5 {
		return nil, fmt.Errorf("Invalid number of arguments. Expected 5")
	}

	existingRecordBytes, err := stub.GetState(args[0])
	if err != nil || existingRecordBytes == nil {
		return nil, fmt.Errorf("Record not found")
	}

	var record EMRRecord
	_ = json.Unmarshal(existingRecordBytes, &record)

	timestamp, _ := stub.GetTxTimestamp()
	record.DoctorID = args[1]
	record.Diagnosis = args[2]
	record.Prescriptions = args[3]
	record.Notes = args[4]
	record.UpdatedAt = time.Unix(timestamp.Seconds, int64(timestamp.Nanos)).String()

	updatedBytes, err := json.Marshal(record)
	if err != nil {
		return nil, err
	}

	err = stub.PutState(args[0], updatedBytes)
	if err != nil {
		return nil, err
	}

	return updatedBytes, nil
}

func (s *SmartContract) GetAllEMRRecords(stub shim.ChaincodeStubInterface) ([]byte, error) {
	iterator, err := stub.GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	defer iterator.Close()

	var buffer bytes.Buffer
	buffer.WriteString("[")
	first := true

	for iterator.HasNext() {
		queryResponse, err := iterator.Next()
		if err != nil {
			return nil, err
		}
		if !first {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"key\":\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\", \"value\":")
		buffer.Write(queryResponse.Value)
		buffer.WriteString("}")
		first = false
	}

	buffer.WriteString("]")
	return buffer.Bytes(), nil
}

func (s *SmartContract) GetHistoryForRecord(stub shim.ChaincodeStubInterface, args []string) ([]byte, error) {
	if len(args) != 1 {
		return nil, fmt.Errorf("Invalid number of arguments. Expected 1")
	}

	iterator, err := stub.GetHistoryForKey(args[0])
	if err != nil {
		return nil, err
	}
	defer iterator.Close()

	var buffer bytes.Buffer
	buffer.WriteString("[")
	first := true

	for iterator.HasNext() {
		response, err := iterator.Next()
		if err != nil {
			return nil, err
		}
		if !first {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"TxId\":\"")
		buffer.WriteString(response.TxId)
		buffer.WriteString("\", \"value\":")
		buffer.Write(response.Value)
		buffer.WriteString("}")
		first = false
	}

	buffer.WriteString("]")
	return buffer.Bytes(), nil
}

func main() {
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error starting EMR smart contract: %s", err)
	}
}
