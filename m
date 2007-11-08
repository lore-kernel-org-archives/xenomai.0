Message-ID: <4732D076.4070806@domain.hid>
Date: Thu, 08 Nov 2007 10:01:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4717D8AC.8000900@domain.hid>	<FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>	<4718670D.6000008@domain.hid>	<472ED13D.4050703@domain.hid>	<472ED274.9070205@domain.hid>
	<4732C455.6060900@domain.hid>
In-Reply-To: <4732C455.6060900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] LTTng for Xenomai - next round
Reply-To: rpm@xenomai.org
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

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> ...
>>>> Regarding the instrumentation: My latest Xenomai patch changed the
>>>> marker arguments even more away from your original patch. Not looking at
>>>> the plugin for this, I may have removed useful information. Please let
>>>> us know what you would like to see in the trace points so that this part
>>>> can quickly stabilise, maybe even go into the next Xenomai release.
>>> I decided to accelerate the core instrumentation as it looks like I will
>>> need it sooner than expected. So here comes another version of the
>>> Xenomai-part of the patch series, changing the following:
>>>
>>>  - Full conversion to trace_mark, no intermediate xnltt_log_event
>>>    anymore. Unsupported kernel versions are caught by the wrapping layer
>>>    instead. Thus, also ltt.h is obsolete now (bootstrap run is required
>>>    for user land).
>> Just realised: As usual, this patch nicely breaks the simulator (what is
>> trace_mark?). Will fix with the next submission later today or tomorrow.
>>
> 
> Here comes v6 of instrumentation patch. It fixes the simulator build +
> another build error when periodic timing was disabled.
>

Ok, we want this in for -rc6 I think, so that we can build over it asap.
 Will merge, thanks.

-- 
Philippe.

