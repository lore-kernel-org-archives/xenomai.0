content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel
	2.6.20.4installation problem
Date: Fri, 30 Mar 2007 13:32:19 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202AC@FR0-MAILMB20.res.airbus.corp>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



 > > Hello everybody !
 > >=20
 > > I installed xenomai 2.3.0 on a FC6 linux distribution with vanilla ker=
nel 2.6.19.7 following the
 > > http://www.captain.at/xenomai-2.1-installation.php installation guide.=
=20
 > > It worked well until I install a new xenomai version (2.3.1) and linux=
 kernel (2.6.20.4)
 > > with the same kernel configuration than the first install.
 > > The compilation and installation passed but when I run the xeno-test p=
rogram, sometimes, it blocks
 > > at the begining and I have to reboot the PC. Also, the cyclic testsuit=
e program always blocks when I stop it pressing ctl-c.=20=20
 > > I have no problem with the latency test or others simple programs I ma=
de using rt_arlarm objects (I only use native skin).
 > >=20
 > > When I launch the ancient kernel (which worked before) I have the same=
 behaviour when I launch cyclic test and xeno-test.

 > This means that the problem lies in user-space. Could you launch
 > xeno-test with bash -x to see what command of xeno-test blocks ? And
 > attach gdb to the bloccked cyclictest to see where it is blocked ?

Strangely, I ran xeno-test 5 times and it did'nt hard lock.
I ran bash -x xeno_test and it froze twice at :
	+date
	ven mar 30 09:44:27 CEST 2007
	+ echo running: cat /proc/xenomai/interfaces/rtdm
	running cat....
	+ eval cat /proc/xenomai/interfaces/rtdm
	++ cat /proc/xenomai/interfaces/rtdm
	+ wait 2953

Another strange behaviour : I stopped the xeno-test program pressing ctl-C =
and I
entered commands in the console, and at the moment I heard the PC signal "b=
eep", the PC froze. (it occurred twice)

I attached gdb to the cyclictest but, the program is supposed to freeze whe=
n I stop it pressing ctl-C
and during debugging that only stops gdb and doesn't stop cyclictest.
So I tried to find where it is blocked using printf() into cyclictest sourc=
es. But when I run cyclictest and I press ctl-C
the PC doesn't freeze anymore but reboot. I restored the original cyclictes=
t version and ran it, the PC rebooted.
After I reinstalled xenomai (only /usr/xenomai) and when I stop the cyclict=
est, the PC reboots

 > >=20
 > > Note : When I installed 2.3.1 xenomai version over the ancien 2.3.0 ve=
rsion I only removed the=20
 > > old /usr/xenomai directory and launch the 2.3.1 xenomai installation. =
(Is there a better manner to unsinstall an older xenomai version?)

 > No, this method should work.

 > > (...)
 > > [niry@domain.hid ~]$ xeno-info
 > > If some fields are empty or look unusual you may have an old version.
 > > Compare to the current minimal requirements in Documentation/Changes.
 > >=20
 > > Linux localhost.localdomain 2.6.20.4-xenomai.2.3.1_29-03-2007 #1 Thu M=
ar 29 16:27:42 CEST 2007 i686 i686 i386 GNU/Linux
 > >=20
 > > Gnu C                  4.1.1

 > To rule out any compiler bug, could you try recompiling with a less
 > recent version ? Say gcc 3.3.x ?

I think it's my last solution. You want me to recompile the whole kernel or=
 only xenomai ?


 > --=20


 > 					    Gilles Chanteperdrix.

 > This mail has originated outside your organization, either from an exter=
nal partner or the Global Internet.
 > Keep this in mind if you answer this message.



This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.



