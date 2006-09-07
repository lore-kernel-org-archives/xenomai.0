From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17663.64654.650622.340750@domain.hid>
Date: Thu, 7 Sep 2006 13:03:42 +0200
Subject: Re: [Xenomai-help] Strange segmentation fault
In-Reply-To: <44FFF19B.8080104@domain.hid>
References: <44FFF19B.8080104@domain.hid>
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
 >     r =3D rt_task_create(&_io_task, "rtcore_io_task", 0x1000, 10, T_FP=
U);

Try replacing 0x1000 with say 32000 or 64000. printf uses the stack, so
need enough room to operate properly.

--=20


					    Gilles Chanteperdrix.

