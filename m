Message-ID: <47C2A484.4050006@domain.hid>
Date: Mon, 25 Feb 2008 12:20:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200802181213.29872.leo@domain.hid>
In-Reply-To: <200802181213.29872.leo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Debian package
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: Paul Corner <paul_c@domain.hid>, xenomai@xenomai.org

OK, to recall this message (and lift it to the list):

Leopold Palomo-Avellaneda wrote:
> Hi,
>=20
> this mail should be sent to Paul, but I would like to share with the xe=
nomai=20
> developers. Probably then should be sent to the xenomai-core list, but =
I have=20
> looked the list and it has a high traffic ("for me now") and I'm not a=20
> developer. So please, Gilles or Jan (or the admin to the list) accept t=
his=20
> message), I'm not subscriber.
>=20
> I have looked the debian package of xenomai. The package had a bug [1] =
that=20
> Paul commented before. Also, there's  another bug that pass unattended =
in=20
> that mail. For the first one, last week I asked to the debian-devel spa=
nish=20
> list and several people helped and finally Adeonato Sim=C3=B3 helped wi=
th a patch=20
> that solved this.

Paul, Gilles, can we apply the proposed fix to SVN (trunk+2.4.x, I
guess)? Or does it have some downside?

>=20
> For the second:
>=20
> E: xenomai: shell-script-fails-syntax-check ./usr/bin/xeno-test
>=20
> I think that the core developers should look on it. Executing:
>=20
> $ sh -n xeno-test
> xeno-test: line 404: syntax error near unexpected token `newline'
> xeno-test: line 404: `1. added -W <program invocation>'
>=20
> I have found this error, this part of the script seems a notes about it=
. Maybe=20
> it should be erased, or move, or comented, from the line 400 to the 430=
. If=20
> the lines are commented, then the test is ok.

Leo, is this an issue for a specific shell when calling without -n? Or
who does invoke xeno-text with -n so that we run into this error? It's
no problem to comment out the notes, I just want to understand the
background of this report.

>=20
> Now, again we have an active  rtai package, and I think that debian des=
erves a=20
> xenomai package. So,  please, could you look on it and apply the patche=
s=20
> proposed?
>=20
> Thank's ,
>=20
> Best regards,
>=20
> Leo
>=20
>=20
>=20
> [1] https://mail.gna.org/public/xenomai-help/2007-11/msg00135.html
> [2]=20
> http://www.mail-archive.com/debian-devel-spanish%40lists.debian.org/msg=
04209.html

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

