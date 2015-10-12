References: <20151011130536.GA1765@hermes.click-hack.org>
 <561B6002.3010409@siemens.com> <20151012081028.GA23413@hermes.click-hack.org>
 <561B715E.3090207@siemens.com> <20151012084846.GB23413@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <561B7652.30508@siemens.com>
Date: Mon, 12 Oct 2015 10:58:58 +0200
MIME-Version: 1.0
In-Reply-To: <20151012084846.GB23413@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with CONFIG_PREEMPT_VOLUNTARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-10-12 10:48, Gilles Chanteperdrix wrote:
> On Mon, Oct 12, 2015 at 10:37:50AM +0200, Jan Kiszka wrote:
>> On 2015-10-12 10:10, Gilles Chanteperdrix wrote:
>>> On Mon, Oct 12, 2015 at 09:23:46AM +0200, Jan Kiszka wrote:
>>>> On 2015-10-11 15:05, Gilles Chanteperdrix wrote:
>>>>> Hi,
>>>>>
>>>>> It seems commit fdb5d54d04b8c3b6b6a6ad7ac2b6248cf0b415e0 in the
>>>>> I-pipe kernels cause a warning when CONFIG_PREEMPT_VOLUNTARY and
>>>>> CONFIG_IPIPE_DEBUG_INTERNAL are enabled. The culprit is the call to
>>>>> __ipipe_root_p.
>>>>
>>>> Compiler warning? Runtime warning? Which architecture? I assume that
>>>> ftrace is on then, right?
>>>
>>> Yes. Because preempt_disable()/preempt_enable*() is a nop without
>>> CONFIG_PREEMPT_COUNT, __ipipe_root_p ends up being called without
>>> any protection, and __ipipe_check_percpu_access() emits the warning.
>>>
>>
>> Makes sense.
>>
>>>>
>>>>>
>>>>> The following patch avoids this warning:
>>>>
>>>> How?
>>>
>>> It disables the test for preemption (the call to preempt_count()) in
>>> __ipipe_check_percpu_access() if CONFIG_PREEMPT_COUNT is disabled,
>>> because if it is disabled, you can not be preempted anywhere, so
>>> calling __ipipe_root_p without protection is valid. Or maybe not?
>>
>> Ah, ok. I was under the assumption preempt_count() would return a
>> constant non-zero value under !CONFIG_PREEMPT. But on the other hand,
>> that would be weird as well when triggering voluntary preemption then.
>>
>> Anyway, it's correct that preemption cannot happen then in the middle of
>> an instruction, so we can skip the test. Please make the test depend on
>> CONFIG_PREEMPT and leave a corresponding comment in the code.
> 
> maybe we could use preemptible()?
> 
> it should test both the stall flag and preempt_count with
> CONFIG_PREEMPT_COUNT and returns 0 without CONFIG_PREEMPT_COUNT.

Indeed, even better. And self-documenting.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

