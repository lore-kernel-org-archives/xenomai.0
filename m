Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C53614.568FD3B6"
Date: Thu, 31 Mar 2005 11:09:02 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC1935932D@amr-ex5.ds.amrdec.army.mil>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] ppc64 root domain handler for event 4?
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos <adeos-main@gna.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53614.568FD3B6
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
I've been struggling with this for a couple of weeks.  I see where the
RTAI domain registers handler for events 0 through 3.  When trying to=20
load the RTAI_nucleus domain, an event 4 is passed down through the
domains, and ends up in adeos_handle_event, where it looks like the=20
root domain's handler for  event 4 is called.  The address of this
handler is not in the range of addresses that linux code would fall
under, i.e.=20
it's a 0xd000000000000000 instead of a 0xc000000000000000 address.
=20
I'm printing out from adeos_catch_event_from each time an event is
registered for a domain, and event 4 never shows up in this function. =20
Where did the root domain pickup a handler for this event that isn't a
linux one?
=20
I can't find what this handler is, or where it is getting loaded for the
root domain.
=20
Any help would be greatly appreciated!
=20
Terry Reynolds
Simulation Technologies, INC.
=20
=20

------_=_NextPart_001_01C53614.568FD3B6
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2604" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>Hi=20
all,</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>I've =
been struggling=20
with this for a couple of weeks.&nbsp; I see where the RTAI domain =
registers=20
handler for events 0 through 3.&nbsp; When trying to =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>load =
the=20
</FONT></SPAN><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2>RTAI_nucleus domain, an event 4 is passed down through the =
domains, and=20
ends up in adeos_handle_event, where it looks like the =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>root=20
</FONT></SPAN><SPAN class=3D544195616-31032005><FONT face=3DArial =
size=3D2>domain's=20
handler </FONT></SPAN><SPAN class=3D544195616-31032005><FONT =
face=3DArial=20
size=3D2>for&nbsp; event 4 is called.&nbsp; The address of this handler =
is not in=20
the range of addresses that linux code would fall under, i.e.=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>it's a =

</FONT></SPAN><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2>0xd000000000000000 instead of a 0xc000000000000000=20
address.</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>I'm =
printing out=20
from adeos_catch_event_from each time an event is registered for a =
domain, and=20
event 4 never shows up in this function.&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>Where =
did the root=20
domain pickup a handler for this event that isn't a linux=20
one?</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>I =
can't find what=20
this handler is, or where it is getting loaded for the root=20
domain.</FONT></SPAN></DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D544195616-31032005><FONT face=3DArial size=3D2>Any =
help would be=20
greatly appreciated!</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><EM><FONT face=3DScript size=3D5>Terry =
Reynolds</FONT></EM></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Simulation Technologies,=20
INC.</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C53614.568FD3B6--

