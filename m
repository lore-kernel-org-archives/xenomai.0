Message-ID: <51124CE5.7030906@siemens.com>
Date: Wed, 06 Feb 2013 13:30:29 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51122E82.6050209@siemens.com> <51124A06.3020205@xenomai.org>
	<51124C88.1060401@siemens.com>
In-Reply-To: <51124C88.1060401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i8253 clocksource vs. rthal_get_8254_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-06 13:28, Jan Kiszka wrote:
> On 2013-02-06 13:18, Gilles Chanteperdrix wrote:
>> On 02/06/2013 11:20 AM, Jan Kiszka wrote:
>>
>>> Hi Gilles,
>>>
>>> I just realized that there is now a 8253 clocksource in core-3.4+. How
>>> does this work together with Xenomai's TSC emulation via the 8254 in the
>>> x86 hal_32? Xenomai reprograms the PIT in rthal_setup_8254_tsc - is this
>>> harmless?
>>>
>>> I came across this while trying to get rid of Xenomai's "depends on
>>> !INPUT_PCSPKR" to avoid that circular Kbuild dependency.
>>
>>
>> This emulation replaces Xenomai's TSC emulation when the kernel boots on
>> a cpu without a TSC: the detection is made at run-time instead of
>> compilation time using self-modifying code (this in order to be able to
>> build Debian kernels which boots with any configuration).
> 
> Hmm, that's for the kernel. But what prevents rthal_setup_8254_tsc from
> being executed in addition? I'm currently a bit lost in the #ifdefs.

Ah! IPIPE_CORE_APIREV < 2, right?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

