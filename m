Message-ID: <44565A5B.5010703@domain.hid>
Date: Mon, 01 May 2006 20:58:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe latency tracer for ppc
References: <444FF092.2010002@domain.hid> <445656F0.2020800@domain.hid>
In-Reply-To: <445656F0.2020800@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig900F585C2297E4B25DEA9033"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig900F585C2297E4B25DEA9033
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
>>
>> As promised, the I-pipe tracer has been ported to ppc. People working
>> on this architecture are invited to give it a try, it's a great tool
>> to find out where the cycles are actually going.
>>
>> Just apply the tracer patch on top of the Adeos patch bearing the same=

>> revision number, and select the feature from the kernel configuration.=

>> If you happen to have some issue while booting the instrumented kernel=

>> on embedded setups (e.g. freeze after kernel decompression), try
>> reducing the size of the trace log (CONFIG_IPIPE_TRACE_SHIFT).
>>
>> http://download.gna.org/adeos/patches/v2.6/ppc/tracer/
>=20
> I gave it a try on a rather low-end PowerPC Walnut board (AMCC PowerPC
> 405GP, Rev. E at 200 MHz, 16 kB I-Cache 8 kB D-Cache). A nice tool,
> indeed, and it works fine. I have attached the results from running the=

> Xenomai latency "-t0" test with some load showing latencies up to 140
> us. The trace seems not to show any obvious problems, I think.
>=20
> Thanks.
>=20
> Wolfgang.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
>=20
> bash-3.00# cat /proc/ipipe/version
> 1.3-00
>=20
> bash-3.00# ./latency -p500
> =3D=3D Sampling period: 500 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> ...
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTS|      59.020|      67.260|     138.910|       0|    00:54:31/00:54:=
31
>=20
> bash-3.00# cat /proc/ipipe/trace/max
> I-pipe worst-case tracing service on 2.6.14/ipipe-1.3-00
> ------------------------------------------------------------
> Begin: 182095500 cycles, Trace Points: 192 (-10/+3), Length: 265 us
> =20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled)
>  |||||                       +---------- Delay flag ('+': > 1 us, '!': =
> 10 us)
>  |||||                       |        +- NMI noise ('N')
>  |||||                       |        |
>       Type   User Val.   Time    Delay  Function (Parent)
>      *fn                  -30    3.465  timer_interrupt+0x14 (__ipipe_d=
o_timer+0x30)
>      *fn                  -26    2.430  profile_tick+0x14 (timer_interr=
upt+0x130)
>      *fn                  -24    1.865  profile_hit+0x14 (profile_tick+=
0x78)
>      *fn                  -22    1.700  update_process_times+0x14 (time=
r_interrupt+0x13c)
>      *fn                  -20    3.505  account_system_time+0x14 (updat=
e_process_times+0xac)
>      *fn                  -17    2.195  update_mem_hiwater+0x14 (accoun=
t_system_time+0x78)
>      *fn                  -15    1.200  run_local_timers+0x14 (update_p=
rocess_times+0xb0)
>      *fn                  -14   11.905  raise_softirq+0x14 (run_local_t=
imers+0x30)
>      *fn                   -2    1.200  __ipipe_restore_root+0x14 (rais=
e_softirq+0x84)
>      *fn                   -1    1.095  __ipipe_stall_root+0x14 (__ipip=
e_restore_root+0x34)
>> |   *begin  0x80000000     0+   3.950  __ipipe_stall_root+0x98 (__ipip=
e_restore_root+0x34)
> :|   *fn                    3+   1.500  scheduler_tick+0x14 (update_pro=
cess_times+0x7c)
> :|   *fn                    5+   4.040  sched_clock+0x14 (scheduler_tic=
k+0x34)

This trace covers some long stall of the root domain, not the maximum
stall of the Xenomai domain that caused the 140 us above. See the
explanation for the stall bits above.

Maybe the maximum irq latency tracing is broken, I haven't tested it
with latest ipipe patch revision yet. Well, that max path should not
trigger on root-domain stalls as long as there is some higher priority
domain running - and it should have been reset on xenomai mounting. Hmm,
maybe only that reset does not work, please check by running "echo >
/proc/ipipe/trace/max" before the latency test.

You could also test if the -f option of latency works for you. You will
find the result of the back-trace freezing on max latency under
/proc/ipipe/trace/frozen. The number of back-trace points can be tuned
even after the event (only post-tracing required ahead-of-time tuning).

Jan


--------------enig900F585C2297E4B25DEA9033
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEVlpbniDOoMHTA+kRAuNhAJ9MCwgGciTGZH/OyVn7iPh+fhacSACggPJO
L86Q4078NnpcD58LG9jbr20=
=lOrF
-----END PGP SIGNATURE-----

--------------enig900F585C2297E4B25DEA9033--

