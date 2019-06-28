Subject: Re: ipipe-x86: TRACE_IRQS_IRETQ on fast return
References: <1b988b50-db86-4073-9bac-cf6da94488bc@siemens.com>
 <e56c04d7-7c7b-092e-87de-a7efae53369a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <223cae86-f84d-8b2e-12cc-35442f186913@xenomai.org>
Date: Fri, 28 Jun 2019 17:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <e56c04d7-7c7b-092e-87de-a7efae53369a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 6/28/19 3:47 PM, Jan Kiszka wrote:
> On 28.06.19 15:23, Jan Kiszka wrote:
>> Philippe,
>>
>> when returning from an interrupt (not sure about exceptions yet) with
>> root domain stalled, we take the fast paths, to kernel or to userspace:
>>
>> https://gitlab.denx.de/Xenomai/ipipe-x86/commit/62957b1a3c5d36f32c6fdb33df00424fc5106c60#cfbf24a4bb0ddb98db8da0adf4b5c32cc18c6b34_570_573
>>
>>
>> Since the initial port to 4.14, both contain TRACE_IRQS_IRETQ on x86.
>> This seem to have had no consequences on 4.14 so far (which still
>> confuses me), but it is now exploding on 4.19 during boot (lockdep
>> records locks to be held with interrupts off that should never by held
>> like that, rq->lock e.g.). This made me wonder why interrupt state
>> tracing was included in 4.14 like that. Can you recall which case you
>> were addressing with this change?
>>
> 
> This issue seems to be present in other archs as well: Just checked
> arm64, and it also calls TRACE_IRQSON in the fast path, even when
> irqs_disabled(). The reason might be to balance the unconditional
> TRACE_IRQSOFF on entry. Hmm, maybe we can address that generically, in
> lockdep...
> 

The reason was to stop playing whack-a-mole with IRQS_ON/OFF tracepoints
which is wrong, and indeed address this at the lockdep/irqtracer level
instead. trace_hardirqs_on/off_caller check for the current domain
already, assuming that if it's root, then it has to be in the correct
stall state already (which could be wrong with 4.19 and maybe
elsewhere). You may want to check if having CONFIG_PREEMPT makes any
difference in the 4.19 case.

trace_hardirqs_on/off_virt_caller was introduced for dealing with
tracing the re-entry path to userland, with a bit more logic there
specifically to keep lockdep happy. Maybe some logic is missing from the
regular TRACE_IRQS_ON/OFF when pipelining is enabled.

-- 
Philippe.

