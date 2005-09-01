Message-ID: <20050901144405.tvan1ov9og0oo8so@domain.hid>
Date: Thu, 01 Sep 2005 14:44:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
	<1125577206.4641.8.camel@domain.hid>
In-Reply-To: <1125577206.4641.8.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

Quoting Stelian Pop <stelian@domain.hid>:

> Le jeudi 01 septembre 2005 =C3=A0 10:47 +0200, Philippe Gerum a =C3=A9cri=
t :
>> >> Ok. Looks like time has come to upgrade the combined 
>> Adeos/PREEMPT_RT patch
>> >> to
>> >> -rt1 in order to fix the issues brought since 0.7.44, I guess.
>> >
>> > How does this relate to the above ? I worked on the _plain_ adeos
>> > patch, not the combo rt one. That being said, the plain adeos patch
>> > does contain some PREEMPT_RT bits - and those are the ones causing the
>> > problems.
>> >
>>
>> This is exactely how this relates to the above: The PREEMPT_RT-aware 
>> bits are
>> out of date.
>
> I was under the impression that the PREEMPT_RT bits were not supposed to
> be at all in the plain (non rt combo) patch. But I suppose the current
> plan is to fold those bits into the regular patch.
>

Yep. This is so in order to reduce the number of adaptations needed to 
make the
combo patches, as an attempt to reduce the number of code conflicts between
Adeos and PREEMPT_RT.

>> >> >The ppc patch was a bit more tricky, but I think I got all of it rig=
ht.
>> >> >It works ok most of the time (RTAI fusion testsuite passes for examp=
le -
>> >> >on a G4 Powerbook), but it hangs the machine hard sometimes. I am no=
t
>> >> >sure if the problem is due to the port or if it is present in the 2.=
6.10
>> >> >version as well.
>> >> >
>> >>
>> >> I had a report about issues involving insufficiently protected
>> >> get_mmu_context/destroy_context calls on the RTAI mailing list with
>> >> 2.6.10-r8c1; I'm currently checking the proposed fix that has 
>> been sent to
>> >> me
>> >> on a mpc8541. If this works, then maybe this would solve the issue yo=
u
>> >> mention
>> >> too; hopefully.
>> >
>> > I suppose you're talking about:
>> > https://mail.rtai.org/pipermail/rtai/2005-August/012841.html
>> >
>>
>> Yes; Looking at the code a bit more, I think the issue was more
>> generally lying
>> in the unprotected use of activate_mm(), as called from the fs/exec stuf=
f.
>
> I saw the patch you posted on the rtai list and tried it,
> but unfortunately it does not solve my problems.
>
> The bug (hard lockup without any message at all) is 100% reproductible
> when running fusion's rtai-test application. It does not always hang at
> the same point in execution, but it does often hang at the end of the
> 'latency' binary invocation.
>

Would be very lucky so I guess it's unlikely, but anyway, does enabling the
fusion watchdog in the nucleus menu trigger something?

> I am also unable to reproduce this bug when running manually the 'latency=
'
> test, even when simulating some load like 'rtai-test' does. I suppose
> I could end up reproducing the bug if I tried hard enough...
>
> I'll try testing the 2.6.10 patch, maybe this will tell if the problem
> is in the adeos core or in the newer kernel changes...
>
> Stelian.
> --
> Stelian Pop <stelian.pop@domain.hid>
>
>




