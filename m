Message-ID: <54EB71B2.9060607@siemens.com>
Date: Mon, 23 Feb 2015 19:30:10 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54E77A52.4010806@siemens.com> <54E78EB8.4060204@xenomai.org>
 <54E78F62.9040505@xenomai.org> <54E79086.8030801@xenomai.org>
 <54EB5021.3030508@siemens.com> <54EB5638.3050805@xenomai.org>
 <20150223163743.GA22377@hermes.click-hack.org> <54EB5A45.9000002@siemens.com>
 <20150223165224.GB22377@hermes.click-hack.org> <54EB5D10.9050600@siemens.com>
 <20150223171401.GF22377@hermes.click-hack.org> <54EB657F.4040403@siemens.com>
 <54EB6836.1060204@siemens.com> <54EB68D7.3010606@siemens.com>
In-Reply-To: <54EB68D7.3010606@siemens.com>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-23 18:52, Jan Kiszka wrote:
> On 2015-02-23 18:49, Jan Kiszka wrote:
>> On 2015-02-23 18:38, Jan Kiszka wrote:
>>> On 2015-02-23 18:14, Gilles Chanteperdrix wrote:
>>>> entry.S does not handle virtual irq state. So, if it returns to
>>>> user-space with the root stage stalled, nothing will unstall it. And
>>>> you probably get a lockup.
>>>
>>> Right, that's a point. I'm seeing this pattern in x86 now as well.
>>> Comparing further.
>>>
>>> What's missing on ARM are flags adjustments in the register set before
>>> letting Linux inspect that (__fixup_if equivalent). And we should
>>> probably use ipipe_restore_root_nosync on return.
>>
>> There is another difference that should be considered carefullly. x86 says
>>
>>  * If we fault over the root domain, we need to replicate the
>>  * hw interrupt state into the virtual mask before calling the
>>  * I-pipe event handler.
>>
>> and then updates the root state before it calls __ipipe_notify_trap -
>> why? x86-specific?
> 
> The why is referring to the "before calling the I-pipe event handler" -
> that we have to do this afterwards when we ended up or already were in
> root is clear.

It seems this is now - at beast - historic logic of x86. We (no longer?)
report anything when __ipipe_notify_trap is invoked over the root domain:

        /*
         * We send a notification about all traps raised over a
         * registered head domain only.
         */
        if (__ipipe_root_p)
                goto out;

Will clean up on x86 soon.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

