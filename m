Message-ID: <17043901.1177943488672.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Apr 2007 16:31:28 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai/rtnet vs. 2.6.21 realtime preempt patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtnet-users@domain.hid, xenomai@xenomai.org

Hi everybody,

I have tried the latest 2.6.21 kernel + Ingo Molnar's realtime preempt patc=
h
(see: http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)

And I am really amazed about the results.
On my Pentium 4D (dual core) system, 3.2 GHz, I ran the cyclictest
application (which is something similar to the "latency" application of Xen=
omai/RTAI)
and I get values below 15 microseconds on my PC (for a single task running =
with 200 microseconds).

Using kernel 2.6.20.4 + Xenomai 2.3.1 I get similar results for the latency=
 application.

That means, that Ingo Molnar has done a real cool job in moving standard li=
nux in the direction
of a real time OS.

However, one thing is not as fine as with Xenomai/rtnet:
I want to do real time UDP communication from a user space application.
Unfortunately, I was not  able to do that as fast as with the Xenomai/rtnet=
 way.
My application does a kind of "ping-pong" with an embedded device that is c=
onnected as only
device to eth1 (Intel e1000 adapter).
Using Xenomai/rtnet I get request/response times at about 200 microseconds.

When I run an adapted application on the kernel with the preempt patch usin=
g the standard
linux UDP socket functions (sendto, recv), I get request/response times aro=
und 1 millisecond.
I have now the assumption that the TCP/IP stack that uses some internal tas=
ks is not running with
real time priority. However, I have no idea how to move that code to real t=
ime priority or if it makes
sense to move it as it is probably not possible to handle only communicatio=
n via a certain ethernet adapter=20
with real time priority and all other stuff (house keeping via TCP, differe=
nt Ethernet adapter)=20
with standard priority.
Has anybody an idea about the internal behaviour of this or how to continue=
 here?

Another approach could be to use a modified version of rtnet on base of the=
 preempt patched kernel.
This could allow to use the preempt patch kernel as base for all threads, a=
nd the rtnet is used
for real time Ethernet communication...
Is something like this possible or this there a major error in the approach=
?

Currently, my application is working quite nice using Xenomai/rtnet however=
 there are some
drawbacks like the issue with limited IRQs: Sharing of IRQs between Etherne=
t-Drivers of rtnet
and non-realtime drivers is not possible (at least I did not manage that...=
).
A smooth usage of real time features from a "standard" kernel could help he=
re!

Thanks for all feedback on this comment!

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


50=80 AMAZON-Einkaufsgutschein bei Bestellung von Arcor-DSL:
Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

