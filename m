References: <1544c287-5653-6117-cba0-eb355b936887@xenomai.org>
 <060fda40-0ed3-5eff-f09a-7814547a3f9a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1cfad635-9ef9-b494-74db-6be2b3ebc2d8@xenomai.org>
Date: Mon, 1 Oct 2018 16:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <060fda40-0ed3-5eff-f09a-7814547a3f9a@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PULL] A couple of fixes to the split series for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild <henning.schild@siemens.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 10/01/2018 04:03 PM, Jan Kiszka wrote:
> On 01.10.18 15:28, Philippe Gerum wrote:
>>
>> The following changes since commit
>> be45333e3af13c3b7cb12ecd200cb9be7a8fb439:
>>
>>    x86: ipipe: do not panic on unexpected IRQ trap (2018-09-27
>> 09:09:52 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://lab.xenomai.org/ipipe-rpm.git x86/4.14.71
>>
>> for you to fetch changes up to c5540da918650be520d8f5331ec1944ccfcf6c53:
>>
>>    sched/core: ipipe: do not panic on failed migration to the head
>> stage (2018-10-01 15:10:59 +0200)
>>
>> ----------------------------------------------------------------
>> Philippe Gerum (2):
>>        ipipe: timer: prevent double-ack if host timer is not grabbed
>>        sched/core: ipipe: do not panic on failed migration to the head
>> stage
>>
>>   kernel/ipipe/timer.c | 11 +++++++----
>>   kernel/sched/core.c  |  2 --
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
> 
> I suppose both are not related to the sigdebug issue Henning noticed,

Nope.

> are they? Just the confirm if that issue is still open, or if we could
> start removing the "wip" from the 4.14 branch.
> 

I did not look at it.

> BTW, we should sign-off kernel commits as well.
> 

Ack.

-- 
Philippe.

