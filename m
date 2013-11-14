Message-ID: <52853150.8040408@xenomai.org>
Date: Thu, 14 Nov 2013 21:23:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <528290CE.1030002@xenomai.org> <52837DD0.1050405@siemens.com>
 <52838180.7070701@xenomai.org> <5283846B.8070004@siemens.com>
 <52852654.3020404@siemens.com>
In-Reply-To: <52852654.3020404@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/14/2013 08:36 PM, Jan Kiszka wrote:
> On 2013-11-13 14:53, Jan Kiszka wrote:
>> On 2013-11-13 14:41, Gilles Chanteperdrix wrote:
>>> On 11/13/2013 02:25 PM, Jan Kiszka wrote:
>>>> On 2013-11-12 21:34, Gilles Chanteperdrix wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> for a change, I ran the xeno-regression-test with a lot of debugging and
>>>>> options known to having caused problems in the past and found two
>>>>> issues:
>>>>>
>>>>> on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
>>>>> debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
>>>>> series of warnings at the end of the mail.
>>>>
>>>> We are currently facing crashes inside __switch_to, FPU related
>>>> (non-existing save area).
>>>
>>> Probably the issue solved by this patch:
>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=9b3320eef67e3f118f96065c8c2584b715710d94
>>
>> Thought I had everything, but I lost track, and it's missing here. Will
>> merge and give it a try.
> 
> OK, this fixes the crash in __switch_to, triggerable by terminating
> xeno-test while running clocktest. But we still face a crash when
> terminating switchtest early. Are you aware of this?

No, I was talking about Xenomai 2.6.3, not forge.


-- 
                                                                Gilles.

