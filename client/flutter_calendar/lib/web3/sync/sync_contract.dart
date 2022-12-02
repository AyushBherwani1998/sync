import 'dart:convert';

mixin SyncContract {
  String get jsonData => jsonEncode(abiMap);
  final abiMap = [
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
