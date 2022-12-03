import 'dart:convert';

import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/web3/sync/models/schedules.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/web3/web3_client.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

mixin SyncContract {
  static String get jsonData => jsonEncode(abiMap);

  static EthereumAddress get contractAddress =>
      EthereumAddress.fromHex('0x6c3699b552d23caa49a561321de9cb74a8a87491');

  static ContractAbi get contractAbi => ContractAbi.fromJson(jsonData, 'Sync');

  static DeployedContract get deployedContract =>
      DeployedContract(contractAbi, contractAddress);

  static Future<MeetingSchedules> fetchSchedules(String address) async {
    final getScheduleEvent = deployedContract.function('getSchedules');
    final result = await Web3ClientDart.client.call(
      contract: deployedContract,
      function: getScheduleEvent,
      params: [EthereumAddress.fromHex(address)],
    );

    return MeetingSchedules.fromList(result);
  }

  static Future<String?> scheduleMeeting({
    required String title,
    required String description,
    required int startTimeStamp,
    required int endTimeStamp,
    required String host,
  }) async {
    try {
      final scheduleMeetingFunction = deployedContract.function(
        'scheduleMeeting',
      );

      return await sendTransaction(
        scheduleMeetingFunction,
        [
          title,
          description,
          BigInt.from(startTimeStamp),
          BigInt.from(endTimeStamp),
          EthereumAddress.fromHex(host),
        ],
      );
    } catch (e) {
      Vx.log('Schedule meeting: $e');
      return null;
    }
  }

  static Future<SyncEvent?> fetchEvent(String address) async {
    final getEventFunction = deployedContract.function('getEvent');
    final result = await Web3ClientDart.client.call(
      contract: deployedContract,
      function: getEventFunction,
      params: [
        EthereumAddress.fromHex(address),
      ],
    );
    final SyncEvent syncEvent = SyncEvent.fromList(result.first);
    if (syncEvent.isEventAvailable) {
      return syncEvent;
    }
    return null;
  }

  static Future<String?> addEvent(
    int timeSlot,
    MeetingPlatform meetingPlatform,
  ) async {
    try {
      final addEventFunction = deployedContract.function('addEvent');
      return await sendTransaction(
        addEventFunction,
        [
          'Sync availability',
          BigInt.from(timeSlot),
          BigInt.from(meetingPlatform.index)
        ],
      );
    } catch (e) {
      Vx.log(e);
      return null;
    }
  }

  static Future<String> sendTransaction(
    ContractFunction function,
    List params,
  ) async {
    try {
      final EthPrivateKey ethPrivateKey = WalletManager().getPrivateKey();
      final hash = await Web3ClientDart.client.sendTransaction(
        await Web3ClientDart.client.credentialsFromPrivateKey(
          bytesToHex(ethPrivateKey.privateKey),
        ),
        Transaction.callContract(
          contract: deployedContract,
          function: function,
          parameters: params,
        ),
        chainId: 5,
      );
      return hash;
    } catch (e) {
      throw Exception('Transaction Failed');
    }
  }

  static final abiMap = [
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "string",
          "name": "title",
          "type": "string"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "timeSlot",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint8",
          "name": "meetingPlatformIndex",
          "type": "uint8"
        }
      ],
      "name": "EventCreated",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "guest",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "address",
          "name": "host",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "startTimestamp",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "endTimestamp",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "title",
          "type": "string"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "description",
          "type": "string"
        }
      ],
      "name": "MeetingScheduled",
      "type": "event"
    },
    {
      "inputs": [
        {"internalType": "string", "name": "title", "type": "string"},
        {"internalType": "uint256", "name": "timeSlot", "type": "uint256"},
        {
          "internalType": "uint8",
          "name": "meetingPlatformIndex",
          "type": "uint8"
        }
      ],
      "name": "addEvent",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "uint256", "name": "startTimestamp", "type": "uint256"}
      ],
      "name": "deleteScheduledMeeting",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "string", "name": "title", "type": "string"},
        {"internalType": "string", "name": "description", "type": "string"},
        {
          "internalType": "uint256",
          "name": "startTimestamp",
          "type": "uint256"
        },
        {"internalType": "uint256", "name": "endTimestamp", "type": "uint256"},
        {"internalType": "address", "name": "host", "type": "address"}
      ],
      "name": "scheduleMeeting",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {"inputs": [], "stateMutability": "nonpayable", "type": "constructor"},
    {
      "inputs": [
        {"internalType": "address", "name": "user", "type": "address"}
      ],
      "name": "getEvent",
      "outputs": [
        {
          "components": [
            {"internalType": "string", "name": "title", "type": "string"},
            {"internalType": "uint256", "name": "timeSlot", "type": "uint256"},
            {
              "internalType": "uint8",
              "name": "meetingPlatformIndex",
              "type": "uint8"
            }
          ],
          "internalType": "struct Sync.SyncEvent",
          "name": "",
          "type": "tuple"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "user", "type": "address"}
      ],
      "name": "getSchedules",
      "outputs": [
        {
          "components": [
            {
              "components": [
                {"internalType": "address", "name": "host", "type": "address"},
                {
                  "internalType": "uint256",
                  "name": "startTimestamp",
                  "type": "uint256"
                },
                {
                  "internalType": "uint256",
                  "name": "endTimestamp",
                  "type": "uint256"
                },
                {
                  "internalType": "address[]",
                  "name": "guests",
                  "type": "address[]"
                },
                {
                  "internalType": "string",
                  "name": "description",
                  "type": "string"
                },
                {"internalType": "string", "name": "title", "type": "string"}
              ],
              "internalType": "struct Sync.Schedule",
              "name": "schedule",
              "type": "tuple"
            },
            {"internalType": "bool", "name": "isActive", "type": "bool"}
          ],
          "internalType": "struct Sync.ScheduleWithStatus[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {"internalType": "address", "name": "", "type": "address"}
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ];
}
