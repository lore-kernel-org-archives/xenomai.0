MIME-Version: 1.0
Date: Sun, 14 Nov 2010 01:24:01 +0100
Message-ID: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=00163646da6c26aa370494f857d0
Subject: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--00163646da6c26aa370494f857d0
Content-Type: text/plain; charset=ISO-8859-1

Hello

I'm currently fighting with a problem in the pSOS+ skin.
This my system information:

[    2.314676] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    2.416025] I-pipe: Domain Xenomai registered.
[    2.418183] Xenomai: hal/i386 started.
[    2.422780] Xenomai: scheduling class idle registered.
[    2.424116] Xenomai: scheduling class rt registered.
[    2.566737] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
[    2.590628] Xenomai: starting native API services.
[    2.604491] Xenomai: starting pSOS+ services.
[    2.619941] HugeTLB registered 4 MB page size, pre-allocated 0 pages

This is a piece of testcode I have created:

        check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
        check("tm_cancel",tm_cancel(tmr_id),0);
        ev_rcvd = 0;
        ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
        check("ev_receive",ret,ERR_TIMEOUT);

I just start a periodic timer that expires every 3 ticks and at expiry sends
event 4 to my task.
I want to check the cancel of the timer, so I cancel it and I would expect
not to receive any event.

What I observe is that this code is not working: I immediately receive the
event after starting the timer.
If I change the code like shown below (I added the ev_receive with the
NO_WAIT option after starting the timer), the code works fine.

        check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
        ret = ev_receive(4,EV_ANY|EV_NOWAIT,0,&ev_rcvd);
        check("tm_cancel",tm_cancel(tmr_id),0);
        ev_rcvd = 0;
        ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
        check("ev_receive",ret,ERR_TIMEOUT);

Now my question is: how do I investigate an issue like this? In other words,
which are the best tools since this code involves both user and kernel space
debugging.
Are there some trace tools available that are able to generate a kind of
sequence / trace of what is happing over time.

I also have other issues that are not consistently reproducible. For this
kind of problems trace tools would also be useful.

Thanks
Ronny

--00163646da6c26aa370494f857d0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I&#39;m currently fighting with a problem in the pSOS+ skin.<b=
r>This my system information:<br><br>[=A0=A0=A0 2.314676] pci 0000:00:01.0:=
 Activating ISA DMA hang workarounds<br>[=A0=A0=A0 2.416025] I-pipe: Domain=
 Xenomai registered.<br>
[=A0=A0=A0 2.418183] Xenomai: hal/i386 started.<br>[=A0=A0=A0 2.422780] Xen=
omai: scheduling class idle registered.<br>[=A0=A0=A0 2.424116] Xenomai: sc=
heduling class rt registered.<br>[=A0=A0=A0 2.566737] Xenomai: real-time nu=
cleus v2.5.4 (Sleep Walk) loaded.<br>
[=A0=A0=A0 2.590628] Xenomai: starting native API services.<br>[=A0=A0=A0 2=
.604491] Xenomai: starting pSOS+ services.<br>[=A0=A0=A0 2.619941] HugeTLB =
registered 4 MB page size, pre-allocated 0 pages<br><br>This is a piece of =
testcode I have created:<br>
<br>=A0=A0=A0=A0=A0=A0=A0 check(&quot;tm_evevery&quot;,tm_evevery(4,3,&amp;=
tmr_id),0);<br>=A0=A0=A0=A0=A0=A0=A0 check(&quot;tm_cancel&quot;,tm_cancel(=
tmr_id),0);<br>=A0=A0=A0=A0=A0=A0=A0 ev_rcvd =3D 0;<br>=A0=A0=A0=A0=A0=A0=
=A0 ret =3D ev_receive(4,EV_ANY|EV_WAIT,10,&amp;ev_rcvd);<br>
=A0=A0=A0=A0=A0=A0=A0 check(&quot;ev_receive&quot;,ret,ERR_TIMEOUT);<br><br=
>I just start a periodic timer that expires every 3 ticks and at expiry sen=
ds event 4 to my task.<br>I want to check the cancel of the timer, so I can=
cel it and I would expect not to receive any event.<br>
<br>What I observe is that this code is not working: I immediately receive =
the event after starting the timer.<br>If I change the code like shown belo=
w (I added the ev_receive with the NO_WAIT option after starting the timer)=
, the code works fine.<br>
<br>=A0=A0=A0=A0=A0=A0=A0 check(&quot;tm_evevery&quot;,tm_evevery(4,3,&amp;=
tmr_id),0);<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D ev_receive(4,EV_ANY|EV_NOWAIT,=
0,&amp;ev_rcvd);<br>=A0=A0=A0=A0=A0=A0=A0 check(&quot;tm_cancel&quot;,tm_ca=
ncel(tmr_id),0);<br>=A0=A0=A0=A0=A0=A0=A0 ev_rcvd =3D 0;<br>
=A0=A0=A0=A0=A0=A0=A0 ret =3D ev_receive(4,EV_ANY|EV_WAIT,10,&amp;ev_rcvd);=
<br>=A0=A0=A0=A0=A0=A0=A0 check(&quot;ev_receive&quot;,ret,ERR_TIMEOUT);<br=
><br>Now my question is: how do I investigate an issue like this? In other =
words, which are the best tools since this code involves both user and kern=
el space debugging.<br>
Are there some trace tools available that are able to generate a kind of se=
quence / trace of what is happing over time.<br><br>I also have other issue=
s that are not consistently reproducible. For this kind of problems trace t=
ools would also be useful.<br>
<br>Thanks<br>Ronny<br>

--00163646da6c26aa370494f857d0--

