Message-ID: <4E1DE646.1090900@domain.hid>
Date: Wed, 13 Jul 2011 20:39:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid> <4E1C302A.8050309@domain.hid>
	<4E1C3301.2030203@domain.hid> <4E1C3672.1030104@domain.hid>
	<4E1C36EE.70803@domain.hid> <4E1C38CE.7090202@domain.hid>
	<4E1C3A5D.3020700@domain.hid> <4E1C44B4.50106@domain.hid>
	<4E1C8508.5010400@domain.hid> <4E1C858A.7070403@domain.hid>
	<4E1C86A1.6030707@domain.hid> <4E1C87BB.7000307@domain.hid>
In-Reply-To: <4E1C87BB.7000307@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/12/2011 07:43 PM, Jan Kiszka wrote:
> On 2011-07-12 19:38, Gilles Chanteperdrix wrote:
>> On 07/12/2011 07:34 PM, Jan Kiszka wrote:
>>> On 2011-07-12 19:31, Gilles Chanteperdrix wrote:
>>>> On 07/12/2011 02:57 PM, Jan Kiszka wrote:
>>>>>  			xnlock_put_irqrestore(&nklock, s);
>>>>>  			xnpod_schedule();
>>>>>  		}
>>>>> @@ -1036,6 +1043,7 @@ redo:
>>>>>  	 * to process this signal anyway.
>>>>>  	 */
>>>>>  	if (rthal_current_domain == rthal_root_domain) {
>>>>> +		XENO_BUGON(NUCLEUS, xnthread_test_info(thread, XNATOMIC));
>>>>
>>>> Misleading dead code again, XNATOMIC is cleared not ten lines above.
>>>
>>> Nope, I forgot to remove that line.
>>>
>>>>
>>>>>  		if (XENO_DEBUG(NUCLEUS) && (!signal_pending(this_task)
>>>>>  		    || this_task->state != TASK_RUNNING))
>>>>>  			xnpod_fatal
>>>>> @@ -1044,6 +1052,8 @@ redo:
>>>>>  		return -ERESTARTSYS;
>>>>>  	}
>>>>>  
>>>>> +	xnthread_clear_info(thread, XNATOMIC);
>>>>
>>>> Why this? I find the xnthread_clear_info(XNATOMIC) right at the right
>>>> place at the point it currently is.
>>>
>>> Nope. Now we either clear XNATOMIC after successful migration or when
>>> the signal is about to be sent (ie. in the hook). That way we can test
>>> more reliably (TM) in the gatekeeper if the thread can be migrated.
>>
>> Ok for adding the XNATOMIC test, because it improves the robustness, but
>> why changing the way XNATOMIC is set and clear? Chances of breaking
>> thing while changing code in this area are really high...
> 
> The current code is (most probably) broken as it does not properly
> synchronizes the gatekeeper against a signaled and "runaway" target
> Linux task.
> 
> We need an indication if a Linux signal will (or already has) woken up
> the to-be-migrated task. That task may have continued over its context,
> potentially on a different CPU. Providing this indication is the purpose
> of changing where XNATOMIC is cleared.

What about synchronizing with the gatekeeper with a semaphore, as done
in the first patch you sent, but doing it in xnshadow_harden, as soon as
we detect that we are not back from schedule in primary mode? It seems
it would avoid any further issue, as we would then be guaranteed that
the thread could not switch to TASK_INTERRUPTIBLE again before the
gatekeeper is finished.

What worries me is the comment in xnshadow_harden:

	 * gatekeeper sent us to primary mode. Since
	 * TASK_UNINTERRUPTIBLE is unavailable to us without wrecking
	 * the runqueue's count of uniniterruptible tasks, we just
	 * notice the issue and gracefully fail; the caller will have
	 * to process this signal anyway.
	 */

Does this mean that we can not switch to TASK_UNINTERRUPTIBLE at this
point? Or simply that TASK_UNINTERRUPTIBLE is not available for the
business of xnshadow_harden?

-- 
                                                                Gilles.

