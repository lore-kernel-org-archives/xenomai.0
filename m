Message-ID: <4EFCF37F.6030603@domain.hid>
Date: Fri, 30 Dec 2011 00:10:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4E981906.6020400@domain.hid> <4E982C40.4040704@domain.hid>
	<4E982D79.7040308@domain.hid>
In-Reply-To: <4E982D79.7040308@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PULL] 2.6.38-noarch: Re-add root preemption
	notifier
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On 10/14/2011 02:39 PM, Jan Kiszka wrote:
> On 2011-10-14 14:34, Gilles Chanteperdrix wrote:
>> On 10/14/2011 01:12 PM, Jan Kiszka wrote:
>>> The following changes since commit 641d8e87531c6367a6357335378194ea06a23701:
>>>
>>>    ipipe: Prevent unwritable pages after mprotect (2011-07-21 09:51:56 +0200)
>>>
>>> are available in the git repository at:
>>>    git://git.kiszka.org/ipipe queues/2.6.38-noarch
>>>
>>> Jan Kiszka (1):
>>>        ipipe: Re-add root preemption notifier
>>>
>>>   include/linux/ipipe.h      |   35 +++++++++++++++++++++++++++++++++++
>>>   include/linux/ipipe_base.h |    2 +-
>>>   kernel/ipipe/core.c        |    6 ++++++
>>>   3 files changed, 42 insertions(+), 1 deletions(-)
>>>
>>> ---
>>>
>>> ipipe: Re-add root preemption notifier
>>>
>>> Restore the original root preemption notifiers, once added for 2.6.35
>>> but then lost again on 2.6.36 merge. Unfortunately, the feature flag was
>>> not lost. So it became meaningless and we have to rename it to
>>> __IPIPE_FEATURE_ROOTPREEMPT_NOTIFIER.
>>
>> The I-pipe defines a generic infrastructure for events, why bypassing it?
>>
>
> Because
>   - this is no kernel-to-ipipe event, but an ipipe-to-kernel (kvm) one
>   - there is no relation to domains here
>   - there is no relation to a shadow task here (the event is fired over
>     a pure Linux task)
>
> Jan
>

IIUC, this is a primary domain to KVM event, at least the way the 
Xenomai nucleus is supposed to trigger it, so we could have used a 
pipeline event hooked by the head domain as Gilles suggested. This said, 
there is no event propagation or domain migration to handle here, so 
this would likely be overkill.

I've picked both patches (Xenomai + pipeline) in my queue for 2.6.1 and 
2.6.38.8/x86. I'm not that happy with adding yet another per-cpu global 
variable to hold information the pipeline does not really care about 
(it's just a conveyor here), but as I'm refactoring the pipeline core, 
I'll work with you for a better integration if we can find one.

Thanks,

-- 
Philippe.

