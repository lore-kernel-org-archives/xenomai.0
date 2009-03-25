From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <73A4F0FC6A6416469CCECF0E83917EA30158293E@exfp1.Railpowertech.local>
References: <73A4F0FC6A6416469CCECF0E83917EA30158293E@exfp1.Railpowertech.local>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Mar 2009 19:19:10 +0100
Message-Id: <1238005150.6815.82.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] cant' handle reloc type 0xe in librtdm.so.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Bennett, Adam" <ABennett@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-03-25 at 14:14 -0400, Bennett, Adam wrote:
> Hello,
>=20
> I am upgrading from svn branch 2.4.x to trunk and an now getting the
> following error:
>=20
> symbol 'xeno_current':  can't handle reloc type 0xe in lib
> '/usr/local/xenomai/lib/librtdm.so.1'
>=20

try --without-__thread when building the userland libs.

> Has anyone encountered this?
>=20
> I am using uclibc 0.9.30.1.
>=20
> Adam
>=20
>=20
>=20
> This e-mail communication (and any attachment/s) may contain
> confidential or privileged information and is intended only for the
> individual(s) or entity named above and to others who have been
> specifically authorized to receive it. If you are not the intended
> recipient, please do not read, copy, use or disclose the contents of
> this communication to others. Please notify the sender that you have
> received this e-mail in error by reply e-mail, and delete the e-mail
> subsequently.=20
> Thank you.=20
> _______________________________________________________________________=
__________________________________________=20
>=20
> Ce message (ainsi que le(s) fichier/s), transmis par courriel, peut
> contenir des renseignements confidentiels ou prot=C3=A9g=C3=A9s et est =
destin=C3=A9 =C3=A0
> l=E2=80=99usage exclusif du destinataire ci-dessus. Toute autre personn=
e est
> par les pr=C3=A9sentes avis=C3=A9e qu=E2=80=99il est strictement interd=
it de le
> diffuser, le distribuer ou le reproduire. Si vous l=E2=80=99avez re=C3=A7=
u par
> inadvertance, veuillez nous en aviser et d=C3=A9truire ce message.=20
> Merci.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



