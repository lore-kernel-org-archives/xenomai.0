Message-ID: <4B750157.6080000@domain.hid>
Date: Fri, 12 Feb 2010 08:20:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid>
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid>
	<4B7447AD.5050401@domain.hid>
	<8b216e9e1002111024h7c87d0c1n9f36a91602e52cd6@domain.hid>
	<4B744ED4.2000200@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid>
	<4B745CAB.5000404@domain.hid>
	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid>
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid>
In-Reply-To: <8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
>=20
>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>> 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
om>
>>>
>>>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>>>> 2010/2/11 Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org>
>>>>>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>>>>>> Sending the boot log and the xeno-test output as attachments.
>>>>>> [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
>>>>>>
>>>>>> Definitely not OK. We do not want this unprecise clockevent source=
=2E
>>>>>> Disable it in the kernel configuration (option CONFIG_OMAP_32K_TIM=
ER).
>>>>>>
>>>>>>
>>>>> This is very interesting - this option doesnt seem to be set in my
>>>> current
>>>>> kernel config. Ive attached my .config.
>>>> Selecting GPTIMER 1 should work. But if you get lockups or thing lik=
e
>>>> that, please try with a vanilla 2.6.30 to see if you get them.
>>>>
>>>>
>>> Great - changing GPTIMER to 1 did the trick! Gilles, thank you very m=
uch!
>>>
>>> Here are the results of the first latency test, under 100% load:
>>>
>>> RTT|  00:08:46  (periodic user-mode task, 1000 us period, priority 99=
)
>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|-=
-lat
>>> worst
>>> RTD|     12.999|     13.769|     18.846|       0|     0|     12.538|
>>> 44.692
>>> RTD|     13.076|     13.769|     20.692|       0|     0|     12.538|
>>> 44.692
>>> RTD|     12.923|     13.769|     18.076|       0|     0|     12.538|
>>> 44.692
>>> RTD|     12.846|     13.769|     20.153|       0|     0|     12.538|
>>> 44.692
>>> RTD|     12.999|     13.769|     18.692|       0|     0|     12.538|
>>> 44.692
>>> RTD|     12.999|     13.769|     19.230|       0|     0|     12.538|
>>> 44.692
>>> RTD|     13.076|     13.769|     18.769|       0|     0|     12.538|
>>> 44.692
>>> RTD|     13.076|     13.769|     19.153|       0|     0|     12.538|
>>> 44.692
>>> RTD|     12.846|     13.769|     19.999|       0|     0|     12.538|
>>> 44.692
>>>
>>> BTW, the system does seem a lot more stable now - no random errors. I=

>> will
>>> run some more tests, and will send in the results later - I will docu=
ment
>>> the procedure and post it online once we get Xenomai running well in =
the
>>> IGEPv2.
>> Ok. Good news. I would have liked to find out what was this building
>> issue of yours, at least to be able to use your rootfs build system
>> instead of building xenomai manually.
>>
>>
> In the end, I did get it to work with my build system (bitbake, running=
 on
> the standard IGEP virtual machine) - I modified the configuration files=
 so
> the
> ASNEEDED =3D "-Wl,--as-needed"
> became
> ASNEEDED =3D ""

Could you try re-enabling --as-needed with the following patch?

diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
index f4826ac..09944f5 100755
--- a/scripts/wrap-link.sh
+++ b/scripts/wrap-link.sh
@@ -34,7 +34,14 @@ add_linker_flag() {
        stage1_args=3D"$stage1_args -Wl,--wrap $@"
        next_is_wrapped_symbol=3Dfalse
     else
-       add_2stages "$@"
+       case "$@" in
+       *--as-needed*)
+               stage2_args=3D"$stage2_args $@"
+               ;;
+       *)
+               add_2stages "$@"
+               ;;
+       esac
     fi
 }


>=20
> Xenomai builds cleanly afterwards, even with the modified optimization
> flags.
> I am attaching the bitbake file I used for reference.
>=20
> The challenge is getting the IGEP running cleanly now - if the network =
is
> connected, the systems becomes unstable and crashes randomly, and MMC/S=
DIO
> (and therefore, Wifi) support is disabled. I am attempting to get the
> patches individually from the folks at ISEE (the makers of the IGEP boa=
rd)
> so I can get a clean system running. I need a rock-solid system for thi=
s
> project - our lab is building a small UAV, and the IGEP with Xenomai is=

> going to be the central controller.

Ok. Please test the I-pipe patch for 2.6.30. In another mail which you
may have missed, I sent you a patch which adds basic IGEP support to
2.6.32. You can probably use that patch to get basic IGEP support on
2.6.30. This is not a definitive solution, it is just a test to see if
either something in the android kernel is incompatible with Xenomai, or
if you are having a problem with the I-pipe patch for 2.6.28.

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


