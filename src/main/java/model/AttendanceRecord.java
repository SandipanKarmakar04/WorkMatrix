package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;

public class AttendanceRecord {

    private Date attendanceDate;
    private Time checkIn;
    private Time checkOut;
    private BigDecimal totalHours;
    private String status;
    private String workDescription;

    public Date getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public Time getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Time checkIn) {
        this.checkIn = checkIn;
    }

    public Time getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Time checkOut) {
        this.checkOut = checkOut;
    }

    public BigDecimal getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(BigDecimal totalHours) {
        this.totalHours = totalHours;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getWorkDescription() {
        return workDescription;
    }

    public void setWorkDescription(String workDescription) {
        this.workDescription = workDescription;
    }

    // Formatted date: 14-Sep-2026
    public String getFormattedDate() {

        if (attendanceDate == null) {
            return "-";
        }

        return new SimpleDateFormat("dd-MMM-yyyy")
                .format(attendanceDate);
    }

    // Day: Monday
    public String getDayName() {

        if (attendanceDate == null) {
            return "-";
        }

        return new SimpleDateFormat("EEEE")
                .format(attendanceDate);
    }

    // Check-in: 09:15 AM
    public String getFormattedCheckIn() {

        if (checkIn == null) {
            return "-";
        }

        return new SimpleDateFormat("hh:mm a")
                .format(checkIn);
    }

    // Check-out: 06:05 PM
    public String getFormattedCheckOut() {

        if (checkOut == null) {
            return "-";
        }

        return new SimpleDateFormat("hh:mm a")
                .format(checkOut);
    }

    // Duration
    public String getFormattedTotalHours() {

        if (totalHours == null) {
            return "-";
        }

        double hours = totalHours.doubleValue();

        int wholeHours = (int) hours;

        int minutes = (int) Math.round(
                (hours - wholeHours) * 60
        );

        if (minutes == 60) {
            wholeHours++;
            minutes = 0;
        }

        return wholeHours + "h " + minutes + "m";
    }
}