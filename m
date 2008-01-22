Message-ID: <4796643D.7010208@domain.hid>
Date: Tue, 22 Jan 2008 22:46:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<18326.21459.333811.155772@domain.hid>
In-Reply-To: <18326.21459.333811.155772@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A1DACE8EC684EB9926AACB4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] High latencies on ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A1DACE8EC684EB9926AACB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Hi,
>  >=20
>  > after some (unsuccessful) time trying to instrument the code in a wa=
y
>  > that does not change the latency results completely, I found the
>  > reason for the high latency with latency -t 1 and latency -t 2 on AR=
M.
>  > So, here comes an update on this issue. The culprit is the user-spac=
e
>  > context switch, which flushes the processor cache with the nklock
>  > locked, irqs off.
>  >=20
>  > There are two things we could do:
>  > - arrange for the ARM cache flush to happen with the nklock unlocked=

>  > and irqs enabled. This will improve interrupt latency (latency -t 2)=

>  > but obviously not scheduling latency (latency -t 1). If we go that
>  > way, there are several problems we should solve:
>  >=20
>  > we do not want interrupt handlers to reenter xnpod_schedule(), for
>  > this we can use the XNLOCK bit, set on whatever is
>  > xnpod_current_thread() when the cache flush occurs
>  >=20
>  > since the interrupt handler may modify the rescheduling bits, we nee=
d
>  > to test these bits in xnpod_schedule() epilogue and restart
>  > xnpod_schedule() if need be
>  >=20
>  > we do not want xnpod_delete_thread() to delete one of the two thread=
s
>  > involved in the context switch, for this the only solution I found i=
s
>  > to add a bit to the thread mask meaning that the thread is currently=

>  > switching, and to (re)test the XNZOMBIE bit in xnpod_schedule epilog=
ue
>  > to delete whatever thread was marked for deletion
>  >=20
>  > in case of migration with xnpod_migrate_thread, we do not want
>  > xnpod_schedule() on the target CPU to switch to the migrated thread
>  > before the context switch on the source CPU is finished, for this we=

>  > can avoid setting the resched bit in xnpod_migrate_thread(), detect
>  > the condition in xnpod_schedule() epilogue and set the rescheduling
>  > bits so that xnpod_schedule is restarted and send the IPI to the
>  > target CPU.
>=20
> Please find attached a patch implementing these ideas. This adds some
> clutter, which I would be happy to reduce. Better ideas are welcome.
>=20

I tried to cross-read the patch (-p would have been nice) but failed -=20
this needs to be applied on some tree. Does the patch improve ARM=20
latencies already?

>=20
>  >=20
>  > - avoid using user-space real-time tasks when running latency
>  > kernel-space benches, i.e. at least in the latency -t 1 and latency =
-t
>  > 2 case. This means that we should change the timerbench driver. Ther=
e
>  > are at least two ways of doing this:
>  > use an rt_pipe
>  >  modify the timerbench driver to implement only the nrt ioctl, using=

>  > vanilla linux services such as wait_event and wake_up.
>  >=20
>  > What do you think ?
>=20
> So, what do you thing is the best way to change the timerbench driver,
> * use an rt_pipe ? Pros: allows to run latency -t 1 and latency -t 2 ev=
en
>  if Xenomai is compiled with CONFIG_XENO_OPT_PERVASIVE off; cons: make
>  the timerbench non portable on other implementations of rtdm, eg. rtdm=

>  over rtai or the version of rtdm which runs over vanilla linux
> * modify the timerbecn driver to implement only nrt ioctls ? Pros:
>   better driver portability; cons: latency would still need
>   CONFIG_XENO_OPT_PERVASIVE to run latency -t 1 and latency -t 2.

I'm still voting for my third approach:

  -> Write latency as kernel application (klatency) against the
     timerbench device
  -> Call NRT IOCTLs of timerbench during module init/cleanup
  -> Use module parameters for customization
  -> Setup a low-prio kernel-based RT task to issue the RT IOCTLs
  -> Format the results nicely (similar to userland latency) in that RT
     task and stuff them into some rtpipe
  -> Use "cat /dev/rtpipeX" to display the results

Jan


--------------enig9A1DACE8EC684EB9926AACB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHlmQ9niDOoMHTA+kRAuRSAJ4jKQAkEjN0QrwJ1p1jfArBTpW5rQCfcJeM
/FN5tfzRR7Es4SOZnS4uZJI=
=Sz6I
-----END PGP SIGNATURE-----

--------------enig9A1DACE8EC684EB9926AACB4--

