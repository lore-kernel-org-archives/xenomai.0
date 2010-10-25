Message-ID: <4CC5E887.9050703@domain.hid>
Date: Mon, 25 Oct 2010 22:28:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>	<4CC44C02.4050003@domain.hid>	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>	<4CC5603E.1090707@domain.hid>	<4CC566A2.2000702@domain.hid>	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>	<AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>	<4CC5C93E.70503@domain.hid>
	<AANLkTimS7-CEvA74Viwu4mLm9-O_NpakXYG7=FXK1L1f@domain.hid>
	<4CC5DD1F.4090405@domain.hid>
In-Reply-To: <4CC5DD1F.4090405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE29E18AA708DA0FF430F662B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE29E18AA708DA0FF430F662B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 21:40, Jan Kiszka wrote:
> Am 25.10.2010 21:03, Peter Pastor wrote:
>> Hey Jan,
>>
>> I did not apply any ubuntu patch for kernel 2.6.35 (since I do not hav=
e
>> one).  Also, good to know that I should not use xenomai patches togeth=
er
>> with ubuntu patches.
>>
>> Anyway, the problem occurred as well with the kernel 2.6.35 (see attac=
hed
>> dmesg_bad_2.6.35)
>> I also attached the config.
>>
>=20
> ...
>=20
>> [ 5751.714643] irq 16: nobody cared (try booting with the "irqpoll" op=
tion)
>> [ 5751.714649] Pid: 0, comm: swapper Tainted: P            2.6.35-ipip=
e-2.5.4-slim #2
>> [ 5751.714653] Call Trace:
>> [ 5751.714655]  <IRQ>  [<ffffffff8108bb56>] __report_bad_irq+0x26/0xa0=

>> [ 5751.714668]  [<ffffffff8108bd5c>] note_interrupt+0x18c/0x1d0
>> [ 5751.714672]  [<ffffffff8108c77d>] handle_fasteoi_irq+0xcd/0x100
>> [ 5751.714677]  [<ffffffff8100656d>] handle_irq+0x1d/0x30
>> [ 5751.714681]  [<ffffffff81005a40>] do_IRQ+0x70/0x100
>> [ 5751.714685]  [<ffffffff81092147>] __ipipe_sync_stage+0x207/0x20d
>> [ 5751.714689]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
>> [ 5751.714692]  [<ffffffff8109214d>] ? __xirq_end+0x0/0x9c
>> [ 5751.714696]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
>> [ 5751.714700]  [<ffffffff810926a3>] __ipipe_walk_pipeline+0x113/0x120=

>> [ 5751.714706]  [<ffffffff81024414>] __ipipe_handle_irq+0x124/0x310
>> [ 5751.714708]  [<ffffffff8108bf10>] ? __ipipe_ack_fasteoi_irq+0x0/0x1=
0
>> [ 5751.714712]  [<ffffffff814f78d3>] common_interrupt+0x13/0x2c
>> [ 5751.714713]  <EOI>  [<ffffffff810249d6>] ? __ipipe_halt_root+0x26/0=
x40
>> [ 5751.714718]  [<ffffffff81061191>] ? atomic_notifier_call_chain+0x11=
/0x20
>> [ 5751.714722]  [<ffffffff8100cbd5>] default_idle+0x45/0x50
>> [ 5751.714725]  [<ffffffff8100198a>] cpu_idle+0x7a/0xd0
>> [ 5751.714728]  [<ffffffff814f14a1>] start_secondary+0x1c1/0x1c5
>> [ 5751.714730] handlers:
>> [ 5751.714730] [<ffffffff8136ed60>] (usb_hcd_irq+0x0/0xb0)
>> [ 5751.714735] [<ffffffffa00bac30>] (mpt_interrupt+0x0/0xa00 [mptbase]=
)
>> [ 5751.714747] Disabling IRQ #16
>=20
> I'm not yet sure, but a first thought: We have a shared fasteoi IRQ
> here, and we are on SMP. Compared to vanilla, the fasteoi flow of ipipe=

> looks so much different to me ATM that I tend to believe two cores end
> up having this IRQ queued at the same time. One runs first and handles
> all triggers, the second bails out like above.
>=20
> Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask them prior=

> to this? What prevents a second IRQ arriving after this early eoi?
>=20

Slowly getting more confident in this theory. Peter, you could increase
the confidence further by binding the IRQ #16 to a single core (e.g.
echo 1 > /proc/irq/16/smp_affinity, make sure to stop irqbalance first
in case it's running).

Moreover, edge handling looks similarly broken: We ack the IRQ early,
there is no further masking, but we do not block delivery /wrt other
cores - in contrast to Linux which has IRQ_INPROGRESS, checked and set
atomically along with the ack (if I-pipe is off). And this issue should
not only affect Linux, Xenomai may get equally unhappy if ever faced
with a bunch of shared edge RT-IRQs on a SMP box. Uff.

Jan


--------------enigE29E18AA708DA0FF430F662B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzF6IcACgkQitSsb3rl5xTcTACfbu39fDB7GHhJAMZBk0GZA/r5
7gQAoO7vVWShY1sNiB2BzRS5ABD+8zZG
=NwRo
-----END PGP SIGNATURE-----

--------------enigE29E18AA708DA0FF430F662B--

