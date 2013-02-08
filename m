Message-ID: <5114BFB7.7090709@xenomai.org>
Date: Fri, 08 Feb 2013 10:04:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5114BE02.6040901@sirius-es.it> <5114BF43.4010808@xenomai.org>
In-Reply-To: <5114BF43.4010808@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Backport Xenomai-26 to Linux 2.6.29.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Cc: xenomai@xenomai.org

On 02/08/2013 10:02 AM, Philippe Gerum wrote:
> On 02/08/2013 09:57 AM, Matteo Facchinetti wrote:
>> Hi,
>>
>> We decided to try to backport the
>> adeos-ipipe-2.6.36.4-powerpc-2.12-05.patch against the Linux 2.6.29.1
>> kernel but we encountered problems with spinlock handling:
>>
>> In the 2.6.29 kernel, we found some differences about spinlock
>> structures hierarchy. In detail at kernel side we have only
>> raw_spinlock_t and spinlock_t but xenomai (ipipe_lock.h) uses
>> arch_spinlock_t, raw_spinlock_t and spinlock_t.
>> Those differences will force us to heavily modify the spinlock handling
>> in the xenomai patch, deleting a layer and replacing arch_spinlock_t
>> with raw_spinlock_t and raw_spinlock_t with spinlock_t.
>>
>> Is there an old patch file that contains spinlock handling compliant
>> with 2.6.29.1 kernel and xenomai 2.6?
>>
>
> This is clearly an area of the I-pipe code you should NOT backport, at
> all. You should keep the one avail with 2.6.29.1, and fix up the
> generic/arch-dep portions of the pipeline code accordingly.
>
>

In short, do not backport include/ipipe_lock.h.

-- 
Philippe.

