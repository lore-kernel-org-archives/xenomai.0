Message-ID: <4C879AB9.6000907@domain.hid>
Date: Wed, 08 Sep 2010 16:16:25 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
In-Reply-To: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00717202DC3B7AA42233E4BF"
Subject: Re: [Xenomai-help] question about priorities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: charles.clerdan@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00717202DC3B7AA42233E4BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Charles,

On 08.09.2010 13:45, Charles Clerdan wrote:
> Hi,
>
>
> I have a technical question about priorities under Xenomai.
>
> According to my research, Xenomai use priority levels from 0 to 99. 99
> is the highest effective priority and 0 the lowest.
> But Linux uses levels from 0 to 139. For current task it uses levels
> 100 to 139 where 100 is highest priority than 139, and for "real time"
> threads 0 to 99 where 0 is highest than 99.s
> So when a task jumps in secondary modes is there a conversion of its
> own priority (100 - primary_mode_priority) or does she keep the same
> number.
> When two tasks with two different priorities are in secondary modes,
> is there a priority inversion between them or a crossed convertion of
> the priorities?

caution: I may be wrong, corrections welcome.

If you use the command 'ps -Ac' it will show you priorities from 0-139.
139 is best.

The low prio range 0-39 is for tasks scheduled with the default
SCHED_OTHER scheduling policy. Linux uses CFS (completely fair
scheduler) today for SCHED_OTHER. The priority of these task can be
changed using the command 'renice'. 'renice 19 <pid>' sets the priority
to 0. 'renice -20 <pid>' sets it to 39. 'renice 0 <pid>' to 19 (default).=


The priority range displayed as 40-139 is for linux "real-time" taks.
These are tasks handled with the SCHED_FIFO or SCHED_RR policy. To
change the scheduling policy of a process, you can use the 'chrt'
command. The real priority range of SCHED_FIFO or SCHED_RR is 0-99 (99
is best), but if you want to take the scheduling policy into account
like 'ps -Ac' does, a offset of 40 is added for these tasks, so 40-139
is displayed. If you have a SCHED_FIFO task with the lowest prio 0 and
you do a hard loop (bad idea) the SCHED_OTHER tasks don't get cputime
anymore.

Xenomai realtime tasks are SCHED_FIFO or SCHED_RR and have the same
priority range (0-99) as the linux "real-time" tasks. A xenomai
SCHED_FIFO task with prio 99 in secondary mode is handled equally as a
normal linux task with SCHED_FIFO and prio 99 by the linux kernel (prio
displayed as 139 with 'ps -Ac'). But a xenomai task with the lowest
priority 0 in secondary mode has still better prio than all the
SCHED_OTHER linux tasks. Xenomai tasks keep/have the same priority under
the realtime and the linux scheduler.

So the task scheduling priority is something like:
1. xenomai task in primary mode handled by the realtime scheduler
2. xenomai task in secondary mode or linux "real-time" task, both
handled by the linux scheduler, they compete
3. linux SCHED_OTHER tasks handled by the linux scheduler

Regards Stefan



--------------enig00717202DC3B7AA42233E4BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkyHmsAACgkQIPTw9rIdn6r4tQCeIW51B5GdphZEJI4HxkuoannN
VZQAn3dp3TifaPROVVlG0lsL0YRhmFYU
=olzD
-----END PGP SIGNATURE-----

--------------enig00717202DC3B7AA42233E4BF--

