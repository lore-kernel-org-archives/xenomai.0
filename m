Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Newbie question about MVM
Date: Mon, 28 Nov 2005 07:44:12 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB39CA02@domain.hid>
From: "Ashri, Sarit" <Sashri@domain.hid>
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

=20
Gilles Chanteperdrix wrote
>  > Hi,
>  > I'm new to Linux and Xenomai so excuse me if my question=20
> is trivial.
>  > Can I install and use the MVM on a Linux 2.4 workstation=20
> (Red Hat RHEL  > 2.1AS)  > that is not patched by Adeos?
>  > I'm having trouble installing it and I don't know if its=20
> because I'm  > doing something wrong,  > Or because its not=20
> supposed to work...
>  > I've searched the internet and could not find any answers.
>  > My target board is PPC and I use patched Linux 2.6.13.4=20
> with it +  > Xenomai 2.0.1 , cross  > Compiled with the=20
> flags: ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx.
>=20
> Let us make it clear: even if you are cross-compiling, the=20
> MVM will be built for your build system, not for your target=20
> system (host system, in autotools language).
>=20
> I tried to build MVM when cross-compiling and saw no=20
> problems. So, I guess you should try and explain us a bit=20
> more what kind of problems you are having.
>=20
> --=20
>=20
>=20
> 					    Gilles Chanteperdrix.
>=20
In the meantime my hard disk died, so it will probably take me a few=20
days getting my PC running again...
Thanks a lot for you help,
I at least understand the MVM concept a little better now so I will try
Playing around with it as soon as I have a computer again:-)
Sarit.
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

