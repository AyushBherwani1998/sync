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

    struct Schedule {
        address host;
        uint startTimestamp;
        uint endTimestamp;
        address[] guests;
        string description;
        string title;
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

        delete syncEventsUserMapper[host];

        emit MeetingScheduled(msg.sender, host, startTimestamp, endTimestamp, title, description);
    }

    function getSchedules(address user) public view returns(Schedule[] memory) {
        uint totalSchedules = schedules.length;
        Schedule[] memory tempSchedule = new Schedule[](totalSchedules);
        uint tempScheduleIndex;
        for(uint i = 0; i < totalSchedules; i++) {
            Schedule memory schedule = schedules[i];
            if(schedule.host == user || isUserPresentInAttendees(schedule.guests, user)) {
                tempSchedule[tempScheduleIndex] = schedule;
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
