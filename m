In-Reply-To: <46388DCC.5070303@domain.hid>
MIME-Version: 1.0
Message-ID: <OFC2180F21.68900DD6-ONC12572CF.004C5CAC-C12572CF.004CFE20@domain.hid>
From: Andreas Erler <Andreas.Erler@domain.hid>
Date: Wed, 2 May 2007 16:00:57 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004CFE1BC12572CF_="
Subject: [Xenomai-help] Antwort:  HELP!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, xenomai-help-bounces@domain.hid

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 004CFE1BC12572CF_=
Content-Type: text/plain; charset="US-ASCII"

Hi Roland,

I do not want to make big advertisment here in this forum, but have a look 
at our webpage, we have a lot of buscouplers for external io. (CAN, 
Ethernet Powerlink, ...)
Also maybe interesting for you is, that we are working on a xenomai driver 
for ethernet powerlink (http://www.ethernet-powerlink.org/) which will be 
finished in a few days...

Andy

Tel: +43 (0)7716/20136 - 11
Email: andreas.erler@domain.hid
http://www.br-automation.com

_________________________________________
Firmenbuchnummer: Landesgericht Ried im Innkreis / FN 111651 v



Roland Tollenaar <rwatollenaar@domain.hid> 
Gesendet von: xenomai-help-bounces@domain.hid
02.05.2007 15:12
Bitte antworten an
rolandtollenaar@domain.hid


An
Xenomai-help@domain.hid
Kopie

Thema
[Xenomai-help] HELP!!






Hi,

Sorry about the subject but I badly need some advice.

I have tried 2 different makes of remote IO over CAN to achieve my 1ms
control loop. The makes are WAGO and Schleicher. These are industrial
modules that link to buscouplers (in my case CAN) and make the IO
available to andy device that can talk CAN. In this case my xenomai'd PC
platform.

However both makes (and all others I have contacted) have bus couplers
which are too slow to achieve this. 5ms is about the best they can do.
The engineering departments (who were not aware of this restriction)
agree that it is not a fundamental CAN problem but a matter of their
hardware not being able to respond fast enough.

I have given up hope of finding suppliers who can supply industrial (the
latter is important) equipment that will give me what I am looking for
based on CAN. So I am willing to settle on another bus protocol (I will
still be using CAN for other sensors which are responding fast enough on
CAN) for the remote IO.

Can anyone tell me what companies can supply remote IO that is fast 
enough.

Can anyone comment on the use of RTNET (real time ethernet I believe)
with xenomai. I ahve not seen any evidence of it being alove on this
mailing list.


Thanks,

Roland


_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


--=_alternative 004CFE1BC12572CF_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Roland,</font>
<br>
<br><font size=2 face="sans-serif">I do not want to make big advertisment
here in this forum, but have a look at our webpage, we have a lot of buscouplers
for external io. (CAN, Ethernet Powerlink, ...)</font>
<br><font size=2 face="sans-serif">Also maybe interesting for you is, that
we are working on a xenomai driver for ethernet powerlink (http://www.ethernet-powerlink.org/)
which will be finished in a few days...</font>
<br><font size=2 face="sans-serif"><br>
Andy</font>
<br><font size=2 face="Arial"><br>
Tel: +43 (0)7716/20136 - 11<br>
Email: andreas.erler@domain.hid</font><font size=2 color=blue face="Arial"><u><br>
</u></font><a href="http://www.br-automation.com/"><font size=2 color=blue face="Arial"><u>http://www.br-automation.com</u></font></a><font size=2 face="Arial"><br>
</font><font size=2 face="Courier"><br>
_________________________________________</font><font size=1 face="Arial"><br>
Firmenbuchnummer: Landesgericht Ried im Innkreis / FN 111651 v</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Roland Tollenaar &lt;rwatollenaar@domain.hid&gt;</b>
</font>
<br><font size=1 face="sans-serif">Gesendet von: xenomai-help-bounces@domain.hid</font>
<p><font size=1 face="sans-serif">02.05.2007 15:12</font>
<table border>
<tr valign=top>
<td bgcolor=white>
<div align=center><font size=1 face="sans-serif">Bitte antworten an<br>
rolandtollenaar@domain.hid</font></div></table>
<br>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">An</font></div>
<td><font size=1 face="sans-serif">Xenomai-help@domain.hid</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Kopie</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Thema</font></div>
<td><font size=1 face="sans-serif">[Xenomai-help] HELP!!</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>Hi,<br>
<br>
Sorry about the subject but I badly need some advice.<br>
<br>
I have tried 2 different makes of remote IO over CAN to achieve my 1ms<br>
control loop. The makes are WAGO and Schleicher. These are industrial<br>
modules that link to buscouplers (in my case CAN) and make the IO<br>
available to andy device that can talk CAN. In this case my xenomai'd PC<br>
platform.<br>
<br>
However both makes (and all others I have contacted) have bus couplers<br>
which are too slow to achieve this. 5ms is about the best they can do.<br>
The engineering departments (who were not aware of this restriction)<br>
agree that it is not a fundamental CAN problem but a matter of their<br>
hardware not being able to respond fast enough.<br>
<br>
I have given up hope of finding suppliers who can supply industrial (the<br>
latter is important) equipment that will give me what I am looking for<br>
based on CAN. So I am willing to settle on another bus protocol (I will<br>
still be using CAN for other sensors which are responding fast enough on<br>
CAN) for the remote IO.<br>
<br>
Can anyone tell me what companies can supply remote IO that is fast enough.<br>
<br>
Can anyone comment on the use of RTNET (real time ethernet I believe)<br>
with xenomai. I ahve not seen any evidence of it being alove on this<br>
mailing list.<br>
<br>
<br>
Thanks,<br>
<br>
Roland<br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
Xenomai-help@domain.hid<br>
https://mail.gna.org/listinfo/xenomai-help<br>
</tt></font>
<br>
--=_alternative 004CFE1BC12572CF_=--

