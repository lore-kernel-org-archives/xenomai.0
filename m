Message-ID: <2ff1a98a0802080541q3a2326cdieffdacd190efab1c@domain.hid>
Date: Fri, 8 Feb 2008 14:41:30 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A014BAEAC93@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2220D86D21B55040AB683933DBD97B5A014BAEAC93@domain.hid>
Subject: Re: [Xenomai-help] Using rt_task_notify and rt_task_catch ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@viauc.dk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 8, 2008 at 12:09 PM, Hans S=F8ndergaard (HSO) <HSO@viauc.dk> wr=
ote:
>
>
>
>
> Thank you for an excellent answer Jan 23, 2008, about using periodic
> rt_tasks.
>
>
>
> Next I want to program sporadic/aperiodic tasks.
>
>
>
> My idea is to call rt_task_notify (& task, signal) when an event occurs.
>
>
>
> The task has a run-method doing something like:
>
>
>
>   for(;;)
>
>   {
>
>     rt_task_catch (&doSomeWork); // catch the event and call doSomeWork, =
-
> and then wait for next event
>
>    }
>
>
>
> But I can not get it work.

I am afraid the rt_task_notify/rt_task_catch mechanism is not
available in user-space.

You will have to use events (rt_event_wait/rt_event_signal) or
condition variables (rt_cond_wait/rt_cond_signal).

--=20
                                               Gilles Chanteperdrix

