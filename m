Message-ID: <54ECAAF6.7010401@siemens.com>
Date: Tue, 24 Feb 2015 17:46:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20150223163743.GA22377@hermes.click-hack.org>
 <54EB5A45.9000002@siemens.com> <20150223165224.GB22377@hermes.click-hack.org>
 <54EB5D10.9050600@siemens.com> <20150223171401.GF22377@hermes.click-hack.org>
 <54EB657F.4040403@siemens.com> <54EB6836.1060204@siemens.com>
 <54EB68D7.3010606@siemens.com> <54EB71B2.9060607@siemens.com>
 <54ECA569.2040003@siemens.com> <20150224164557.GC14148@hermes.click-hack.org>
In-Reply-To: <20150224164557.GC14148@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-24 17:45, Gilles Chanteperdrix wrote:
> On Tue, Feb 24, 2015 at 05:23:05PM +0100, Jan Kiszka wrote:
>> On 2015-02-23 19:30, Jan Kiszka wrote:
>>> On 2015-02-23 18:52, Jan Kiszka wrote:
>>>> On 2015-02-23 18:49, Jan Kiszka wrote:
>>>>> On 2015-02-23 18:38, Jan Kiszka wrote:
>>>>>> On 2015-02-23 18:14, Gilles Chanteperdrix wrote:
>>>>>>> entry.S does not handle virtual irq state. So, if it returns to
>>>>>>> user-space with the root stage stalled, nothing will unstall it. And
>>>>>>> you probably get a lockup.
>>>>>>
>>>>>> Right, that's a point. I'm seeing this pattern in x86 now as well.
>>>>>> Comparing further.
>>>>>>
>>>>>> What's missing on ARM are flags adjustments in the register set before
>>>>>> letting Linux inspect that (__fixup_if equivalent). And we should
>>>>>> probably use ipipe_restore_root_nosync on return.
>>>>>
>>>>> There is another difference that should be considered carefullly. x86 says
>>>>>
>>>>>  * If we fault over the root domain, we need to replicate the
>>>>>  * hw interrupt state into the virtual mask before calling the
>>>>>  * I-pipe event handler.
>>>>>
>>>>> and then updates the root state before it calls __ipipe_notify_trap -
>>>>> why? x86-specific?
>>>>
>>>> The why is referring to the "before calling the I-pipe event handler" -
>>>> that we have to do this afterwards when we ended up or already were in
>>>> root is clear.
>>>
>>> It seems this is now - at beast - historic logic of x86. We (no longer?)
>>> report anything when __ipipe_notify_trap is invoked over the root domain:
>>>
>>>         /*
>>>          * We send a notification about all traps raised over a
>>>          * registered head domain only.
>>>          */
>>>         if (__ipipe_root_p)
>>>                 goto out;
>>>
>>> Will clean up on x86 soon.
>>
>> I've just pushed such a patch:
>> http://git.xenomai.org/ipipe-jki.git/commit/?h=for-upstream/master&id=fd52facbd86e09cc7fe17e7cb989ec4d46e2a798
>>
>> Tests passed here, including sigdebug which triggers a fault over head.
>> Linux lock debugging was fully enabled and stayed happy as well.
>>
>> I think we can convert ARM to this simplified x86 model now. I'll give
>> it a try.
> 
> Ok, before putting patches in your repository, please post the
> proposed implementation of ipipe_fault_entry and ipipe_fault_exit,
> so that we can discuss it before it gets merged by accident.

Yes, sure. I will even test them.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

