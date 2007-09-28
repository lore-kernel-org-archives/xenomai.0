Message-ID: <OFE12CA909.5E198139-ONC1257363.0033BA79-C1257364.002A5484@domain.hid>
Date: Fri, 28 Sep 2007 09:45:34 +0200
From: alberto.tomasi@domain.hid
Content-Type: multipart/alternative;
	boundary="=_alternative 002A5478C1257364_="
MIME-Version: 1.0
Subject: [Xenomai-help] newbie question : xenomai tasks and linux interrupts
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

--=_alternative 002A5478C1257364_=
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi everybody
I'm a xenomai (and linux) newbie and I'm trying to understand what's=20
happening on the serial device of my system
My serial device is controlled by a linux driver and used by a linux task
Often the serial line dialog stops : no enough bytes received or CRC=20
errors are the warning indications coming from the linux task

Problems started when I've introduced an "heavy" xenomai (real time) task=20
and seems to have an higher frequency if I use an higher baud rate on the=20
serial line
In this condition the linux driver says that a lot of overrun error occurs =

in the serial device

My question is : when the xenomai task is running, all the interrupts=20
managed by linux are always blocked and delayed until the task has=20
finished its job ?
(I'm almost sure about but finding a confirmation of this in the xenomai=20
sources I haven't understood if and where this happen...)

If the answer is yes, how can I manage the serial device without overrun ?

Is it possible to setup a "special" management (no mask or immediate=20
propagation...) on specific interrupts used by linux ?

Another possible solution could be to realize a rtdm driver : doing this=20
interrupts from the serial device will not be masked by xenomai...
But how to link this with the linux driver system (uart device, tty device =

etc) ?=20
Having a look at rtdm, it seems (if I haven't misunderstood...) well=20
designed for real time task user (to reduce reception and response timing=20
trough devices connecting a control application with the external world :=20
the chain from data producer to consumer all in real time)=20

Is there a general issue about timing management of hardware resources not =

involved with the real time application constraints but (already) totally=20
managed by the linux side system ? Does exist a sort of model or examples=20
for this "bridge-to-linux" drivers in xenomai ?

Thanks in advance for any hint
Alberto Tomasi



This e-mail and any attachments is confidential and may contain privileged =
information intended for the addressee(s) only. Dissemination, copying, pri=
nting or use by anybody else is unauthorised. If you are not the intended r=
ecipient, please delete this message and any attachments and advise the sen=
der by return e-mail.Thank you.

Questo messaggio e i suoi allegati sono indirizzati esclusivamente alle per=
sone indicate. La diffusione, copia o qualsiasi altra azione derivante dall=
a conoscenza di queste informazioni sono rigorosamente vietate.Qualora abbi=
ate ricevuto questo documento per errore siete cortesemente pregati di darn=
e immediata comunicazione al mittente e di provvedere alla sua distruzione,=
 Grazie.

Informativa sul trattamento dei dati personali (D. Lgs. 196/2003). I dati u=
tilizzati per la spedizione del presente messaggio sono utilizzati da Gefra=
n S.p.A., titolare del trattamento, per l'invio delle comunicazioni dei div=
ersi settori aziendali, non essendo autorizzata la divulgazione a terzi. Po=
trete rivolgere alla seguente mail richieste di verifica, rettifica o cance=
llazione dei Vostri dati: ufficio.legale@domain.hid
--=_alternative 002A5478C1257364_=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D3 face=3D"Arial">Hi everybody</font><br><font size=3D3 fac=
e=3D"Arial">I'm a xenomai (and linux) newbie and I'm
trying to understand what's happening on the serial device of my system</fo=
nt><br><font size=3D3 face=3D"Arial">My serial device is controlled by a li=
nux
driver and used by a linux task</font><br><font size=3D3 face=3D"Arial">Oft=
en the serial line dialog stops : no enough
bytes received or CRC errors are the warning indications coming from the
linux task</font><br><br><font size=3D3 face=3D"Arial">Problems started whe=
n I've introduced an
&quot;heavy&quot; xenomai (real time) task and seems to have an higher
frequency if I use an higher baud rate on the serial line</font><br><font s=
ize=3D3 face=3D"Arial">In this condition the linux driver says that
a lot of overrun error occurs in the serial device</font><br><br><font size=
=3D3 face=3D"Arial">My question is : when the xenomai task is
running, all the interrupts managed by linux are always blocked and delayed
until the task has finished its job ?</font><br><font size=3D3 face=3D"Aria=
l">(I'm almost sure about but finding a confirmation
of this in the xenomai sources I haven't understood if and where this happe=
n...)</font><br><br><font size=3D3 face=3D"Arial">If the answer is yes, how=
 can I manage the
serial device without overrun ?</font><br><br><font size=3D3 face=3D"Arial"=
>Is it possible to setup a &quot;special&quot;
management (no mask or immediate propagation...) on specific interrupts
used by linux ?</font><br><br><font size=3D3 face=3D"Arial">Another possibl=
e solution could be to realize
a rtdm driver : doing this interrupts from the serial device will not be
masked by xenomai...</font><br><font size=3D3 face=3D"Arial">But how to lin=
k this with the linux driver
system (uart device, tty device etc) ? </font><br><font size=3D3 face=3D"Ar=
ial">Having a look at rtdm, it seems (if I haven't
misunderstood...) well designed for real time task user (to reduce reception
and response timing trough devices connecting a control application with
the external world : the chain from data producer to consumer all in real
time) &nbsp;</font><br><br><font size=3D3 face=3D"Arial">Is there a general=
 issue about timing management
of hardware resources not involved with the real time application constrain=
ts
but (already) totally managed by the linux side system ? Does exist a sort
of model or examples for this &quot;bridge-to-linux&quot; drivers in xenomai
?</font><br><br><font size=3D3 face=3D"Arial">Thanks in advance for any hin=
t</font><br><font size=3D3 face=3D"Arial">Alberto Tomasi</font><BR>
<BR>
<BR>
This e-mail and any attachments is confidential and may contain privileged =
information intended for the addressee(s) only. Dissemination, copying, pri=
nting or use by anybody else is unauthorised. If you are not the intended r=
ecipient, please delete this message and any attachments and advise the sen=
der by return e-mail.Thank you.<BR>
<BR>
Questo messaggio e i suoi allegati sono indirizzati esclusivamente alle per=
sone indicate. La diffusione, copia o qualsiasi altra azione derivante dall=
a conoscenza di queste informazioni sono rigorosamente vietate.Qualora abbi=
ate ricevuto questo documento per errore siete cortesemente pregati di darn=
e immediata comunicazione al mittente e di provvedere alla sua distruzione,=
 Grazie.<BR>
<BR>
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003). I dati u=
tilizzati per la spedizione del presente messaggio sono utilizzati da Gefra=
n S.p.A., titolare del trattamento, per l'invio delle comunicazioni dei div=
ersi settori aziendali, non essendo autorizzata la divulgazione a terzi. Po=
trete rivolgere alla seguente mail richieste di verifica, rettifica o cance=
llazione dei Vostri dati: ufficio.legale@domain.hid<BR>
--=_alternative 002A5478C1257364_=--

