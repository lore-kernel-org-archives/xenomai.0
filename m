Date: Fri, 16 May 2008 13:07:30 +0200
Message-Id: <1165752632@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?at91sam9263_and_user-space_support?=
 =?iso-8859-15?q?_compile_fails?=
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

I have found some debug flags.
Now the vmlinux is smaller but still to big

-rwxr-xr-x 1 paradoxxa paradoxxa 4,8M 16. Mai 12:36 vmlinux
-rwxr-xr-x 1 paradoxxa paradoxxa 1,7M 16. Mai 12:36 arch/arm/boot/compress=
ed/vmlinux



-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 16.05.08 11:58:24
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls



The vmlinux that really matters is arch/arm/boot/compressed/vmlinux

--=20
 Gilles

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Unbegrenzter Speicherplatz f=FCr Ihr E-Mail Postfach=3F Jetzt aktivieren!
http://freemail.web.de/club/landingpage.htm/=3Fmc=3D025555


