// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sync {
    enum MeetingPlatforms{GOOGLE, ZOOM, HUDDLE01}

    event MeetingScheduled(address guest, address host, uint startTimestamp, uint endTimestamp, string title, string description);
    event EventCreated(string title, uint timeSlot, uint8 meetingPlatformIndex);

    address public owner;

     constructor() {
        owner = msg.sender;
    }

    Schedule[] schedules;

    mapping(address => SyncEvent) syncEventsUserMapper;
    mapping(uint => bool) meetingStateMapper;

    struct Schedule {
        address host;
        uint startTimestamp;
        uint endTimestamp;
        address[] guests;
        string description;
        string title;
    }

    struct ScheduleWithStatus {
        Schedule schedule;
        bool isActive; 
    }

    struct SyncEvent {
        string title;
        uint timeSlot;
        uint8 meetingPlatformIndex;
    }

    function addEvent(string calldata title, uint timeSlot, uint8 meetingPlatformIndex) public {
        SyncEvent memory syncEvent = SyncEvent(title, timeSlot, meetingPlatformIndex);
        syncEventsUserMapper[msg.sender] = syncEvent;

        emit EventCreated(title, timeSlot, meetingPlatformIndex);
    }

    function getEvent(address user) public view returns(SyncEvent memory) {
        return syncEventsUserMapper[user];
    }

    function scheduleMeeting(string calldata title, string calldata description, uint startTimestamp, uint endTimestamp, address host) public {
        address[] memory guests = new address[](1);
        guests[0] = msg.sender;

        Schedule memory schedule = Schedule(host,startTimestamp,endTimestamp, guests,description,title);
        schedules.push(schedule);
        meetingStateMapper[startTimestamp] = true;
        emit MeetingScheduled(msg.sender, host, startTimestamp, endTimestamp, title, description);
    }

    function deleteScheduledMeeting(uint startTimestamp) public {
        meetingStateMapper[startTimestamp] = false;
    }

    function getSchedules(address user) public view returns(ScheduleWithStatus[] memory) {
        uint totalSchedules = schedules.length;
        ScheduleWithStatus[] memory tempSchedule = new ScheduleWithStatus[](totalSchedules);
        uint tempScheduleIndex;
        for(uint i = 0; i < totalSchedules; i++) {
            Schedule memory schedule = schedules[i];
            if(schedule.host == user || isUserPresentInAttendees(schedule.guests, user)) {
                bool isScheduleActive = meetingStateMapper[schedule.startTimestamp];
                tempSchedule[tempScheduleIndex] = ScheduleWithStatus(schedule, isScheduleActive);
                tempScheduleIndex++;
            }
        }

        return tempSchedule;
    }

    function isUserPresentInAttendees(address[] memory attendees, address user) private pure returns(bool) {
        bool isUserPresent = false;
        for(uint i = 0; i < attendees.length; i++) {
            address attendee = attendees[i];
            if(attendee == user) {
                isUserPresent = true;
                break;
            }
        }
        return isUserPresent;
    }
}
