Message-ID: <43E32E6F.10301@domain.hid>
Date: Fri, 03 Feb 2006 11:20:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>	<43E30B8D.6030507@domain.hid>
	<43E31186.1000007@domain.hid> <43E31EE0.8020808@domain.hid>
	<43E323CC.4040306@domain.hid> <43E329DF.4010403@domain.hid>
In-Reply-To: <43E329DF.4010403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A2DC2B7AC805883DC781A82"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A2DC2B7AC805883DC781A82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Anders Blomdell wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> ...and may also add further latencies with the system has to speed u=
p
>>>> again. Anyway, there might be use-cases where power consumption is -=

>>>> besides latency - also an important issue. I'm just thinking of our
>>>> smaller mobile robots where the power demand of the drives and the
>>>> controller are not that far apart as on the larger platforms.
>>>>
>>>> What about other time sources on x86? Which systems already have HPE=
T
>>>> these days, and does this source not suffer from frequency scaling? =
I
>>>> once read that HPET is quite easy to program, is this true? IOW, wou=
ld
>>>> it be worth considering to add this to the HAL?
>>>
>>> If it an computer with ACPI (which is very likely), one could use the=
 PM
>>> Timer (3.579545 MHz) as the base system clock, and sync with TSC at
>>> every clockscaling and power events (the reason for that is that PM
>>> Timer reads  are quite slow (around 1 microsecond on the hardwares I
>>> have tested), so most timer stuff should go via TSC).
>>>
>>> The advantage with this is that the system will keep accurate time ev=
en
>>> in the low power modes (when TSC is turned off). I have done a crude
>>> implementation of this on KURT (http://www.ittc.ku.edu/kurt/), and it=
 is
>>> a workable solution
>>
>>
>> Oh, KURT still exists? Appeared a bit unmaintained to me last time I
>> checked.
> Maintained, but results are unfortunately not propagated to their
> homepage. We are currently running a 2.6.12 version, which is (for our
> purposes) essentially is Ingo Molnars patches + microsecond timer
> resolution.

But I guess you are then running a quite old version of the
RT-patch-set. Or is there still anything in the utime-patches (besides
your PM-add-on) that the hrtimer does not provide? Cannot imagine
because Thomas (Gleixner) was so deeply involved in KURT that he will
likely have extracted all relevant features for his hrtimers.

>=20
>>> There are also good research/development oppurtunities in:
>>>
>>>  1. scheduling ACPI wakeup from those low-power modes in such good
>>>     time that all realtime requirements are met :-)
>>>  2. scheduling of clockscaling changes to make minimum impact
>>>     on realtime tasks
>>>
>>> (For ACPI, see http://www.acpi.info/DOWNLOADS/ACPIspec30a.pdf)
>>>
>>
>>
>> Hmm, though likely feasible, this sounds like it requires some effort,=

>> especially the infrastructure to access ACPI directly (I guess we woul=
d
>> still have to switch it off for Linux, wouldn't we?) and to set up the=

>> power event hooks.=20
> Or present our own virtual ACPI controller to Linux, and enforce our
> timing constraints while trying to keep power as low as Linux want us t=
o.

Hmm, sounds again like a lot of work - but it's attractive because it
would be clean. ;)

>=20
>> How much code was involved in your KURT add-on? Can
>> you extract it as a patch to asses the required work? I'm not planing =
to
>> work on this, but if it is not too complicated, someone may once pick =
it
>> up and integrate it in Xenomai.
> I guess this is approximately the patch (which always reads the PM
> Timer, which is not good for performance). It also does nothing to
> prevent Linux from doing Power management, the only thing it does, is t=
o
> keep wall time and computer time in sync.

Ah, these patches do not look that complicated. If I find some time to
study them, I may come up with further questions.

Thanks,
Jan


--------------enig0A2DC2B7AC805883DC781A82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4y5vniDOoMHTA+kRAk/lAJ9nDIl4CW3G5JEfKYhI0GELX+F7IgCcDwUV
kbSzkCGdWJiFRrHUDR11Wgc=
=0pxq
-----END PGP SIGNATURE-----

--------------enig0A2DC2B7AC805883DC781A82--

