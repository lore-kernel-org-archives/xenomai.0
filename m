Subject: Re: Large gpio interrupt latency
References: <87o8bzyxne.fsf@xenomai.org> <10a0-60d0d500-8b-29fb8780@204427917>
 <87lf72z6ux.fsf@xenomai.org>
 <19ba6735ee0f09c8abb7ff8aa405d6f63aae959e.camel@sprinte.eu>
 <2f00ba9e-c0e2-a0fb-4ba4-bb6cc7a651fe@siemens.com>
 <87im26z44t.fsf@xenomai.org>
 <669e153a-2cb8-4de4-a75e-b3e82f09dcb8@siemens.com>
 <87fsxaz1my.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <47dd2aec-3adf-53eb-bdae-b069d626849a@siemens.com>
Date: Tue, 22 Jun 2021 11:39:57 +0200
MIME-Version: 1.0
In-Reply-To: <87fsxaz1my.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Julien Blanc <julien.blanc@sprinte.eu>, "francois.legal@thom.fr.eu.org" <francois.legal@thom.fr.eu.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 22.06.21 11:31, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 22.06.21 10:37, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 22.06.21 09:49, Julien Blanc via Xenomai wrote:
>>>>> Le mardi 22 juin 2021 à 09:38 +0200, Philippe Gerum via Xenomai a
>>>>> écrit :
>>>>>>
>>>>>> With this in mind, assuming that we have previously sanitized the
>>>>>> clock
>>>>>> identifier, doing this:
>>>>>>
>>>>>> #define get_timestamp(__clock) \
>>>>>> ({ (__clock) == CLOCK_MONOTONIC ? rtdm_clock_read_monotonic() :
>>>>>> rtdm_clock_read(); })
>>>>>>
>>>>>> may end up being faster than:
>>>>>>
>>>>>> xnticks_t (*__get_timestamp)(clockid_t clock);
>>>>>> #define get_timestamp(__clock)	__get_timestamp(__clock)
>>>>>
>>>>> Is really a runtime switch necessary ? Since relying on the realtime
>>>>> clock is inherently broken, my understanding is that it should be kept
>>>>> as compatibility purpose only.
>>>>
>>>> Again: The real-time clock is not a broken clock per se. It is the basis
>>>> of many services (POSIX...) and - if managed properly - it is as sound
>>>> clock to build upon. If you need absolute timestamps to calculate
>>>> absolute timeouts (like users of the existing code do), this is the
>>>> clock to go, also in future versions.
>>>
>>> Definitely correct, for timeout specs.
>>>
>>>> Also if you want to use
>>>> PTP-sync'ed clocks across systems (TSN...), it is THE way to go. At that
>>>> point, monotonic timestamps will lose relevance in practice.
>>>>
>>>
>>> We are not there yet. So, let's all agree than we need both clock bases,
>>> and a flexible way to select the current one.
>>>
>>
>> What's still missing with Dovetail and a Linux-operated PTP sync for the
>> main clocksource? Hardending of software-based sync paths? Where it's
>> hw-based, that should already be fine (latest Intel SOCs).
>>
> 
> Again, we have two use cases: absolute timeouts based on a common epoch
> which may change, and delays. We do know PTP with hw-based support is an
> efficient way to maintain consistency among users of the former,
> nevertheless we still need to express/measure strict delays in other
> cases. So, we do need both clocks.
> 

If you need cross-system event stamping, the unsync'ed monotonic clock
is the wrong choice as well.

Again: What is missing to use PTP-sync'ed clock-realtime under Dovetail
today?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

