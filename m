From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 16:31:26 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131431.35216.lbocseg@domain.hid> <4415BB0D.8070808@domain.hid>
In-Reply-To: <4415BB0D.8070808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131631.26195.lbocseg@domain.hid>
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

Em Segunda 13 Mar=3DE7o 2006 15:33, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Em Segunda 13 Mar=3DE7o 2006 14:25, Gilles Chanteperdrix escreveu:
>>> Jan Kiszka wrote:
>>>>> Sometimes the result is "Should be near 84000: 100000", that is kind =
=3D
of
>>>>> correct, since the tickval is 100000, although I think that those
>>>>> functions in the RTDM driver context should be independent of the tick
>>>>> value set by the user program... Maybe using oneshot in the driver
>>>>> calls and periodic in the application... I really don't know what wou=
=3D
ld
>>>>> be the best approach here...
>>>>
>>>> rtdm_clock_read always uses the nucleus clock. Using something differe=
=3D
nt
>>>> (e.g. always TSC) would break applications specifying absolute times
>>>> derived from the return values of other skins' functions.
>>>
>>> Maybe adding a service to RTDM would allow users to measure short time
>>> intervals with RTDM using the TSC ?
>>>
>>> The native (rt_timer_tsc()) and posix (clock_gettime(CLOCK_MONOTONIC))
>>> skins have a way to do this.
>>
>> This would fit great for my needs (and most developers I think)!
>
>Will think about it. Actually, I'm not a big fan of this. It creates the
>risk that someone feeds the output of this service into (incompatible)
>timed RTDM services.

Sorry, I couldn't see a practical usage of this. Could you give an example?

>Even worse, this would work for aperiodic mode but fail for periodic.

Actually it is only necessary on periodic modes as it already works for=3D20
aperiodic mode.

>We would definitely need a good name for it,
>rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
>rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read() by
>adding an argument (otherwise, I would have to fix too many drivers on
>my own... :-/).

That is the idea, I think. I agree that rtdm_clock_read() should be kept as=
=3D
 it=3D20
is (the API/definition). No body is asking you to change it. Adding=3D20
rtdm_clock_read_tsc() would be sufficient in my opinion whilst it maintain=
=3D
=3D20
coherency with other skins.

Thank you for considering it.

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


