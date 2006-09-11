Message-ID: <45052C04.5060006@domain.hid>
Date: Mon, 11 Sep 2006 11:27:32 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange segmentation fault
References: <44FFF19B.8080104@domain.hid>
	<17663.64654.650622.340750@domain.hid>
In-Reply-To: <17663.64654.650622.340750@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix escribi=F3:
> Ignacio Garc=EDa P=E9rez wrote:
>  >     r =3D rt_task_create(&_io_task, "rtcore_io_task", 0x1000, 10, T_=
FPU);
>
> Try replacing 0x1000 with say 32000 or 64000. printf uses the stack, so
> need enough room to operate properly.
>
>  =20
Yeah, I should have though about that. Stupid me. As I suspected, it was=20
something truly obvious.

Sorry, for the noise, guys.

Nacho.

