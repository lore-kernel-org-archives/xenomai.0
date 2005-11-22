Message-ID: <43837F37.8040406@domain.hid>
Date: Tue, 22 Nov 2005 21:27:35 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] define your own pipe heap
References: <4382201C.8040503@domain.hid>	<43825E4C.4030002@domain.hid>
	<4382F115.5010007@domain.hid>
	<4382F81D.8020303@domain.hid>
	<43830785.6010402@domain.hid> <43836DA2.90705@domain.hid>
In-Reply-To: <43836DA2.90705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B1DE5D9888C3C28DB0C90EE"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B1DE5D9888C3C28DB0C90EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> ...
>>>>> A patch says more than thousand words. ;)
>>>>>
>>>>> As a first approach, I picked the second variant and implemented a new
>>>>> function called rt_pipe_setpool. I also had to extend rt_pipe_alloc
>>>>> and
>>>>> rt_pipe_free so that the right pool is used by them.
>>>>>
>>>>
>>>>
>>>> I thought about this variant again, and it seems to me rather unsafe in
>>>> case some buffer allocation takes place between rt_pipe_create and
>>>> rt_pipe_setpool. So, here is a patch which extends rt_pipe_create
>>>> with a
>>>> new argument poolsize instead.
>>>>
>>>
>>> Yep, looks safer to me too.
>>>
>>
>>
>> Ok, I addressed most your comments, and here is round 2 of variant 2.
>> The only question for me is if we should rt_pipe_create in kernel space
>> from RT context with poolsize=0 if this is prevented effectively for
>> userspace task?
> 
> 
> This is not prevented for user-space, since there is an automatic switch
> to secondary mode caused by the lostage exec bit.

That's what I meant. Anyway, this doesn't change the situation:
rt_pipe_create is not called in primary context from userspace, so the
questions if we should allow this for kernelspace and poolsize=0.

> 
>  So far, I deny any non-RT invocation.
> 
>>
> 
> You likely mean, any non-Linux invocation.
> 

Of course, I did.

Jan

--------------enig9B1DE5D9888C3C28DB0C90EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDg388ncNeS9Q0k+IRAlrgAKCEbEP4NODAw8SMpw64BorfHRMx/wCfT/pV
yCcTcMfHF+1HSwLOlrXDnJ0=
=vo2U
-----END PGP SIGNATURE-----

--------------enig9B1DE5D9888C3C28DB0C90EE--

