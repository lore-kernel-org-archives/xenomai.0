Message-ID: <4C35A3F3.6040005@domain.hid>
Date: Thu, 08 Jul 2010 12:09:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com>		<4C34438D.9020905@domain.hid>		<AANLkTiklX49KAfAlZND9FhVaTJZpdADFpuUIO-lkm6f6@domain.hid>		<4C34EF76.2040602@domain.hid>		<AANLkTik9RCKn90TnCj3JWBQF_XWaHbH0vSgp2vOu8HfH@mail.gmail.com>		<4C3508E1.7090100@domain.hid>		<1278578261.1810.67.camel@domain.hid>		<4C359326.1090509@domain.hid>		<1278581479.1810.111.camel@domain.hid>		<4C359BE7.6080608@domain.hid>	<1278583089.1810.131.camel@domain.hid>
	<4C35A2B3.9060606@domain.hid>
In-Reply-To: <4C35A2B3.9060606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native: A 32k stack is not always a 'reasonable'
 size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> On Thu, 2010-07-08 at 11:35 +0200, Gilles Chanteperdrix wrote:
>>> +       down_read(&mm->mmap_sem);
>>> +       if (find_vma(mm, addr) == find_vma(mm, regs->ARM_sp))
>>> +               printk(KERN_INFO "FCSE: process %u(%s) probably overflowed stack
>>>  at 0x%08lx.\n",
>>> +                      current->pid, current->comm, regs->ARM_pc);
>>> +       up_read(&mm->mmap_sem);
>>>
>> My understanding is that such code detects faulty references within the
>> _valid_ address space, typically when hitting a page guard area. But I
>> guess that this won't work when treading on stack memory outside of the
>> address space, e.g. below the red zone for instance, isn't it? AFAIU,
>> those things may happen when the heading space of preposterously large
>> stack-based objects are addressed.
> 
> Yes, exactly, but that would have been enough to detect Peter's problem.
> I thought gcc had an option to yell when the objects on stack grow
> beyond some size, but I can not find it.

The option is enabled by the kernel when enabling CONFIG_WARN_FRAME, and
is -Wframe-larger-than
It seems to require gcc 4.4 though.

-- 
					    Gilles.

