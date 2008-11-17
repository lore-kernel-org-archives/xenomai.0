Message-ID: <492176F7.5000405@domain.hid>
Date: Mon, 17 Nov 2008 14:51:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4921761C.5020204@domain.hid>
In-Reply-To: <4921761C.5020204@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] save FPU context in userspace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

C=E9dric Schaffter wrote:
> Hi List,
>=20
> I wrote an interrupt handler a few times ago. This handler is an idle=20
> task which use the function *rt_intr_wait(&intr_desc, TM_INFINITE).
> *
> The programm works fine, but I would like to know if I have to save the=20
> fpu context when an interrupt occurs and if there's a function to do it?

No, you do not have to care about that.

--=20
                                                 Gilles.

