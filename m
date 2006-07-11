Message-ID: <44B343AF.2030706@domain.hid>
Date: Tue, 11 Jul 2006 08:22:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9204@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F9204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2ED2A83E88666F5A911A442"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2ED2A83E88666F5A911A442
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
>> First of all, I'm not sure if that 8K of stack is enough on=20
>> PPC with 2.4, on x86 over 2.6 it isn't. The native skin picks=20
>> PTHREAD_STACK_MIN*4 for you by default. Is this too much?=20
>> Unless dealing with dozens of
>> *simple* threads, reducing this makes no sense to me.
>=20
> ?? Greping for PTHREAD_STACK_MIN xenomai/posix/pthread.h tells me,=20
> it is 1024. 1024*4=3D4096. This is less than 8192 ;-)

That's for the kernel-space usage of the posix skin. In user-space you
have to look at /usr/include:

/usr/include/bits/local_lim.h:#define PTHREAD_STACK_MIN 16384
(glibc-2.4, x86 of course)

> Is there a differnce between x86 and PPC.
> (I simply did not realize that there is a default value for=20
> the stacksize. Therfore I choose my own value, which was based on my=20
> vxWorks experince)

Again, that /might/ be fine on PPC, cannot tell.

>=20
>=20
>> Then there was this bug:
>>
>> @@ -168,13 +169,13 @@
>>  void root_thread_exit(void)
>>  {
>>     int i;
>> -   RT_HEAP_INFO *hpinfo;
>> +   RT_HEAP_INFO hpinfo;
>>
>>     printf("UDP->root_thread_exit\n");
>>
>>     for(i=3D0;i<MAXHEAPBLOCKS;i++)
>>     {
>> -      if( !rt_heap_inquire(&bigheap[i],hpinfo) )
>> +      if( !rt_heap_inquire(&bigheap[i],&hpinfo) )
>>           rt_heap_delete(&bigheap[i]);
>>     }
>=20
> Thank you ! 4 eyes see more than 2.
> (but this is probably not the reason for the segmentation fault, as=20
> this routine is called for exit only !?)

True.

> But even after correcting this error, I get segmentation faults (not
> with=20
> the first start but with the second or third)
>=20
>=20
>> Now I get some other strange effects (e.g. kernel oopses after OOM
>> oopses) that need a closer look under qemu later.
>=20

I re-tried the setup, but was "only" able to find a 2.6-kernel bug in
the OOM roll-back path of vmalloc (2.4 is unaffected). The other issue,
totally failing rt_heap_alloc, was not reproducable. I must have messed
something up on the test box at work.

So this means I cannot trigger your problem here on x86/2.6, sorry.

Jan


--------------enigF2ED2A83E88666F5A911A442
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEs0OwniDOoMHTA+kRAnkrAJ99cgZQ1yn0X53L3KN+pIqOSskgogCfdcYF
Inz6oFzeRNr+R/DJwoLMyrY=
=rBu3
-----END PGP SIGNATURE-----

--------------enigF2ED2A83E88666F5A911A442--

