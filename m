Message-ID: <46B99755.2010508@domain.hid>
Date: Wed, 08 Aug 2007 12:13:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46B1A842.1090708@domain.hid>	
	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>	
	<1186053839.6611.326.camel@domain.hid>
	<46B2E1B3.2020102@domain.hid>	
	<2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>	
	<1186401270.5963.2.camel@domain.hid>	
	<b647ffbd0708070758t22f01577wd3a5397a53249459@domain.hid>	
	<b647ffbd0708080040g7d798f16oe9e03ff233099e33@domain.hid>	
	<46B97B82.8010401@domain.hid>
	<b647ffbd0708080212y68853e6dw85210e9d038b2322@domain.hid>
In-Reply-To: <b647ffbd0708080212y68853e6dw85210e9d038b2322@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko wrote:
> Heikki and Wolfgang, thanks for the links.
> 
>>> Now, Xenomai is not able (at the moment) to do [*] on its own.. thus,
>>> there is a switch to the secondary mode so that Linux is able to take
>>> care of it.
>> But normal TLB misses happen frequently and do not force a switch to
>> secondary mode. I think the problem is with the do_page_fault trap.
> 
> This would make sense indeed. I presume, there must be some sort of
> inter-domain synchronization in place to safely access the 'page
> tables' for the fast-path of a TLB-miss handler to run in the primary
> mode (chores: so go and read the code.. ah well  :-)
> 
> Then a remaining part is do_page_fault() and one of the reasons can be
> 'cow' indeed.
> 
> As a side note (not PPC related so one may skip this part),
> 
> on MIPS do_page_fault() may be caused by accessing a valid address
> allocated by a kernel module (say, vmalloc()). Say,
> 
> - task_1 calls ioctl() of some driver which does obj = vmalloc() . As a result,
> task_1 :: page_tables are updated accordingly + so called
> 'master_table' gets updated;
> 
> - task_2 calls ioctl() to the same driver which, in turn, accesses 'obj' .
> Now, if there is no TLB record in place at the moment  --> TLB miss
> --> TLB-miss handler looks at task_2 :: page_tables but there is no
> record! --> do_page_fault() --> verifies a 'fault address' against the
> 'master_table' and if it's ok, copies a record from 'master_table' to
> task_2 :: page_tables --> update TLB, etc.
> 
> although, it's kind of a 'cow' mech. Provided, do_page_fault() is not
> handled in the primary mode.. so to avoid it, I guess, one would need
> to immediately sync. RT_task :: page_tables upon any vmalloc() in the
> system. Sure, in theory, 'master_table' could have been always used
> for translation of the kernel space vmalloc()'ed areas.. but that
> somewhat complicates a TLB-miss handler : maybe size, speed,
> sychronization, I guess (humm.. interesting why it's not actually like
> that.. maybe smth else).
> 
>>> e.g. on MIPS, the area used for kernel modules also requires
>>> virtual->physical translation.. so even a kernel-mode task (and
>>> actually, interrupt handlers inside the kernel modules) cause TLB-miss
>>> exceptions. Sure, it's not a case if it's linked against the kernel
>>> itself.
>> Even kernel code may cause a TLB miss. TLB pinning has been abandoned on
>> some PowerPC archs because it does reduce overall system performance.
> 
> Humm.. interesting. AFAIK, on MIPS [ 0x80000000, 0xa0000000 ] and [
> 0xa0000000, 0xc0000000 ] are just directly mapped onto the physical
> memory, cached and non-cached mode respectively. This avoids a need
> for TLB.

This is done in a similar way for PowerPC CPUs with a "standard" MMU. 
The kernel address space is then directly mapped with a Block Address 
Translation (BAT) register. My statement is valid for systems with just 
64 TLB entries or less (4xx, 8xx) and pinning one or two of them has an 
impact on user space performance.

>> See above. Unfortunately, I do only a limited, global view of the MMU
>> implementation for PowerPC.
> 
> Thanks indeed!

Just found the following article comparing 6xx/7xx with 4xx:

http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF7785256997006EB430/$file/4xx_6xx_an.pdf

It also highlights the difference between (Data/Instruction) TLB miss 
and Data (Load/Store) Translation miss.

Wolfgang.

