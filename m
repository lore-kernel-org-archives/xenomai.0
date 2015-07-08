References: <558579E2.9070507@web.de> <559B9B77.3020409@xenomai.org>
 <559BCBDB.7080208@xenomai.org> <559CFBE7.3050802@siemens.com>
 <559D0FEC.8030606@xenomai.org> <559D1689.2020102@siemens.com>
 <20150708123205.GM20176@hermes.click-hack.org> <559D189A.8060800@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <559D1B05.9010503@xenomai.org>
Date: Wed, 8 Jul 2015 14:43:49 +0200
MIME-Version: 1.0
In-Reply-To: <559D189A.8060800@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 07/08/2015 02:33 PM, Jan Kiszka wrote:
> On 2015-07-08 14:32, Gilles Chanteperdrix wrote:
>> On Wed, Jul 08, 2015 at 02:24:41PM +0200, Jan Kiszka wrote:
>>> On 2015-07-08 13:56, Philippe Gerum wrote:
>>>> On 07/08/2015 12:31 PM, Jan Kiszka wrote:
>>>>> On 2015-07-07 14:53, Philippe Gerum wrote:
>>>>>> On 07/07/2015 11:27 AM, Philippe Gerum wrote:
>>>>>>> I tested the patch on ARM. Enabling IPIPE_DEBUG_INTERNAL there reveals a
>>>>>>> bug with the mayday handler now turning hw IRQs on, as a result of
>>>>>>> relaxing over the low level IRQ trampoline, which makes some I-pipe call
>>>>>>> in the irq_handler boilerplate code unhappy. The very same issue is
>>>>>>> looming on x86, with an unprotected call to __ipipe_root_p from
>>>>>>> __ipipe_handle_irq(). Disabling IRQs before leaving the mayday handler
>>>>>>> is required at the very least.
>>>>>>>
>>>>>>
>>>>>> Looking further, ARM is affected because it does not invoke
>>>>>> __ipipe_call_mayday() for triggering the mayday trap, but still uses the
>>>>>> open-coded method. This routine preserves the current hw state across
>>>>>> the trap, which should make x86 safe in the end.
>>>>>
>>>>> Which kernel version are you testing? It's not reproducing on 3.14 for
>>>>> Cortex-A7/15 targets at least. And I find __ipipe_call_mayday in both
>>>>> 3.14 and 3.18 (fastcall_exit_check).
>>>>>
>>>>
>>>> Looking at the code, any kernel version since 3.10 will have the same
>>>> issue, older ones likely too, tested on 3.18.12. This does not depend on
>>>> the ARM target.
>>>>
>>>> irq_handler from entry-armv.S:
>>>> 	=> __ipipe_grab_irq (or indirecty via ipipe_handle_multi_irq with
>>>> MULTI_IRQ enabled)
>>>> 		=> __ipipe_exit_irq (open coded __ipipe_notify_trap(MAYDAY),
>>>> xnthread_relax() re-enables hw IRQs)
>>>> 	=> __ipipe_check_root_interruptible (from irq_handler)
>>>> 		BAD: __ipipe_root_p tested with CPU migration enabled
>>>>
>>>
>>> Maybe [1] makes the difference here? I think I had to fix this for a
>>> different reason.
>>
>> Except this does not work over legacy kernel thread stacks..
> 
> Xenomai 2 is out of scope for these changes on mayday and for gdb
> improvements.
> 

Testing CONFIG_IPIPE_LEGACY for such change would be required then.

-- 
Philippe.

