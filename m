Message-ID: <4EAC8885.6070107@domain.hid>
Date: Sun, 30 Oct 2011 01:13:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjMmOjq5mrGJ2E5m9oz0HeCP+6UJ8f7aziXcACPuAKM4PzQ@mail.gmail.com>
In-Reply-To: <CAAeYjMmOjq5mrGJ2E5m9oz0HeCP+6UJ8f7aziXcACPuAKM4PzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai on em2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 10/29/2011 10:38 PM, =C5=81ukasz Sacha wrote:
> Hello!
>=20
> I'm just starting to play with xenomai. My first goal is to install it
> on my em2440 (similar to mini2440) board.
> I could use some solid guidelines on where to start as there are many
> tutorials out there - on mini2440, on xenomai, on arm, on i-pipe and I
> don't even know which should I follow.
>=20
> So please be patient with me and please help me get started.

I would recommend downloading xenomai 2.6.0-rc5 (soon to be release
2.6.0), and follow the installation guidelines called README.INSTALL in
the tarball. The instructions are for ARM in general, but there is not
much specific to a board or SOC, except the kernel configuration.

If you have some issue once xenomai is installed, you can try the
TROUBLESHOOTING file contained in the tarball, or the FAQ, if that does
not help you ask questions on the mailing list (you can also try to
browse the mailing list archives for similar issues).

Then, you will have to choose which skin you want to use, if it is
posix, you may read the following document:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
If you choose the native skin, you may read the following document:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf

Finally, for detailed api documentation, try the doxygen API
documentation available here:
http://www.xenomai.org/documentation/xenomai-head/html/api/index.html

We keep links to all these documents when you click "Start here", on
xenomai main page.

Regards.

--=20
                                                                Gilles.


