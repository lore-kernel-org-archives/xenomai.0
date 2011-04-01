MIME-Version: 1.0
In-Reply-To: <4D95B8E3.601@domain.hid>
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
	<1301412534.2109.24.camel@domain.hid> <4D922EF5.8020808@domain.hid>
	<1301426227.2109.35.camel@domain.hid> <4D9230C5.7050007@domain.hid>
	<1301426830.2109.41.camel@domain.hid> <4D923306.60409@domain.hid>
	<1301461081.2092.14.camel@domain.hid>
	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>
	<1301472945.2092.21.camel@domain.hid>
	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
	<4D948F87.9010109@domain.hid> <4D9494B6.6040304@domain.hid>
	<AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
	<1301656855.2155.232.camel@domain.hid> <4D95B8E3.601@domain.hid>
Date: Fri, 1 Apr 2011 15:07:04 +0200
Message-ID: <AANLkTik3OaRoHh5AePs+jjX4z1p2_-8GzRfWnApHDFmF@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Apr 1, 2011 at 1:37 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Philippe Gerum wrote:
>> (*) Unless I find a way to direct the linux scheduler to the "right"
>> task in the migration case, but so far, I found none (none that would be
>> sane, I mean).
>
> In Henri particular case. Maybe there would be a way to call
> wake_up_process first, then look into the (Linux) scheduler state, see
> if a reschedule is pending. If a reschedule is pending, do not clear the
> boost and let do_schedule_event handle the situation? Otherwise, clear
> the boost.
>
> Or maybe that fits into the "insane" category?
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

Thanks Philippe and Gilles! Your detailed explanation brings the
pieces of the puzzle together! I understand why the reschedule is
needed there. And that indeed Priority coupling is broken by design
then: most likely the thread running in the Linux domain at the time a
Xenomai thread is relaxed is not a Xenomai thread. The reschedule will
then always schedule any runnable Xenomai task before the relaxed
thread in Linux domain.
Priority coupling can never guarantee rule #1, also because a Linux
call might block.

However, it would be great to find a way to direct the Linux
scheduler, maybe the way Gilles proposed. Then at least rule #1 would
be valid until the relaxed task blocks or reschedules... but of course
will never be guaranteed..

Kind regards,
Henri.

