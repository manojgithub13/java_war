<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.nima.calendar.util.*" %>
<style type="text/css">


.dateBanner { font-size: 12px; font-family: Tahoma; color: #FFFFFF; background-color: #FFFFFF; }
.CurrentDay { font-family: Tahoma; font-size: 14px; color: #000066; background-color:#AFBEDA; }
.GeneralDay { font-size: 12px; font-family: "Tahoma"; color: #FBFAC4; background-color: #3C5267; }

a {
color: #ffffff;
text-decoration: none;
}
a:hover {
text-decoration: underline;
}
body {
background-color: #FFFFFF;
border: 0;
margin: 0;
padding: 0;
text-align: center;
font-family: Tahoma, Arial;
font-size: 76%;
}
body * { font-size: 1em; }
.font-xx-small { font-size: 0.7em; }
.font-x-small { font-size: 0.8em; }
.font-small { font-size: 0.9em; }
.font-large { font-size: 1.1em; }
.font-x-large { font-size: 1.2em; }
.font-xx-large { font-size: 1.3em; }
</style>

<%
    String currentYear = (String) request.getAttribute("currentYear");
    String currentMonth = (String) request.getAttribute("currentMonth");
    String currentDay = (String) request.getAttribute("currentDay");

    int cm = Integer.parseInt(currentMonth);
    int nm = cm + 1;
    if (nm > 11) {
        nm = 0;
    }

    String nextMonth = Integer.toString(nm);
    String nmurl = "persianCalendar.do?currentMonth=" + nextMonth + "&currentDay=" + currentDay;

    int pm = cm - 1;
    if (pm < 0) {
        pm = 11;
    }
    String previouseMonth = Integer.toString(pm);
    String pmurl = "persianCalendar.do?currentMonth=" + previouseMonth + "&currentDay=" + currentDay;

    String currentMonthName = SimplePersianCalendar.getPersianMonthName(Integer.parseInt(currentMonth));
%>


    <table width="204" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <td width="31%"><table dir="ltr" border="0" width="183" cellspacing="0" cellpadding="0" id="table4" bgcolor="#FFFFFF">
          <tr>
            <td width="6" height="20" align="center" bgcolor="#FFFFFF">&nbsp;</td>
            <td width="18" height="20" align="center"><a href="<%=nmurl%>"><font color="#000000">&lt;</font></a></td>
            <td width="134" align="center" bgcolor="#FFFFFF" class="dateBanner"><table width="70" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center"><font color="#000000"><%=currentYear%></font></div></td>
                <td><div align="center"><font color="#000000"><%=currentMonthName%></font></div></td>
                <td><div align="center"><font color="#000000"><%=currentDay%></font></div></td>
              </tr>
            </table></td>
            <td width="18" align="center"><a href="<%=pmurl%>"><font color="#000000">&gt;</font></a></td>
            <td width="7" align="center" bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
        </table>
          <%
	   SimplePersianCalendar spc = new SimplePersianCalendar();
	   spc.setDateFields( Integer.parseInt( currentYear ), Integer.parseInt( currentMonth ), 1);
	   DateFields df_spc = spc.getDateFields();
	   int firstDayOfMonth = spc.getPersianDayOfWeek();
	   int dayOfMonthCounter = 7-firstDayOfMonth;
	   int tmpCounter = 0;
	   int dayCounter = 0;
	   int dayContainer = 0;
	   String dayOfMonthStr = "&nbsp;";
	   int numberOfthisMonthDays = SimplePersianCalendar.getPersianDaysOfMonth( df_spc.getMonth(), df_spc.getYear());
	   String DefaultClassStyle = "class=\"GeneralDay\"";
	   String TodayStyleClass = "class=\"CurrentDay\"";
       String style= DefaultClassStyle;

    %>
          <table width="183" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#AFBEDA" >
            <tr>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1580;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1662;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1670;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1587;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1583;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1740;</font></td>
              <td  width="23" align="center"><font face="Tahoma" size="12px">&#1588;</font></td>
            </tr>
            <%
         for ( int counter1 = 0; counter1 < 7; counter1++ )
         {
            out.println("<tr align=\"center\" valign=\"middle\" dir=\"rtl\" bgcolor='#FFFFFF'>");

            for ( int counter2 = firstDayOfMonth  ; counter2 < 7; counter2++ )
			{
			   dayCounter = dayOfMonthCounter;
			   dayCounter -= tmpCounter ;
			   dayOfMonthStr = Integer.toString( dayCounter );

			   FarsiDigit fD0 = new FarsiDigit( dayOfMonthStr );
			   String farsiDayOfMonthStr = fD0.convertToUcs2();
               style=DefaultClassStyle;
			   
               String dayurl="persianCalendar.do?currentMonth="+ currentMonth +"&currentDay="+dayOfMonthStr;

               if ( Integer.parseInt( currentDay ) == Integer.parseInt( dayOfMonthStr ) ){
                 style=TodayStyleClass;
                   }
                 out.println("<td width=\"23\" height=\"23\" dir=\"rtl\"" +style+">");
			     %>
            <a href="<%=dayurl%>"><%=farsiDayOfMonthStr%></a>
            <%
               out.println("</td>");

			   tmpCounter += 1;
			}
			if ( firstDayOfMonth != 7 )
			  for ( int counter2 = 0; counter2 < firstDayOfMonth; counter2++ )
			     out.println("<td width=\"23\" height=\"23\" dir=\"rtl\"" +DefaultClassStyle+ "> &nbsp; </td>");

			out.println("</tr>");
			dayContainer = dayOfMonthCounter;
			dayOfMonthCounter += 7;
			tmpCounter = 0;
			int diffCounterAndMonthDays = ( dayOfMonthCounter - numberOfthisMonthDays );
			if ( diffCounterAndMonthDays < 0 )
			  diffCounterAndMonthDays *= -1;

			if ( dayOfMonthCounter > 30 )
			{
              if ( diffCounterAndMonthDays < 7 )
			  {
			     for ( int counter3 = 0; counter3 < diffCounterAndMonthDays; counter3++ )
			     {
                   dayOfMonthStr = "&nbsp;";
				   out.println("<td align=\"center\" bgcolor='#FFFFFF' height=\"23\" width=\"23\"" +DefaultClassStyle+ ">" +dayOfMonthStr+ "</td>");
			     }
			     int lastDayOfLastWeek = dayContainer + ( numberOfthisMonthDays - dayContainer );
			     int diffLastToFirst = 7 - ( numberOfthisMonthDays - dayContainer );
			     for ( int counter4 = diffLastToFirst  ; counter4 < 7; counter4++ )
			     {
                   tmpCounter = 1;
                   dayOfMonthStr = Integer.toString( lastDayOfLastWeek );
                   style=DefaultClassStyle;
				   FarsiDigit fD = new FarsiDigit( dayOfMonthStr );
				   String farsiDayOfMonthStr = fD.convertToUcs2();
                   String dayurl2="persianCalendar.do?currentMonth="+ currentMonth +"&currentDay="+dayOfMonthStr;
                   if ( Integer.parseInt( currentDay ) == Integer.parseInt( dayOfMonthStr ) ) {
                    style=TodayStyleClass;
                   }
                     out.println("<td align=\"center\" bgcolor='#FFFFFF' width=\"23\" height=\"23\" dir=\"rtl\"" +style+">");
			          %>
            <a href="<%=dayurl2%>"><%=farsiDayOfMonthStr%></a>
            <%
			     out.println("</td>");
			       lastDayOfLastWeek -= tmpCounter ;
			       tmpCounter += 1;
			     }
			  }
			  break;
			}
			else
			  firstDayOfMonth = 0;
         }
      %>
          </table></td>
      </tr>
    </table>