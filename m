Message-ID: <470BDA72.8070908@domain.hid>
Date: Tue, 09 Oct 2007 21:45:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>	<470BC537.8010200@domain.hid>	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>
	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
In-Reply-To: <305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB8F8B3410A8E8D10F897346B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode on
 AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8F8B3410A8E8D10F897346B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gregory CLEMENT wrote:
> ---------- Forwarded message ----------
> From: Gregory CLEMENT <gclement00@domain.hid>
> Date: 9 oct. 2007 21:07
> Subject: Re: [Xenomai-core] RTAI and Xenomai latency in kernel mode on
> AT91SAM9261-EK
> To: Jan Kiszka <jan.kiszka@domain.hid>
>=20
>=20
> 2007/10/9, Jan Kiszka <jan.kiszka@domain.hid>:
>> Gregory CLEMENT wrote:
>>> Here, they are the last latency we get on AT91SAM9261-EK. As just now=

>>> I haven't the board at home, I send the last result we stored. The
>>> prority of dbgu should be set to 6 instead of 7, but I can't assure
>>> it, for Xenomai.
>> Hmm, hardware interrupt priorities must not impact the worst-case
>> latency if I-pipe acks and mask them appropriately (the worst case is
>> when multiple interrupts happen in a row, not at the same time). But
>> this statement is not based on knowledge about potential pitfalls of
>> this arch. Are there specialities that require this tweaking?
>=20
> Indeed there was little impact on Xenomai, but a big impact in RTAI. I
> believe that in RTAI (or at least in our RTAI port), there is longer
> critical section than in Xenomai.  We observe big latency when
> calibrator was writing a lot of "\r" on serial line, that was causing
> a lot of interrupts. I think that during a critical section (IT
> disabled), we get an timer interrupt and a serial interrupt. As serial
> interrupt has bigger priority it is treated first and as during an
> interrupt serial driver can send or receive 256 character, it can add
> a big delay.

Again, the priority should not be the issue. The issue is likely that a
pending or just being handled non-RT IRQ can stall some RT IRQ at
hardware level. That must not happen. I-pipe rather has to log,
acknowledge, and possibly mask that line quickly so that RT IRQs can be
delivered again.

We just revealed a similar problem over i386 about fasteoi-type IRQs.
What type of IRQs are involved here? Maybe it's the same bug.

>>> first Xenomai:
>>>
>>> #insmod /lib/modules/2.6.20.13/kernel/drivers/xenomai/testing/xeno_ti=
merbench.ko
>>> #cd /usr/xenomai/bin/
>> Which versions were you using for both tests? Do you still have the
>> involved .configs?
>=20
> Both version are 2.6.20.13
> I join the config files.

Hmm, I wonder why we have this difference in the configs:

# diff -u config-RTAI config-Xenomai
[...]
@@ -147,7 +243,7 @@
 # AT91 Board Options
 #
 # CONFIG_MTD_AT91_DATAFLASH_CARD is not set
-# CONFIG_MTD_NAND_AT91_BUSWIDTH_16 is not set
+CONFIG_MTD_NAND_AT91_BUSWIDTH_16=3Dy

 #
 # AT91 Feature Selections


Can accessing the flash delay interrupts significantly, and may this
switch here have impact on the delay? Sorry for potential stupid
questions, I'm not familiar with this arch yet.

>>> #./latency -t 2 -p 150 -h -H 500
>> ...
>>> ---|------------|------------|------------|--------|-----------------=
--------
>>> RTS|       3.480|      11.779|      99.163|       0|    14:23:01/14:2=
3:01
>>>
>>> It was run under calibrator load during more than 14 hours.
>>>
>>> Now RTAI:
>>>
>>> Oneshot timer with 500=B5s period,  LATENCY =3D6000ns and SETUPTIME 1=
500
>>>  duration : 17h
>>>
>>> 1970/01/1 22:34:51
>>> RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   ov=
erruns
>>> RTD|       3221|       2577|       4997|      26095|      53801|     =
     0
>>> RTD|       3221|       2577|       5163|      25451|      53801|     =
     0
>>> RTD|       3221|       2577|       5159|      25128|      53801|     =
     0
>>> RTD|       3221|       2577|       4799|      23518|      53801|     =
     0
>>> RTD|       3221|       2577|       4828|      25128|      53801|     =
     0
>>> RTD|       3221|       2577|       5089|      23518|      53801|     =
     0
>>> RTD|       3221|       2577|       4580|      23840|      53801|     =
     0
>>> RTD|       3221|       2577|       4924|      25128|      53801|     =
     0
>>> RTD|       3221|       2577|       4740|      24806|      53801|     =
     0
>>> RTD|       3221|       2577|       4251|      25128|      53801|     =
     0
>> Again, what would simplify the discussion enormously is a function
>> back-trace of the measured maximum latencies, just like "latency -f"
>> generates. The numbers will become worse, for sure, but we would gain =
a
>> very good overview about what is executed and what delayed which kerne=
l.
>> If you see a chance to perform such a test and you need some hints on
>> the tracer setup (or did you use it before?), please let us know!
>=20
> OK for try it, at least for Xenomai as the function exists, but I
> can't do it tonight and not this week in fact.

Thanks advance! BTW, you don't need to apply black magic in order to
instrument RTAI: As you measure in the kernel anyway, you just need to
add an ipipe_trace_freeze(<measured_latency>) at the point where a new
maximum latency is detected in RTAI's benchmark module. In theory, the
tracer should also work over RTAI out-of-the-box (but I'm not aware of
anyone actually using it there). More info on the tracer can be found in
the Xenomai wiki, BTW.

Jan


--------------enigB8F8B3410A8E8D10F897346B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHC9pyniDOoMHTA+kRAgpdAJ45qQPtQXfqkULg8PyM9Fbs0gem0wCggzlt
DS25fzxFwSWvY9F4MnhADE4=
=6mWe
-----END PGP SIGNATURE-----

--------------enigB8F8B3410A8E8D10F897346B--

