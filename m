Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel OOps large appl.
Date: Tue, 31 Oct 2006 15:07:37 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D711@domain.hid>
In-Reply-To: <1162302219.4996.72.camel@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

Philippe Gerum wrote:

> This means that you are linking your application with the POSIX skin
> too. So your setup is UVM/psos library + POSIX skin support?=20
> Please send your Makefile, this should help understanding what's
> bound to your application.=20
>=20
Simply forget anything related to pSOS. There is no pSOS call anymore
inside the app. And we are not using pSOS skins and even have not
compiled the pSOS skin into the Kernel. Only the POSIX skin is used and
the native skin is compiled into the kernel so we can start the
testsuite.
We are using no modules. Everything is compiled into the kernel. See my
last mail with the attached configuration.

Our build environment is built around SCONS, so a Makefile alone
wouldn't be of any help. I rather would have to post the whole build
system ;) I am using the options in /usr/xenomai/bin/xeno-config
--posix-cflags and --posix-ldflags

> The stack trace does not even match the wrapped nanosleep syscall, so
> there is some strange interactions ongoing between the interfaces
> used. =20
>=20

What exactly you mean ?

> The setup for a lite5200 hw on a Denx 2.4.25 kernel should work out
> of the box. This is much more likely a software issue, maybe related
> to the strangenesses above. =20

We have our own 5200B board and the lite5200 setup doesn't work with our
hardware. In fact we had to tweak u-boot quite a bit to make it run on
the board.


Regards,

Daniel.

