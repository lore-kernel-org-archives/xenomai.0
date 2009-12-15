From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <537fde640912141846s78bb2038m43bc8172a2cf2ae2@domain.hid>
References: <537fde640912141846s78bb2038m43bc8172a2cf2ae2@domain.hid>
Date: Tue, 15 Dec 2009 22:44:56 +0100
Message-Id: <20091215214456.2A5E31A00B@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] mpc8641_hpcn _driver mismatched
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yy Hong <yaanhyy@domain.hid>
Cc: xenomai@xenomai.org

Dear yy Hong,

In message <537fde640912141846s78bb2038m43bc8172a2cf2ae2@domain.hid> =
you wrote:
>=20
>     I wanna port kernel-2.6.27.41 from www.denx.de  patched  with
> xenomai-2.4.8 in my board. My target board is mpc8641_hpcn.
> I used kernel-2.6.27.38 from www.kernel.org in my board.It works. I con=
fig
> the kernel-2.6.27.41 in the same way.When kernel start up.
> It fails to identify the sata. Is the patch change the sata driver
> code?Shall I modify the driver or config kernel in a different way from=
 the
> normal kernel?

This is not a Xenomai related question at all. Try if the kernel.org
2.6.27.41 tree boots for you - there should be no difference between
this and our tree regarding the MPC8641HPCN.

If the (unpatched) mainline tree shows the same problem (which I
expect), then please post on the PPC mailing list.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
When you say "I wrote a program that crashed  Windows",  people  just
stare  at you blankly and say "Hey, I got those with the system, *for
free*".        - Linus Torvalds in <3itc77$9lj@domain.hid>

