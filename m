From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 11:54:13 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603101700.10820.lbocseg@domain.hid> <44155BFD.300@domain.hid>
In-Reply-To: <44155BFD.300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131154.13627.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Em Segunda 13 Mar=3DE7o 2006 08:48, voc=3DEA escreveu:
>...
>
>> Do you mean that rtdm_clock_read will always read a multiple of tickval
>> value? If so, I think it would be good to make it clear on its
>> documentation. "Get system time" isn't enough for getting this
>> information, IMHO.
>
>Please have a look at the two sentences of documentation I added to SVN
>(didn't make it into the release).

I did.

>I gave your scenario a try, and I was able to verify that
>rtdm_task_busy_sleep works correctly under both timer modes.

I cannot understand yet why it doesn't occur here, but I'll investigate if I
have the time to.

>Indeed, the
>behaviour of rtdm_clock_read may have been confusing due to lacking
>information, but it was also correct.

I liked the note, but I would include another one:
"When in periodic mode, the time resolution is limited to the tick set to t=
=3D
he
system timer" or something like. Maybe:
"[If using periodic mode, note that ]The time resolution is limited by the
system timer tick". Well my English is not that good, so I think you could
give a better description, but I really need this note is very useful.

>>> Using something different
>>> (e.g. always TSC) would break applications specifying absolute times
>>> derived from the return values of other skins' functions.
>>
>> I did not understand. I'm talking about using TSC only for these two
>> functions. I can not see why shouldn't it be possible... I mean, I think
>> the driver should not depend on the userspace program timer for these two
>> functions.
>>
>>>> But the worst case is that sometimes I get "Should be near 84000: 0"
>>>> which clearly is a incorrect result.
>>>
>>> That might be a rounding issue somewhere, as the sleep than clearly did
>>> not wait at least one tick. Will have to check this when time permits.
>>>
>>>> After I run the latency program, the timer turns to be oneshot again a=
=3D
nd
>>>> everything goes right.
>>>>
>>>> What can I do to solve this problem?
>>>
>>> Use oneshot mode in the meantime - or even longer ;).
>>
>> That is what I'll gonna do, but I know it is not a definite solution.
>> Since I'm providing a framework, the user should decide which approach is
>> better for him/her, oneshot or periodic mode.
>>
>>> Why do you prefer
>>> periodic mode for your application? Another workaround: reduce the tick
>>> interval.
>>
>> I have some loops in my userspace programs that a common 100us tick would
>> satisfy them all. I think the overhead would be lower than using the
>> aperiodic oneshot mode... I'm not pretty sure about that. But that is not
>> the question. My application is just an use case of my framework (actual=
=3D
ly
>> I didn't even started building it). The final user should decide what is
>> the best approach for him/her, not me. So, I would prefer that the driver
>> be independent from the timer source chosen by the user program.
>
>I see your point. But when the user decides to pick a low-precision
>timer source to reduce overhead, (s)he has to live with the side-effect.
>There is no such thing like "user vs. kernel" timer source - it is
>always the same. Thus, also the precision of time stamping in drivers
>suffers.

Ok, I'll document this on my framework.

Thanks for the support,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



