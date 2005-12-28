Message-ID: <43B30F30.9000603@domain.hid>
Date: Wed, 28 Dec 2005 23:18:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.4.32 compilation error + old timer
	example	problem
References: <43B1F5CE.7030407@domain.hid> <43B27936.2000108@domain.hid>
	<43B303A8.7010903@domain.hid> <43B30DB0.3080104@domain.hid>
In-Reply-To: <43B30DB0.3080104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3969FB51DC85D866DC0DF14F"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3969FB51DC85D866DC0DF14F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Hannes Mayer wrote:
> 
>> Hi Jan!
>>
>> Jan Kiszka wrote:
>>
>>> Hannes Mayer wrote:
>>>
>>>> I checked out xeno.trunk just a few minutes ago.
>>>> With kernel 2.4.32, kernel compilation fails with this:
>>>>
>>>> mq.c: In function `mq_notify':
>>>> mq.c:475: error: `SIGEV_SIVNAL' undeclared (first use in this function)
>>>> mq.c:475: error: (Each undeclared identifier is reported only once
>>>> mq.c:475: error: for each function it appears in.)
>>>>
>>>> kernel/xenomai/skins/posix/mq.c
>>>> SIGEV_SIVNAL => SIGEV_SIGNAL
>>>>
>>>> ..with that it succeeds.
>>>>
>>>> But still my timer example doesn't work - see:
>>>> https://mail.gna.org/public/xenomai-help/2005-12/msg00020.html
>>>>
>>>
>>>
>>> Is this problem only related to the periodic timer mode?
>>
>>
>>
>> I've modified my example with rt_task_set_periodic as in the
>> rt_serial_uprog example
>> http://www.captain.at/xenomai-timer-task.php
>> and this variant is working.
>> I'm just curious why the original example (#2 on my page) suddenly
>> stopped working (rt_task_sleep seems to do nothing, so the messages
>> from the task are flooding the screen).
> 
> 
> It would be nice to have the error codes possibly returned by
> rt_timer_start() and/or rt_task_sleep() if any.
> 

Yea, maybe that periodic timer mode is not compiled in and
rt_timer_start fails in your original example. I think it's off by
default now.

Jan

--------------enig3969FB51DC85D866DC0DF14F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsw80niDOoMHTA+kRAhBdAJ90lKNOXOWn39OMlVzVrUGTe0AnMQCeM565
l6FlpXalo+UpCQG4l8DDJtg=
=VCX2
-----END PGP SIGNATURE-----

--------------enig3969FB51DC85D866DC0DF14F--

