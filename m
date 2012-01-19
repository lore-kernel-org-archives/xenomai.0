Message-ID: <1326994144.4f1852e0aa680@domain.hid>
Date: Thu, 19 Jan 2012 18:29:04 +0100
From: mlkjhgfds@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai tests hanging
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


Hello,

Having trouble running tests on Xenomai 2.6.0 (trying to use analogy with=
 a NI
DAQ and getting errors after binding assumedly because the Xenomai instal=
l isn't
running properly)

xeno-test hangs and results in a kernel failure,
tried individual tests : cyclictest seemed ok, but latency and clocktest =
hang.

After a while the terminal shows what (I think?) were generic linux kerne=
l
messages from syslogd concerning the running interrupted processes (firef=
ox and
dbus-daemon), each displaying roughly

kernel : [238.372062] Process dbus-daemon
kernel : [238.372063] I-pipe domain linux
kernel : [238.372064] Stack :
kernel : [238.372078] Call Trace :
kernel : [238.372108] Code : <<bunch of numbers here>>

every 15 seconds or so.


The command
dmesg | grep Xenomai
shows what it's supposed to according to various online documentation

(along the lines of
root <at> ubuntu:~# dmesg | grep Xenomai
[    2.229354] I-pipe: Domain Xenomai registered.
[    2.229358] Xenomai: hal/i386 started.
[    2.229368] Xenomai: scheduling class idle registered.
[    2.229370] Xenomai: scheduling class rt registered.
[    2.229804] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
[    2.229806] Xenomai: debug mode enabled.
[    2.229877] Xenomai: starting native API services.
[    2.229878] Xenomai: starting POSIX services.
[    2.229899] Xenomai: starting RTDM services.)



Do you have any idea what could have gone wrong in the Xenomai installati=
on or
how to narrow it down ? (tried recompiling already and payed attention to=
 the
config recommendations) Could the use of the GNOME interface interfere wi=
th it ?

Thanks in advance!

