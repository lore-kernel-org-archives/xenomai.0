Message-ID: <2890274.1166696466862.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 11:21:06 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <458A4DE0.5030005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56294_1053002.1166696466861"
References: <458A4DE0.5030005@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

------=_Part_56294_1053002.1166696466861
Content-Type: multipart/alternative; 
	boundary="----=_Part_56293_4238538.1166696466861"

------=_Part_56293_4238538.1166696466861
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan, hi everybody,

I have stripped down my program that is crashing Xenomai even further.
(I have attached the complete source code).
No rtnet is required.
Now I have the following real time task:

static void realtimetask(void *arg)
{
    system("ls -l");
    rt_task_sleep(1000000000ULL);
    printf("rt_task_sleep done...\n");
}

This leads to a complete freeze of the PC on a 2.6.19.1 kernel using the la=
test
Xenomai (from SVN) and the included adeos-patch.
I never had this issue on 2.6.17.* kernel.

Unfortunately this seems to occur only on fast Pentium 4 machines...
Is there anybody out there that can reproduce it?

Thanks for all feedback on this!

Mathias

> > meanwhile I have done a couple of additional tests.
> > With one of the PCs I have, I have disabled the Memory Cache to slow it
> down.
> > The effect was the very same.=20
> > I have reproduced the behaviour on another PC (also P4, but different
> mainboard).
> > The system freezes as well.
> > And finally, I have found out that printing out a line with printf()
> directly after the system() call provides
> > a workaround.Then the system is stable.
> >=20
> > I have replaced the system() call where I called rtroute with a simple
> call to "ls -l" (i.e system("ls -l") ).
> > Then the system freezes as well.
> > It looks to me as if a system() call out of the realtime task is not
> properly handled.
> > An printf() after the system() call seems to move the system back on
> track...
> >=20
> > Hope that helps a little bit to identify the issue...
>=20
> Unfortunately not yet. I tried with exactly the same configuration you
> once mailed on a Pentium M 1.3 GHz - but all worked fine. The obvious
> differences are the CPU speed (I may have access to a crash box with
> more GHz next week) and the NIC (rt_eepro100 in my case).
>=20
> As my hope of being able to reproduce it on my own is not that high, I
> would like to ask you to try nailing down the lock-up on kernel level.
> That means trying to identify (via printk e.g. - if this doesn't make
> the bug jump around) which function is still executed and where we do
> not get.
>=20
> TIA,
> Jan


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_56293_4238538.1166696466861--

------=_Part_56294_1053002.1166696466861
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=xeno_crash.tgz

H4sIAJReikUAA+2WbXPiNhDHeRt9ii2QG7uDjU0gdLjQKXHI9a5cyBCYdqbtMMYWoEbYjCxnctPe
d+/KGDDpXe8Fl/RF9Zs8SKv1anct/eGRRvE0EH6ytIPSM+Eg582m+u+2W042dzfzbNh2nJLrtJqN
Zuu83XRLjttoNZolcJ4roSJpIn0BUOL+LPDFv/lRkbxEQi9LhUUBT0MKF4kMOZvZy+/Jgc0Xi0Nb
GjE0P/H7kNRXKz9S1oI58iV7oHXpJ/fZCsFeSxbAaDwd9+5+AiHV0muyX3mIWQiC+lyyFVWLRmb5
FrMwyZ8EENxL0pVR5glYvGy+zoxCTpX3NOGUrg3X2TIZDHKPtWCRnBvlA08I44jatv1bpAKRj4Sg
E6x8FhlqgLsGNQiWeEBUBg+//r5NIvujXEQAXXDwWWVY8Ti49zk33nuDqTcZjfo3Y/gL1Ox6Mp6M
+mbumKeZp7YJmZWhom0zDLAPkhqvNl2qQTm7ppImslwDpwbf4e94en07wS3GU+92YjhmNnw3fHvT
uxz08/BZqnMwMPgFOObOtt/2U/3Z7A5zn3EagnHKTGxSDTMsRN2lfHZoW8Qyhv7N1XR4jYXfePvV
j58uVd1Bua/0VfEEYK1HFZLF/vp1kH05253+iPHc5EUUohNSCNHZnZ6DU9lbrzkL8ArEEUgqVgyv
Dg1tzKp7yg4TFlSmIsJ5dmCPvf/v/Xs6x9Z8DS35HF/S/0arudX/dsNtof67521H6/9LUIHKsZAK
bE8RzGMBfdR2GPgzD/s6yi8y3HrodsUEDWQsPnTArrPY8kN/jae9ThPXPXPQwQhMaDjO2SbGm9Xs
xxr0OAfBFkuZ4NHHl/CA9wJd1Q8hj/j1xQriaM4W0OlCPU1EXdlQwuszFtUL64QML9914XH/hScG
0v+lXzSpTyLPG96OVbCqkSwpbl41ClFMsKzNdM79RYLTBVg/o+aDNWxgRoOr60HvzZ163uKbz78v
BOLhk0hERRm8vbzrWnwtl6iFITnqNeHTo5TT5KgoBDPrYAnYMRPr3AyUAbtqkpOq4XlYQgzVH6B6
gea8EaZqacCpH3XIiSVWYM3zZ/JYav3UjjundrCLEuQtVVN8Geh6QcjJ0Vqn+SfqCIo0etY9lMi3
W63P6T+O3Z3+u855pv/Nltb/l6DyTaaTs0z8VnG4FvGMbhQxSvHepslTa6ZphAbLGMqjNIpYtCgo
aJnY9QM9/a8L1Gg0Go1Go9FoNBqNRqPRaDQajUaj+Z/xN52taH0AKAAA
------=_Part_56294_1053002.1166696466861--


