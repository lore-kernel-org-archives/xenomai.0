Date: Mon, 23 Mar 2009 09:07:31 -0400
From: ravikiran.saralaya@domain.hid
Message-ID: <2578640.11237813651479.JavaMail.root@domain.hid>
In-Reply-To: <49C75BE3.3020709@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Support Adeos-patch for kernel ver 2.6.21/x86
Reply-To: ravikiran.saralaya@domain.hid
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

Hello Gillis,

Thanks for your response.=20

I went through the README file and tried building with various Adeos patche=
s for x86 architecture under /adeos/patches/v2.6/x86/older. I get error whi=
le executing ./prepare-kernel.sh.

Does this mean I should change to later version of kernel (other than 2.6.2=
1) for which a matching Adeos patch for x86 architecture is available?

Please clarify.

Thanks,
Ravikiran

-- Gilles Chanteperdrix wrote :=20
ravikiran.saralaya@domain.hid.... wrote:
> Hi,
>=20
> I have Mobilin (kernel 2.6.21) over Intel Atom. I am not able to find a s=
uitable Adeos patch for x86-architecture that supports above kernel version=
.
>=20
> I could only find =E2=80=9Cadeos-ipipe-2.6.20.21-i386-1.Y-ZZ.patch=E2=80=
=9D for i386.  Can I use this on Atom for building Xenomai?
>=20
> From the mailing lists, I see attempts being done to come-up with a patch=
 for 2.6.21 kernel. Not sure if x86-compatible patch is available though!
>=20
> Is a newer version of the patch compatible to older version of the kernel=
? For e.g., is =E2=80=9Cadeos-ipipe-2.6.24-x86-X.YY-ZZ.patch=E2=80=9D compa=
tible to kernel version 2.6.21?
>=20
> Thanks in advance for the clarification :)

See ksrc/arch/x86/patches/README in Xenomai sources.

--=20
                                                 Gilles.


_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid....
https://mail.gna.org/listinfo/xenomai-help

--
This message was sent on behalf of ravikiran.saralaya@domain.hid at openSubscr=
iber.com
http://www.opensubscriber.com/message/xenomai@xenomai.org

