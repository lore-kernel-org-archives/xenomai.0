From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>
References: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 28 May 2007 10:49:38 +0200
Message-Id: <1180342178.6188.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-05-28 at 09:43 +0200, Perrine Martignoni wrote:
> Hello,=20
> =20
> I just want to know if we can build Xenomai with the =B5Clibc ?
> And if API Posix run with =B5Clibc too?
> =20
> I have tried with the cross compiler EDLK with =B5Clibc and it doesn't
> work.

"It does not work" does not bring us much information. Any output from
the failing commands?

> When I build Xenomai, there is some errors.

Which are?

>  And after when I want to compile a code with API Posix, the error
> is :=20
> API Posix not available
> =20

Xenomai does not output such messsage. Is this verbatim?

> Is there someone who succeeded ?

Look at the README.INSTALL file, Blackfin section.

PS: and please don't forget that we don't sit on the chair next to you
in front of your desktop; i.e. we just can't see what's on your screen
right now. Your questions should be specific, with enough details to
allow people to help you, including versions of the major software
components you are talking about, the CPU architecture your work on at
the very least.

> Thanks
> =20
> =20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



