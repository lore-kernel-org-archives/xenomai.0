Message-ID: <435939B4.3090102@domain.hid>
Date: Fri, 21 Oct 2005 20:55:48 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid>	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>	<4357DF0F.3060806@domain.hid>
	<435896AA.1060103@domain.hid> <4358C829.5050304@domain.hid>
	<435919C8.6080906@domain.hid>
In-Reply-To: <435919C8.6080906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


>
> The real issue is only about extending the absolute timeout support to
> _all_ blocking primitives from the native API, or only to a single one
> for which there exists a clear POSIX counterpart (i.e. rt_cond_wait ->
> pthread_cond_timedwait). I'd like we focus on this issue instead. IOW,
> would rt_sem_p_abs() or rt_queue_recv_abs() be of any use?

Don't think so. Just liked the idea of an "orthogonal" API. Sometimes
it's simply easier to remember that wherever you specify a timeout you
can do it abs/rel than to remember that some sync primitives allow abs
and other don't.

Nacho.


