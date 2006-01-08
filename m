Message-ID: <43C16023.8010901@domain.hid>
Date: Sun, 08 Jan 2006 19:55:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
	<43C14453.3040907@domain.hid> <43C153F4.5060502@domain.hid>
	<43C15A7E.9050109@domain.hid>
In-Reply-To: <43C15A7E.9050109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCE9CF0AC7F663C06F3BE53A1"
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
--------------enigCE9CF0AC7F663C06F3BE53A1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
> Jan Kiszka kirjoitti:
> 
>> Heikki Lindholm wrote:
>>
>>> Jan Kiszka kirjoitti:
>>>
>>>
>>>> Heikki Lindholm wrote:
>>>>
>>>>
>>>>> Hi,
>>>>>
>>>>> Some recent changes (*cough* RTDM benchmark driver *cough*) broke
>>>>> kernel
>>>>> mode benchmarking for ppc64. Previously klatency worked fine, but now
>>>>> latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
>>>>> patches a comin'?
>>>>
>>>>
>>
>> To get this clearly: You tested the old klatency(+front-end) on latest
>> xeno and it worked? Or does this parse "the old klatency worked over old
>> xeno on PPC64"?
> 
> 
> "Previously" as in ... well ... previously, so it means the old xenomai
> with klatency intact.
> 
>> Comparing the old test with the new framework, the major difference is
>> that the old one only knew a single kernel RT-task. Its front-end was
>> reading from a pipe and was therefore a pure linux program. Now we have
>> two RT-tasks, one is even a shadow, and they use RT-IPC. Not sure if
>> this really means that the bug must be in the benchmark suite...
> 
> 
> Right. I'll have to see if there's a problem with any of these.
> 
>>>> o Does -t2 work?
>>>
>>>
>>>
>>> Umm. Probably not. See below.
>>
>>
>>
>> Arrgh, "probably" - when it's so easy to test...
> 
> 
> Well, it's one compile and boot cycle more with my current situation. I
> try to view laziness as a gift...
> 

Rebooting - sure, but what do you compile each time?

>> When you are already on it: pure user-space (-t0) also works?
> 
> 
> Pure user-space works fine.

Hmm, that's not so different from the POV of used nucleus mechanisms...

> 
>>>> o What happens if your disable "rtdm_event_pulse(&ctx->result_event);"
>>>>   in eval_outer_loop (thus no signalling of intermediate results during
>>>>   the test)? Does it still crash, maybe later during cleanup now?
>>>
>>>
>>>
>>> Doesn't freeze and can be exited with ctrl-c and even re-run.
>>>
>>> One odd thing (probably unrelated) is that the first two ioctls get
>>> called in what seems like wrong order, eg. START_TMTEST first ends up in
>>> tmbench_ioctl_rt and then _nrt and INTERM_RESULT ends up first in _nrt
>>> and then _rt.

Forgot to comment on this: It's a normal behaviour. The caller comes
across the first IOCTL in primary mode. But as this service is only
available to secondary mode, the invocation is restarted after a mode
switch. Same happens to the second IOCTL, just the other way around. If
you weren't lazy, I would suggest watching the different flow when
switching the mode manually first. ;)

>>
>>
>>
>> This takes me back to the number of active real-time tasks during the
>> test. This disabling reduces the scenario basically again to old
>> klatency times.
>>
>> I looked at my code again, but - maybe I'm too blind now - I cannot find
>> even a potential pointer bug, especially when the histogram feature (-h)
>> is not used. I need more input! ;)
> 
> 
> Hehe. The histogram was the first thing I peered at, only to find out
> it's not even used. This might be a kernel thread switching bug in my
> code, but I find it hard to believe, because then even one thread
> probably wouldn't work.

... and the userspace test with two threads should fail.

Another player in this game is the RTDM layer itself. But there is no
much of it involved, and it's not really arch-dependent code.

Jan

--------------enigCE9CF0AC7F663C06F3BE53A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwWAkniDOoMHTA+kRAgzQAJ9JQ3o4igfMc/qSiOGp6MPfyiI+LACfZXQt
O1ZllinWdTdiT//1YMZddx8=
=wYyn
-----END PGP SIGNATURE-----

--------------enigCE9CF0AC7F663C06F3BE53A1--

