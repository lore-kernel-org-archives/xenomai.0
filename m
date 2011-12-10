Message-ID: <25596872.1648691323512866036.JavaMail.defaultUser@domain.hid>
Date: Sat, 10 Dec 2011 11:27:46 +0100 (CET)
From: "ediboscio@domain.hid" <ediboscio@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_127732_18834090.1323512866036"
Subject: [Xenomai-help] I:  Interrupt issue on a PC/104 can interface?
Reply-To: "ediboscio@domain.hid" <ediboscio@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_127732_18834090.1323512866036
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Sirs,I'm new to rt-socket-can and xenomai. I had a better look at the code of rtcan_rtt and found my mistake:What I really wanted to do was:
first terminal:
./rtcan_rtt rtcan0 rtcan0 -c 250000
second terminal
./rtcan_rtt rtcan1 rtcan1 -r -c 250000

and now it works.
Sorry and Best regardsEttore



----Messaggio originale----

Da: ediboscio@domain.hid

Data: 09/12/2011 14.52

A: <xenomai@xenomai.org>

Ogg: [Xenomai-help] Interrupt issue on a PC/104 can interface?



Dear Sirs,I'm working with an Ubuntu (10.04) system with Xenomai (2.5.6), with kernel 2.6.37.6 and with a Peak-System PC/104 can interface (isa), with two channels.



I connected the two channels of the can interface with a cable (with the two 120Ohms resistor connected at each side) and did the following two tests:


1)
...

rtcanconfig rtcan0 --baudrate=1000000 start

rtcanconfig rtcan1 --baudrate=1000000 start



then, in one terminal:

rtcanrecv rtcan0



in another one:

rtcansend rtcan1 0xA 0xB 0xC 0xD 0xE 0xF 0x01 0x02



Everything seems to work: I can see the message on the receiving terminal. I 

also tried changing rtcansend options, and it works as well.


2)
Then I used the rtcan_rtt xenomai example program.In one terminal:./rtcan_rtt rtcan0 rtcan1 -r -c 250000
And in another one:./rtcan_rtt rtcan1 rtcan0 -c 250000
I also modified the rtcan_rtt to print some additional debug messages, and I found that for each can message sent
 from the transmitter channel I receive ~356 
messages on the other channel, with lot of overruns and huge times. Maybee I have some problems with the 
interrupts?Note that with the rtcanrecv/rtcansend test, for each message sent with rtcansend, rtcanrecv receives one message.
Thanks in advanceEttore
 








------=_Part_127732_18834090.1323512866036
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p style=3D"margin: 0px; padding: 0px;">Dear Sirs,</p><p style=3D"margin: 0=
px; padding: 0px;">I'm new to rt-socket-can and xenomai. I had a better loo=
k at the code of rtcan_rtt and found my mistake:</p><p style=3D"margin: 0px=
; padding: 0px;">What I really wanted to do was:</p><p style=3D"margin: 0px=
; padding: 0px;"><br></p><p style=3D"margin: 0px; padding: 0px;">first term=
inal:<br></p><p style=3D"margin: 0px; padding: 0px;">./rtcan_rtt rtcan0 rtc=
an0 -c 250000</p><p style=3D"margin: 0px; padding: 0px;"><br></p><p style=
=3D"margin: 0px; padding: 0px;">second terminal<br></p><p style=3D"margin: =
0px; padding: 0px;">./rtcan_rtt rtcan1 rtcan1 -r -c 250000</p>
<p style=3D"margin: 0px; padding: 0px;"><br></p><p style=3D"margin: 0px; pa=
dding: 0px;">and now it works.</p><p style=3D"margin: 0px; padding: 0px;"><=
br></p><p style=3D"margin: 0px; padding: 0px;">Sorry and Best regards</p><p=
 style=3D"margin: 0px; padding: 0px;">Ettore</p><p style=3D"margin: 0px; pa=
dding: 0px;"><br></p>

<blockquote>
----Messaggio originale----<br>
Da: ediboscio@domain.hid<br>
Data: 09/12/2011 14.52<br>
A: &lt;xenomai@xenomai.org&gt;<br>
Ogg: [Xenomai-help] Interrupt issue on a PC/104 can interface?<br>
<br>
<p style=3D"margin: 0px; padding: 0px;" mce_style=3D"margin: 0px; padding: =
0px;">Dear Sirs,</p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"ma=
rgin: 0px; padding: 0px;">I'm working with an Ubuntu (10.04) system with Xe=
nomai (2.5.6), with kernel 2.6.37.6 and with a Peak-System PC/104 can inter=
face (isa), with two channels.<br>
<br>
I connected the two channels of the can interface with a cable (with the tw=
o 120Ohms resistor connected at each side) and did the following two tests:=
<br>
</p><blockquote><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"margin=
: 0px; padding: 0px;"><br>1)</p><p style=3D"margin: 0px; padding: 0px;" mce=
_style=3D"margin: 0px; padding: 0px;"><br></p><p style=3D"margin: 0px; padd=
ing: 0px;" mce_style=3D"margin: 0px; padding: 0px;">...<br>
rtcanconfig rtcan0 --baudrate=3D1000000 start<br>
rtcanconfig rtcan1 --baudrate=3D1000000 start<br>
<br>
then, in one terminal:<br>
rtcanrecv rtcan0<br>
<br>
in another one:<br>
rtcansend rtcan1 0xA 0xB 0xC 0xD 0xE 0xF 0x01 0x02<br>
<br>
Everything seems to work: I can see the message on the receiving terminal. =
I <br>
also tried changing rtcansend options, and it works as well.<br>
</p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"margin: 0px; paddi=
ng: 0px;"><br></p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"marg=
in: 0px; padding: 0px;">2)<br></p><p style=3D"margin: 0px; padding: 0px;" m=
ce_style=3D"margin: 0px; padding: 0px;">Then I used the rtcan_rtt xenomai e=
xample program.</p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"mar=
gin: 0px; padding: 0px;">In one terminal:</p><p style=3D"margin: 0px; paddi=
ng: 0px;" mce_style=3D"margin: 0px; padding: 0px;">./rtcan_rtt rtcan0 rtcan=
1 -r -c 250000</p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"marg=
in: 0px; padding: 0px;"><br></p><p style=3D"margin: 0px; padding: 0px;" mce=
_style=3D"margin: 0px; padding: 0px;">And in another one:</p><p style=3D"ma=
rgin: 0px; padding: 0px;" mce_style=3D"margin: 0px; padding: 0px;">./rtcan_=
rtt rtcan1 rtcan0 -c 250000</p><p style=3D"margin: 0px; padding: 0px;" mce_=
style=3D"margin: 0px; padding: 0px;"><br></p><p style=3D"margin: 0px; paddi=
ng: 0px;" mce_style=3D"margin: 0px; padding: 0px;">I also modified the rtca=
n_rtt to print some additional debug messages, and I found that for each ca=
n message sent
 from the transmitter channel I receive ~356=20
messages on the other channel, with lot of overruns and huge times. Maybee =
I have some problems with the=20
interrupts?</p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"margin:=
 0px; padding: 0px;">Note that with the rtcanrecv/rtcansend test, for each =
message sent with rtcansend, rtcanrecv receives one message.</p><p style=3D=
"margin: 0px; padding: 0px;" mce_style=3D"margin: 0px; padding: 0px;"><br><=
/p><p style=3D"margin: 0px; padding: 0px;" mce_style=3D"margin: 0px; paddin=
g: 0px;">Thanks in advance</p><p style=3D"margin: 0px; padding: 0px;" mce_s=
tyle=3D"margin: 0px; padding: 0px;">Ettore</p><p style=3D"margin: 0px; padd=
ing: 0px;" mce_style=3D"margin: 0px; padding: 0px;"><br></p><div style=3D"p=
osition: absolute; left: -10000px; top: 0px; width: 1px; height: 1px; overf=
low: hidden;" id=3D"_mcePaste">&nbsp;</div><br>
</blockquote><p><br></p><br>
</blockquote><p><br></p>
------=_Part_127732_18834090.1323512866036--


