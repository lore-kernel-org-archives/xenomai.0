Message-ID: <43BFF69C.4040705@domain.hid>
Date: Sat, 07 Jan 2006 18:13:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43BFB26F.8020409@domain.hid> <43BFF568.2030804@domain.hid>
In-Reply-To: <43BFF568.2030804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig56636877EF2512E6B656E0C0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] move RTDM headers
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
--------------enig56636877EF2512E6B656E0C0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi Philippe,
>>
>> this patches cleans up the include/rtdm folder by moving internal
>> headers to ksrc/skins/rtdm, leaving only rtdm.h, rtdm_driver.h, the two
>> profile headers, and syscall.h there. The latter is still only needed
>> for building Xenomai itself, thus it will not be installed. Successfully
>> built for 2.4 and 2.6. Additionally, I compiled latest RTnet SVN against
>> it without problems (x86, PPC is currently being fixed by Wolfgang).
>>
>> Please apply/move the involved headers and run bootstrap.
>>
> 
> This one broke the build here:
> 
> -- 
>   CC      kernel/xenomai/skins/rtdm/core.o
> kernel/xenomai/skins/rtdm/core.c:36:18: core.h: No such file or directory
> kernel/xenomai/skins/rtdm/core.c:37:20: device.h: No such file or directory
> -- 

Updated your repos? As you forgot to apply the moving, I also got
problems and applied my local versions of core.h, device.h, and proc.h,
also removing the three from their previous location.

> 
> Additionally, it's a really very bad idea to start including things like
> "core.h" removing the rtdm/ prefix, while other include files like
> nucleus/core.h exist. For the sake of readability, I'm going to revert
> this particular change at least.
> 

That's why I use #include "core.h", which -for me- clearly states: "Pick
the local one!" You will now have to tweak the Makefiles again...

Jan

--------------enig56636877EF2512E6B656E0C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDv/afniDOoMHTA+kRAnN0AKCAtsee+Ubk1HsqDrH/7F83b1KmswCfYk5b
lRPmCr99tkkWVSfPW6uoAa8=
=JPJ6
-----END PGP SIGNATURE-----

--------------enig56636877EF2512E6B656E0C0--

