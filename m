From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Fri, 10 Mar 2006 17:00:10 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603101054.41122.lbocseg@domain.hid> <4411C646.80802@domain.hid>
In-Reply-To: <4411C646.80802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603101700.10820.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Sexta 10 Mar=3DE7o 2006 15:32, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Em Quinta 09 Mar=3DE7o 2006 17:33, Jan Kiszka escreveu:
>>> Rodrigo Rosenfeld Rosas wrote:
>>>> Hi Jan,
>>>>
>>>> I'm still concerned about the future of RTDM and timer functions. I
>>>> think there should be some function for starting the timer manually,
>>>> since the automatic feature don't work great for RTDM drivers.
>>>>
>>>> It is not nice to have to run the latency (or any other) program for
>>>> starting the timer before I can load my driver. And it is not suffice =
=3D
to
>>>> run it once I booted. After I open/close my rtdm device and reload my
>>>> driver the problem will occur again and I'll have to re-run the latency
>>>> program.
>>>
>>> Sorry I don't see the problem here.
>>>
>>> # modprobe xeno_nucleus; cat /proc/xenomai/timer
>>> status=3D3Doff:setup=3D3D1392:tickval=3D3D0:jiffies=3D3D0
>>>
>>> # modprobe xeno_rtdm; cat /proc/xenomai/timer
>>> status=3D3Doneshot:setup=3D3D1392:tickval=3D3D1:jiffies=3D3D81139177926=
96
>>>
>>> So the timer is running right since when rtdm is loaded?!
>>
>> Yes, here too.
>>
>>> And that simple heartbeat rtdm example on my rt-addon homepage now
>>> cleanly runs even without any further helper to start some timer.
>>
>> Yes, here too. You are right, once the timer is in oneshot mode. My driv=
=3D
er
>> loads correctly without the helper. Then I start a user application that
>> changes the timer to periodic mode and uses my driver. When I reload my
>> driver, now in periodic mode, the problem raises.
>
>What happens if you make the periodic timer the default one in the
>kernel configuration?

The same behaviour.

>> It seems, there is no problem when the timer is set to oneshot. But when
>> turning it to periodic, at least one of rtdm_task_busy_sleep() or
>> rtdm_clock_read() doesn't seem to work. See below:
>>
>> cat /proc/xenomai/timer
>>   status=3D3Dperiodic:setup=3D3D188:tickval=3D3D100000:jiffies=3D3D19972=
453
>>
>> start_time =3D3D rtdm_clock_read();
>> rtdm_task_busy_sleep(84000);
>> temp_time =3D3D rtdm_clock_read();
>> rtdm_printk(KERN_INFO "Should be near 84000: %u\n", (unsigned int)
>>                    (temp_time-start_time));
>>
>> Sometimes the result is "Should be near 84000: 100000", that is kind of
>> correct, since the tickval is 100000, although I think that those
>> functions in the RTDM driver context should be independent of the tick
>> value set by the user program... Maybe using oneshot in the driver calls
>> and periodic in the application... I really don't know what would be the
>> best approach here...
>
>rtdm_clock_read always uses the nucleus clock.

Do you mean that rtdm_clock_read will always read a multiple of tickval val=
=3D
ue?=3D20
If so, I think it would be good to make it clear on its documentation. "Get=
=3D
=3D20
system time" isn't enough for getting this information, IMHO.

>Using something different=3D20
>(e.g. always TSC) would break applications specifying absolute times
>derived from the return values of other skins' functions.

I did not understand. I'm talking about using TSC only for these two=3D20
functions. I can not see why shouldn't it be possible... I mean, I think th=
=3D
e=3D20
driver should not depend on the userspace program timer for these two=3D20
functions.

>> But the worst case is that sometimes I get "Should be near 84000: 0" whi=
=3D
ch
>> clearly is a incorrect result.
>
>That might be a rounding issue somewhere, as the sleep than clearly did
>not wait at least one tick. Will have to check this when time permits.
>
>> After I run the latency program, the timer turns to be oneshot again and
>> everything goes right.
>>
>> What can I do to solve this problem?
>
>Use oneshot mode in the meantime - or even longer ;).

That is what I'll gonna do, but I know it is not a definite solution. Since=
=3D
=3D20
I'm providing a framework, the user should decide which approach is better=
=3D
=3D20
for him/her, oneshot or periodic mode.

>Why do you prefer=3D20
>periodic mode for your application? Another workaround: reduce the tick
>interval.

I have some loops in my userspace programs that a common 100us tick would=
=3D20
satisfy them all. I think the overhead would be lower than using the=3D20
aperiodic oneshot mode... I'm not pretty sure about that. But that is not t=
=3D
he=3D20
question. My application is just an use case of my framework (actually I=3D=
20
didn't even started building it). The final user should decide what is the=
=3D
=3D20
best approach for him/her, not me. So, I would prefer that the driver be=3D=
20
independent from the timer source chosen by the user program.

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


