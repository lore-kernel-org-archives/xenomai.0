Message-ID: <443533E3.6080305@domain.hid>
Date: Thu, 06 Apr 2006 17:29:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>
	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>
	<44352E12.1000502@domain.hid>
In-Reply-To: <44352E12.1000502@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29FC2FC1FB30D54A2F62115D"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29FC2FC1FB30D54A2F62115D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>>
>> Attached is an ipipe-freeze of the frozen system. It's taken at the ti=
me
>> the main thread of the terminating application has successfully
>> rt_task_join'ed the last remaining RT-thread. I took 2000 trace points=

>> before and after that point and additionally instrumented
>> rthal_timer_program_shot() (special trace 0x01, the argument is the
>> delay). The interesting stuff happens around 600 us after the freeze: =
it
>> seems the scheduled Linux timer arrives then but doesn't get much
>> attention beyond from ipipe.
>>
>> Any idea what to look for next? I have a "perfect" test system now,
>> though I still see no light at the end of the tunnel how to export it =
to
>> other boxes.
>>
>> Enough for today.
>>
>> Jan
>>
>>
>> PS: This trace was taken over 2.6.15 to exclude any issues with the ne=
w
>> 2.6.16. Both kernels show the same effect.
>>
>=20
> Does this patch make any difference?
>=20
> --- ipipe-root.c~    2006-01-31 09:55:44.000000000 +0100
> +++ ipipe-root.c    2006-04-06 17:01:49.000000000 +0200
> @@ -328,9 +328,8 @@
>          /* Only sync virtual IRQs here, so that we don't recurse
>             indefinitely in case of an external interrupt flood. */
>=20
> -        if ((ipipe_root_domain->cpudata[cpuid].
> -             irq_pending_hi & IPIPE_IRQMASK_VIRT) !=3D 0)
> -            __ipipe_sync_stage(IPIPE_IRQMASK_VIRT);
> +        if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0)
> +            __ipipe_sync_stage(IPIPE_IRQMASK_ANY);
>      }
>  #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
>      ipipe_trace_end(0x8000000D);

Nope.

Where should I put my finger on to find out what's happening?

Jan


--------------enig29FC2FC1FB30D54A2F62115D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENTPjniDOoMHTA+kRAh1cAJ9cKurMXhvq0/xXyQ/Wg98oya54YACbBsW/
vzbvb28SwnJMfzp1b00D/KA=
=I9DL
-----END PGP SIGNATURE-----

--------------enig29FC2FC1FB30D54A2F62115D--

