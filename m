Message-ID: <54EF20CB.2000300@siemens.com>
Date: Thu, 26 Feb 2015 14:34:03 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54ECCC8A.8000501@siemens.com>
 <20150224192718.GH14148@hermes.click-hack.org> <54ECDF37.3050706@siemens.com>
 <20150224204801.GJ14148@hermes.click-hack.org>
In-Reply-To: <20150224204801.GJ14148@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe exception handling - a general model
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

On 2015-02-24 21:48, Gilles Chanteperdrix wrote:
> On Tue, Feb 24, 2015 at 09:29:43PM +0100, Jan Kiszka wrote:
>> On 2015-02-24 20:27, Gilles Chanteperdrix wrote:
>>> On Tue, Feb 24, 2015 at 08:10:02PM +0100, Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> let's try to express the steps in handling hardware exception under
>>>> I-pipe in a generic way:
>>>>
>>>> ipipe_exception_handler(regs, ...)
>>>> {
>>>> 	// ARM has this e.g.
>>>> 	[if (early_handling(...))
>>>> 		return;]
>>>>
>>>> 	// some architectures may only enter with irqs off
>>>> 	[hard_irqs_off = hard_irqs_disabled();]
>>>
>>> Not OK. Here what you will get is:
>>> - hard_irqs_off is true if the exception is taken on root
>>> - hard_irqs_off is false if the exception is taken on head (as a
>>
>> No, this is invariant of the context. The hardware(-configuration)
>> decides if we enter the handler with hard irqs off or not. See x86, this
>> is known to work code.
> 
> No. Relaxing re-enables hw irqs. So, if you took the exception over
> head, you relaxed, and hw irqs are on here. The information you get
> this way is irrelevant.

ipipe_exception_handler() is supposed to be the function that the
assembly exception trampoline calls directly - there can't be any
migration/relaxation before that. Thus, hard_irqs_disabled() reflects if
the exception handler was called by the hardware with hard interrupts on
or off.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

