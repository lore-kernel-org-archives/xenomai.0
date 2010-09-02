Message-ID: <20100902042326.27700@domain.hid>
Date: Thu, 02 Sep 2010 04:23:26 -0400
From: "C Robinson" <starknight__@domain.hid>
Content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Validating installation of Xenomai
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

Hello,

I followed the suggested install procedure to setup a Xenomai kernel on my x=
86 Ubuntu system.  =

(http://www.xenomai.org/index.php/Building_Debian_packages)  =

I would like to verify that everything is hunky-dory, but I'm not quite sure=
 how.   I have read in some places that "user space" needs to be set up, alt=
hough this is not mentioned in the reference I followed.   Is this still nec=
essary?

The command:
	dmesg | grep Xenomai
Shows:	=

----------------------------------------------------------------------------=
---------------------------------
	[    0.659903] I-pipe: Domain Xenomai registered.
	[    0.659928] Xenomai: hal/i386 started.
	[    0.659942] Xenomai: scheduling class idle registered.
	[    0.659944] Xenomai: scheduling class rt registered.
	[    0.660450] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
	[    0.660570] Xenomai: starting native API services.
	[    0.660572] Xenomai: starting POSIX services.
	[    0.660599] Xenomai: starting RTDM services.
----------------------------------------------------------------------------=
---------------------------------

The command: =

	xeno-test
Is not quite so promising (there was more of the same text above and below t=
he output shown below):
----------------------------------------------------------------------------=
---------------------------------
2323:  A....
 2324:  A....
 2325:  A....
 2336:  G...V
 2337:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Thu Sep  2 09:40:44 CEST 2010
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
 2313:  W....
 2316:  W..X.
 2317:  GS...
 2338:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Thu Sep  2 09:40:44 CEST 2010
running: cat /proc/ipipe/version
2.7-01

Thu Sep  2 09:40:44 CEST 2010
running: generate_loads 1
dd workload started, pids 1970 stored in /var/lock/xeno-test.1829.pids
 1970 pts/0    00:00:00 dd
something died a 1970 or
something died a 1970 or
----------------------------------------------------------------------------=
---------------------------------

I am also attempting to follow the instructions to set up the examples (http=
://www.xenomai.org/index.php/Examples).    I extracted the examples to:
/usr/xenomai_egs/xenomai-head/examples/
so this would be the directory I would use for the first step. (Although I n=
otice that I also have something at /usr/share/xenomai/testsuite/unit/)  =


The second step, I come across the reference to 'user space', the step being=
:

make XENO=3D<xenomai-installation-path> KSRC=3D<xenomai-kernel-source>

I do not need a second argument (since I am in the patched kernel)
but the first argument is the user space directory.	=

So my next question is to check if the user space (i.e. the XENO variable) r=
efers to the directory /home/<user name>/xenomai-2.5.4 and if so, is it ok t=
o use my default user name? =


Many thanks,

Charles










