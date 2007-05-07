Message-ID: <463F2F14.1000205@domain.hid>
Date: Mon, 07 May 2007 15:52:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid> <463EEA4A.1070405@domain.hid>
	<463F1468.8010403@domain.hid> <463F178D.4020805@domain.hid>
	<463F1D99.5090208@domain.hid>
In-Reply-To: <463F1D99.5090208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig491DA500EEEE61A3CA327BE1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig491DA500EEEE61A3CA327BE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
-snip-
> :|  # func               -1916    0.512  xntimer_do_tick_aperiodic+0x14=
 [xeno_nucleus] (xnpod_announce_tick+0x48 [xeno_nucleus])
> :|  # func               -1916    0.463  xnthread_periodic_handler+0x14=
 [xeno_nucleus] (xntimer_do_tick_aperiodic+0x2c0 [xeno_nucleus])
> :|  # func               -1915    0.609  xnpod_resume_thread+0x14 [xeno=
_nucleus] (xnthread_periodic_handler+0x5c [xeno_nucleus])
> :|  # [ 1160] -<?>-   79 -1915    0.878  xnpod_resume_thread+0x78 [xeno=
_nucleus] (xnthread_periodic_handler+0x5c [xeno_nucleus])
> :|  # func               -1914    0.365  xnpod_schedule+0x14 [xeno_nucl=
eus] (xnintr_irq_handler+0x1fc [xeno_nucleus])
> :|  # [    0] swapper -1 -1913+   1.829  xnpod_schedule+0xb8 [xeno_nucl=
eus] (xnintr_irq_handler+0x1fc [xeno_nucleus])
> :|  # [ 1160] -<?>-   79 -1912    0.829  xnpod_schedule+0x420 [xeno_nuc=
leus] (xnpod_suspend_thread+0x20c [xeno_nucleus])
> :|  # func               -1911    0.390  xntimer_get_raw_clock_aperiodi=
c+0x14 [xeno_nucleus] (xnpod_wait_thread_period+0xd0 [xeno_nucleus])
> :|  # func               -1910    0.317  __ipipe_restore_pipeline_head+=
0x14 (xnpod_wait_thread_period+0x130 [xeno_nucleus])
> :|  + end     0x80000000 -1910+   1.878  __ipipe_restore_pipeline_head+=
0xd4 (xnpod_wait_thread_period+0x130 [xeno_nucleus])
> :|  + begin   0x80000001 -1908    0.414  __ipipe_dispatch_event+0x1e4 (=
__ipipe_syscall_root+0x64)
> :|  + end     0x80000001 -1908!  52.121  __ipipe_dispatch_event+0x204 (=
__ipipe_syscall_root+0x64)
> :   + func               -1857+   1.170  do_page_fault+0x14 (handle_pag=
e_fault+0xc)

This one is interesting: page fault over the RT-thread that belongs to
PID 1160 (prio 79).

> :   + func               -1856    0.487  __ipipe_dispatch_event+0x14 (d=
o_page_fault+0x188)
> :|  + begin   0x80000001 -1855    0.926  __ipipe_dispatch_event+0x27c (=
do_page_fault+0x188)
> :|  + end     0x80000001 -1854    0.585  __ipipe_dispatch_event+0x1a4 (=
do_page_fault+0x188)
> :   + func               -1854    0.975  exception_event+0x14 (__ipipe_=
dispatch_event+0x1bc)
> :   + func               -1853    0.609  xnarch_trap_fault+0x14 [xeno_n=
ucleus] (exception_event+0x88)
> :   + func               -1852    0.902  xnpod_trap_fault+0x14 [xeno_nu=
cleus] (xnarch_trap_fault+0x38 [xeno_nucleus])
> :   + func               -1851    0.878  xnpod_fault_handler+0x14 [xeno=
_nucleus] (xnpod_trap_fault+0x68 [xeno_nucleus])
> :   + func               -1851    0.536  xnshadow_relax+0x14 [xeno_nucl=
eus] (xnpod_fault_handler+0x98 [xeno_nucleus])
> :|  + begin   0x80000001 -1850+   1.073  xnshadow_relax+0x15c [xeno_nuc=
leus] (xnpod_fault_handler+0x98 [xeno_nucleus])
> :|  # func               -1849+   1.292  schedule_linux_call+0x14 [xeno=
_nucleus] (xnshadow_relax+0x7c [xeno_nucleus])
> :|  # func               -1848    1.000  rthal_apc_schedule+0x14 (sched=
ule_linux_call+0xc8 [xeno_nucleus])
> :|  # func               -1847+   1.609  __ipipe_schedule_irq+0x14 (rth=
al_apc_schedule+0x10c)
> :|  # func               -1845+   1.585  rpi_push+0x14 [xeno_nucleus] (=
xnshadow_relax+0x84 [xeno_nucleus])
> :|  # func               -1844    0.463  xnpod_schedule_runnable+0x14 [=
xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])
> :|  # [    0] swapper 79 -1843+   1.658  xnpod_schedule_runnable+0x54 [=
xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])

And now we are running the Linux kernel at xeno-prio 79 (due to
prio-coupling).

/me has to leave, other may jump in.

Jan


--------------enig491DA500EEEE61A3CA327BE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGPy8UniDOoMHTA+kRAt3AAJ9XmEeO0dNMBMPVBgM9hC16KlmNQQCeMyVZ
CEyHaEnHVE8aKtt3iKT+AVg=
=FOFZ
-----END PGP SIGNATURE-----

--------------enig491DA500EEEE61A3CA327BE1--

