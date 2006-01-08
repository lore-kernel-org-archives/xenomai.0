Message-ID: <43C153F4.5060502@domain.hid>
Date: Sun, 08 Jan 2006 19:03:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid>
In-Reply-To: <43C14453.3040907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BFF6B4A7703D7E25E7E126C"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BFF6B4A7703D7E25E7E126C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
> Jan Kiszka kirjoitti:
> 
>> Heikki Lindholm wrote:
>>
>>> Hi,
>>>
>>> Some recent changes (*cough* RTDM benchmark driver *cough*) broke kernel
>>> mode benchmarking for ppc64. Previously klatency worked fine, but now
>>> latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
>>> patches a comin'?
>>

To get this clearly: You tested the old klatency(+front-end) on latest
xeno and it worked? Or does this parse "the old klatency worked over old
xeno on PPC64"?

Comparing the old test with the new framework, the major difference is
that the old one only knew a single kernel RT-task. Its front-end was
reading from a pipe and was therefore a pure linux program. Now we have
two RT-tasks, one is even a shadow, and they use RT-IPC. Not sure if
this really means that the bug must be in the benchmark suite...

>>
>>
>> Nope, it should work as it is. But as Stelian also reported problems on
>> his fresh ARM port with the in-kernel test, I cannot exclude that there
>> /might/ be a problem in the benchmark.
>>
>> As I don't have any ppc64 hanging around somewhere, we will have to go
>> through this together. Things I would like to know:
> 
> 
> Dammit, I hoped you'd whip up a fix just from me noting a problem. Well,
> all right then, I'll play along...;)
> 
>>  o When and how does it crash? At start-up immediately? Or after a
>>    while?
> 
> 
> I inserted some serial debug prints and it gets two passes to
> eval_outer_loop done (enter/exit function). After that it freezes.
> Without the debug printing it dies with kernel access of illegal memory
> at xnpod_schedule, which btw. has been quite a common place to die.
> 
>>  o Are there any details / backtraces available with the crash?
> 
> 
> Becaktrace limits to xnpod_schedule if I remember right.
> 
>>  o Does -t2 work?
> 
> 
> Umm. Probably not. See below.

Arrgh, "probably" - when it's so easy to test...

When you are already on it: pure user-space (-t0) also works?

> 
>>  o What happens if your disable "rtdm_event_pulse(&ctx->result_event);"
>>    in eval_outer_loop (thus no signalling of intermediate results during
>>    the test)? Does it still crash, maybe later during cleanup now?
> 
> 
> Doesn't freeze and can be exited with ctrl-c and even re-run.
> 
> One odd thing (probably unrelated) is that the first two ioctls get
> called in what seems like wrong order, eg. START_TMTEST first ends up in
> tmbench_ioctl_rt and then _nrt and INTERM_RESULT ends up first in _nrt
> and then _rt.

This takes me back to the number of active real-time tasks during the
test. This disabling reduces the scenario basically again to old
klatency times.

I looked at my code again, but - maybe I'm too blind now - I cannot find
even a potential pointer bug, especially when the histogram feature (-h)
is not used. I need more input! ;)

Jan

--------------enig9BFF6B4A7703D7E25E7E126C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwVP0niDOoMHTA+kRAvn6AJ0bpw9SjAcR0GMoJb3x8sHolyYxHgCdEzSN
ddetV1xuFujCTfjazdr4pyY=
=bFTl
-----END PGP SIGNATURE-----

--------------enig9BFF6B4A7703D7E25E7E126C--

