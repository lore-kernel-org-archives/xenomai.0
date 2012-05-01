Message-ID: <4F9FF996.2090906@domain.hid>
Date: Tue, 1 May 2012 10:56:22 -0400
From: Makarand Pradhan <makarandpradhan@domain.hid>
MIME-Version: 1.0
References: <4F9ED222.1020806@domain.hid> <4F9F9498.3040703@domain.hid>
In-Reply-To: <4F9F9498.3040703@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Powerpc alignment exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Philippe. That helps.

Rgds,
Makarand.

On 01/05/12 03:45 AM, Philippe Gerum wrote:
> On 04/30/2012 07:55 PM, Makarand Pradhan wrote:
>> Hi,
>>
>> There has been a thread on this topic in the past:
>>
>> https://mail.gna.org/public/xenomai-help/2009-08/msg00023.html
>>
>> A quick background: We get the alignment exception, as we pass
>> -fpack-struct option to gcc and some data in structures is misaligned.
>>
>> I have been testing the patch on Linux 3.0.0, Xenomai 2.6 and it seems
>> to work well. Do you think, it requires any additional changes to be
>> used with Xenomai 2.6?
> This is not related to the Xenomai core, this is a pipeline issue. You
> can use whatever pipeline patch you need to.
>
>> Also, I am trying to understand how it works and have a question. Am
>> summarizing my understanding below. Would appreciate your comments:
>>
>> alignment_exception:
>>
>> + if (test_bit(IPIPE_NOSTACK_FLAG,&ipipe_this_cpudom_var(status))&&
>> + ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT, regs))
>> return;
>>
>> I believe, the IPIPE_NOSTACK_FLAG is set when we are running in Linux.
> NOSTACK means "no linux task stack", i.e. Xenomai kernel thread context,
> i.e. primary only, therefore non-linux.
>
>> So we should invoke ipipe_trap_notify only while we are running in
>> linux. While running in the primary domain, we would go ahead and fix
>> the alignment.
>>
>>
>> + if (!ipipe_root_domain_p&&
>> + ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT, regs))
>> + return;
>> +
>> I am not able to figure this part properly. If we are not in the root
>> domain we invoke ipipe_trap_notify. (I believe root domain = Linux). So
>> if we are in the primary, we would invoke ipipe_trap_notify.
>> ipipe_trap_notify in turn would invoke the event handler
>> (xnpod_trap_fault). This would send us to the secondary domain. All the
>> same, we stay int he primary as per my tests. So, I am making a mistake
>> somewhere. Would appreciate your opinion.
>>
> The kernel is able to do some dynamic fixup when an alignment fault
> occurs, by decoding the offending instruction manually, unless this
> could only be resolved as an access fault.
>
> If the entry context is not a linux task, then we can only divert the
> code to the Xenomai fault handler, which will suspend the Xenomai kernel
> thread then tell us to return (first patch hunk). Otherwise we want to
> let the kernel attempt a fix up for "current". If that does not work,
> then we need Xenomai to handle the fault for switching the context to
> secondary mode in case we entered the alignment handler in primary mode
> (second patch hunk).
>
> The bottom line is that we shall either do the fix up then return
> immediately with no mode change, or run the linux access fault handler
> in secondary mode.
>
>> Rgds,
>> Makarand.
>>
>>
>>
>>
>


-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


