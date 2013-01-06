Message-ID: <50E993B7.9070201@xenomai.org>
Date: Sun, 06 Jan 2013 16:09:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com>
	<50E59112.6080005@siemens.com>	<50E94E72.5050309@xenomai.org>
	<50E95812.8050503@web.de> <50E959EC.8030306@web.de>
	<50E98242.30104@xenomai.org> <50E98849.5050903@web.de>
	<50E9897E.2000106@xenomai.org> <50E98E62.7090907@web.de>
In-Reply-To: <50E98E62.7090907@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping
 Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 01/06/2013 03:46 PM, Jan Kiszka wrote:

> On 2013-01-06 15:26, Gilles Chanteperdrix wrote:
>> On 01/06/2013 03:20 PM, Jan Kiszka wrote:
>>
>>> On 2013-01-06 14:55, Gilles Chanteperdrix wrote:
>>>> On 01/06/2013 12:03 PM, Jan Kiszka wrote:
>>>>
>>>>> On 2013-01-06 11:55, Jan Kiszka wrote:
>>>>>> On 2013-01-06 11:14, Philippe Gerum wrote:
>>>>>>> On 01/03/2013 03:09 PM, Jan Kiszka wrote:
>>>>>>>
>>>>>>>> +static struct xnvfile_lock_ops vfile_stat_lockops = {
>>>>>>>> +	.get = xnintr_get_query_lock,
>>>>>>>> +	.put = xnintr_put_query_lock,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>  static struct xnvfile_snapshot stat_vfile = {
>>>>>>>>  	.privsz = sizeof(struct vfile_stat_priv),
>>>>>>>>  	.datasz = sizeof(struct vfile_stat_data),
>>>>>>>>  	.tag = &nkpod_struct.threadlist_tag,
>>>>>>>>  	.ops = &vfile_stat_ops,
>>>>>>>> +	.entry = { .lockops = &vfile_stat_lockops },
>>>>>>>>  };
>>>>>>>
>>>>>>> This would introduce a regression. stat_vfile's rewind/next handlers
>>>>>>> compete with code altering the global thread queue which may run in
>>>>>>> primary mode, such as xnpod_delete_thread() when deleting a kernel task.
>>>>>>> So we can't use a linux lock to protect it.
>>>>>>
>>>>>> The Linux lock is held around this rewind loop (which is still in
>>>>>> place), and it is not protecting anything thread related, just the
>>>>>> appearance and disappearance of IRQs. I fail to see a conflict, and
>>>>>> there are also no I-pipe/Xenomai warnings triggered with this pattern.
>>>>>
>>>>> Oh, now I see: The nklock is automatically taken if there are no
>>>>> lockops. That needs to be done in the stat lockups as well, of course.
>>>>> Will fix.
>>>>
>>>>
>>>> The more I think about this, the more I find we should not be doing
>>>> this. Xenomai 2.6.x is a stable branch, let us stop making such changes,
>>>> this will allow us to start working on -forge. The warning is
>>>> essentially a false-positive, I do not see any problem calling
>>>> ipipe_virtualize_irq with the root domain stalled. We can skip it in the
>>>> I-pipe core patches when compiling with CONFIG_IPIPE_LEGACY.
>>>
>>> Well, we need to support 2.6 for quite a while here, so I'm interested
>>> in fixing such regressions,
>>
>>
>> I repeat again: there is no regression, it is not invalid to call
>> ipipe_virtualize_irq with the root domain stalled, and never was, the
>> warning is new and a false positive. I am opposed to changing intrlock
>> into a mutex with a lot of cascading consequences, the ones we see, the
>> ones we will discover when people start using the next release.
>>
>> If you want to benefit from the full instrumentation of the I-pipe core,
>> use xenomai-forge.
> 
> Unfortunately, forge wasn't ready for our workload last time we checked.
> That's why we are stabilizing I-pipe x86 over 2.6 here, and that's why
> we need working instrumentations also in legacy mode.
> 
> If you prefer to skip the warning in ipipe, then I will send a
> corresponding patch. The lock conversion is still necessary for forge,
> though.


There are other ways around, ipipe_virtualize_irq is already a wrapper
used only by 2.6, so we can add some code here. So, we can only check
ipipe_root_p here, and disable the warning in ipipe_request_irq.


-- 
                                                                Gilles.

