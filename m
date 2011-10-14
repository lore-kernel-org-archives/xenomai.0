Message-ID: <4E982D79.7040308@domain.hid>
Date: Fri, 14 Oct 2011 14:39:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E981906.6020400@domain.hid> <4E982C40.4040704@domain.hid>
In-Reply-To: <4E982C40.4040704@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 2011-10-14 14:34, Gilles Chanteperdrix wrote:
> On 10/14/2011 01:12 PM, Jan Kiszka wrote:
>> The following changes since commit 641d8e87531c6367a6357335378194ea06a23701:
>>
>>   ipipe: Prevent unwritable pages after mprotect (2011-07-21 09:51:56 +0200)
>>
>> are available in the git repository at:
>>   git://git.kiszka.org/ipipe queues/2.6.38-noarch
>>
>> Jan Kiszka (1):
>>       ipipe: Re-add root preemption notifier
>>
>>  include/linux/ipipe.h      |   35 +++++++++++++++++++++++++++++++++++
>>  include/linux/ipipe_base.h |    2 +-
>>  kernel/ipipe/core.c        |    6 ++++++
>>  3 files changed, 42 insertions(+), 1 deletions(-)
>>
>> ---
>>
>> ipipe: Re-add root preemption notifier
>>
>> Restore the original root preemption notifiers, once added for 2.6.35
>> but then lost again on 2.6.36 merge. Unfortunately, the feature flag was
>> not lost. So it became meaningless and we have to rename it to
>> __IPIPE_FEATURE_ROOTPREEMPT_NOTIFIER.
> 
> The I-pipe defines a generic infrastructure for events, why bypassing it?
> 

Because
 - this is no kernel-to-ipipe event, but an ipipe-to-kernel (kvm) one
 - there is no relation to domains here
 - there is no relation to a shadow task here (the event is fired over
   a pure Linux task)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

