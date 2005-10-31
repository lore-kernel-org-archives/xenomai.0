Message-ID: <312725565956E84DBB7C760BA4052BB583528A@diablo.Cadillac.Genmarkinc.com>
From: GeorgyS@GenmarkAutomation.com
Date: Mon, 31 Oct 2005 11:50:43 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5DE54.612CEB00"
Subject: [Xenomai-help] kernel screen dump: "scheduling while atomic: "
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5DE54.612CEB00
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
 
I have a user space real-time application that uses fusion/xenomai 0.9.1
native API on linux kernel 2.6.11 and uClibc-0.9.28.
Everything seems to work fine, but after the application has run for some
time (10 to 20 minutes), the following screen dumps begin to appear on the
console:
 
     scheduling while atomic: <my_real-time_func_name>/0x00000002/276
 
followed by a call stack dump.
My application continues to run normally, the scheduling of my real time
func seems ok too, but I wonder,
why this screen dump appears and can in be disabled?
 
Thanks,
Georgi Stoykov

------_=_NextPart_001_01C5DE54.612CEB00
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1505" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>Hi,</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN class=722593409-31102005>I 
have a user space real-time application that uses fusion/xenomai 0.9.1 native 
API on linux kernel 2.6.11 and uClibc-0.9.28.</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>Everything&nbsp;seems to work&nbsp;fine, but after the 
application has run for some time (10 to 20 minutes), the 
following&nbsp;screen&nbsp;dumps begin to appear on the 
console:</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>&nbsp;&nbsp;&nbsp;&nbsp; scheduling while atomic: 
&lt;my_real-time_func_name&gt;/0x00000002/276</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>followed by a call stack dump.</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN class=722593409-31102005>My 
application continues to run normally, the scheduling of my real time func seems 
ok too, but I wonder,</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN class=722593409-31102005>why 
this screen dump appears and can in be disabled?</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face="Courier New" color=#0000ff><SPAN 
class=722593409-31102005>Georgi Stoykov</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5DE54.612CEB00--

