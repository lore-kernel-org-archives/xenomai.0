Message-ID: <559CFBE7.3050802@siemens.com>
Date: Wed, 08 Jul 2015 12:31:03 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <558579E2.9070507@web.de> <559B9B77.3020409@xenomai.org>
 <559BCBDB.7080208@xenomai.org>
In-Reply-To: <559BCBDB.7080208@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-07-07 14:53, Philippe Gerum wrote:
> On 07/07/2015 11:27 AM, Philippe Gerum wrote:
>> I tested the patch on ARM. Enabling IPIPE_DEBUG_INTERNAL there reveals a
>> bug with the mayday handler now turning hw IRQs on, as a result of
>> relaxing over the low level IRQ trampoline, which makes some I-pipe call
>> in the irq_handler boilerplate code unhappy. The very same issue is
>> looming on x86, with an unprotected call to __ipipe_root_p from
>> __ipipe_handle_irq(). Disabling IRQs before leaving the mayday handler
>> is required at the very least.
>>
> 
> Looking further, ARM is affected because it does not invoke
> __ipipe_call_mayday() for triggering the mayday trap, but still uses the
> open-coded method. This routine preserves the current hw state across
> the trap, which should make x86 safe in the end.

Which kernel version are you testing? It's not reproducing on 3.14 for
Cortex-A7/15 targets at least. And I find __ipipe_call_mayday in both
3.14 and 3.18 (fastcall_exit_check).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

