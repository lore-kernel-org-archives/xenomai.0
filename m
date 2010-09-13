Message-ID: <4C8E3203.3080005@domain.hid>
Date: Mon, 13 Sep 2010 16:15:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>	<4C8DE9CE.9050900@domain.hid>	<AANLkTik4rjQzwnU82OBudtkeS+kO+fbD1RjFXvXK7=qS@mail.gmail.com>	<4C8E118F.7010404@domain.hid>
	<AANLkTi=zxAy4wVyf2T_0XcxpnCkXRtApWhimmJO5hSFr@domain.hid>
In-Reply-To: <AANLkTi=zxAy4wVyf2T_0XcxpnCkXRtApWhimmJO5hSFr@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_queue_read and EPERM?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

Jens K=C3=B6hler wrote:
> Yes this is true. It is not a Xenomai task.

The documentation is a bit misleading, I agree, the paragram about
-EPERM is for kernel mode usage of rt_queue_read. In user-space mode,
EPERM is returned if the calling thread is not a Xenomai thread, before
even testing whether a message is available.

--=20
					    Gilles.


