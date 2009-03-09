Message-ID: <49B4EC7D.6020907@domain.hid>
Date: Mon, 09 Mar 2009 11:16:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49B39DB5.8040601@domain.hid> <49B3A61E.3040306@domain.hid>
	<49B4DF0E.9050707@domain.hid> <49B4E225.5080401@domain.hid>
	<49B4E3C0.6030804@domain.hid>
In-Reply-To: <49B4E3C0.6030804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnshadow_relax in taskexit_event
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi,
>>>>>
>>>>> this looks suspicious to me:
>>>>>
>>>>> static inline void do_taskexit_event(struct task_struct *p)
>>>>> {
>>>>>     ...
>>>>>     if (xnpod_shadow_p())
>>>>>         xnshadow_relax(0);
>>>>>
>>>>> A) The only call context of this hook is do_exit() - and that's Linux
>>>>> kernel code which should always run in secondary mode, no?
>>>>>
>>>> It is a left-over from the days when do_exit() could be called from
>>>> primary context directly on behalf on the shadow unmapping code; now
>>>> we go through an APC, so that should be ok.
>>> Mmm, then I wonder if we shouldn't be able to drop the explicit
>>> xnpod_schedule() from do_taskexit_event() as well: we always enter this
>>> code over the ROOT thread, and xnpod_delete_thread() will only kill a
>>> suspended thread. So there should be no need to reschedule afterwards.
>>> Will post an updated patch.
>>>
>> Nak, the deletion hook may alter the scheduling state.
> 
> OK. Is such a hook expected to call xnsched_set_resched in that case,
> ie. can we drop it?
>

Yes, 2.5 only.

> Jan
> 


