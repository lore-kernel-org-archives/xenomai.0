Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jul 2010 11:55:59 -0500
Message-ID: <181804936ABC2349BE503168465576460F3850F3@domain.hid>
In-Reply-To: <4C34AD18.9090902@domain.hid>
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid> 
	<4C347815.9050107@domain.hid> 
	<181804936ABC2349BE503168465576460F384F38@domain.hid> 
	<4C34AD18.9090902@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
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

> I already answered that: yes, the thread will re-acquire the=20
> mutex. The pthread_cleanup_push/pthread_cleanup_pop services=20
> can be called from a native skin thread, they are part of the=20
> glibc, not of Xenomai posix skin, so you do not need to link=20
> against the Xenomai posix skin library.
>=20
> Anyway, the proper way to fix this, which we use in the POSIX=20
> skin, is to set the cancellation type to asynchronous just=20
> before calling rt_cond_wait, saving the previoys cancellation=20
> type, then restore the cancellation type after rt_cond_wait.

This is probably the best solution for me.  Can I also use
pthread_setcanceltype without linking to the POSIX skin or is there some
method in the native skin to change the cancellation type?  Can I assume
anything not wrapped in the posix.wrappers is provided by glibc?

Thanks.

