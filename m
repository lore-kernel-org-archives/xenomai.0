Message-ID: <4E1BEE2C.7030800@domain.hid>
Date: Tue, 12 Jul 2011 08:48:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E160578.5020405@domain.hid> <4E16F032.1050905@domain.hid>
	<4E16F4E0.8020900@domain.hid>
In-Reply-To: <4E16F4E0.8020900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] ipipe: Prevent unwritable pages after
	mprotect
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 07/08/2011 02:15 PM, Jan Kiszka wrote:
> On 2011-07-08 13:55, Gilles Chanteperdrix wrote:
>> On 07/07/2011 09:14 PM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> Page protection changes issued via mprotect, e.g. to enable executable
>>> stacks, cause spurious minor faults as they remove the write permission
>>> from the modified range again. Avoid this by faking shared pages so that
>>> vm_get_page_prot returns the desired page permissions.
>>
>> This looks dangerous to me. Have you checked that write to private heaps
>> will not end up corrupting shared data?
> 
> Can't follow this yet.
> 
> If you check the comment on protection_map in mm/mmap.c, the difference
> between private and shared is in real write vs. COW-able write. That's
> what my patch is exploiting to get the proper arch-dependent page
> protection bits.
> 
> Are you aware of side effects or do you know a better way to inject
> write permissions into the protection flags?

I would tend to think that shared and private mappings do not react the
same way when we write to them.

In order to avoid the fault on first access, I would trigger a fault for
each page of the mapping, the way we do it in __rthal_arm_fault_range
(in ksrc/arch/arm/hal.c), but in the I-pipe kernel.

-- 
                                                                Gilles.

