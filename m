Message-ID: <45C9F2F9.3020204@domain.hid>
Date: Wed, 07 Feb 2007 16:40:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] system() question
References: <45C9F9CD.6000101@domain.hid>
In-Reply-To: <45C9F9CD.6000101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

St=E9phane ANCELOT wrote:
> Is there a way to launch my realtime task from another linux program=20
> using system() C call ?
>=20
> I have tried it , but when system call dies my rt task dies too ...
> any idea ?

Why does the system call die ? Do you observe the same behaviour with
non xenomai applications ?

--=20
                                                 Gilles Chanteperdrix

