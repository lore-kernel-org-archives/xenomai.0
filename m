Message-ID: <47BBF098.8030409@domain.hid>
Date: Wed, 20 Feb 2008 10:19:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <23559868.1203495913401.JavaMail.ngmail@domain.hid>
In-Reply-To: <23559868.1203495913401.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Atomic 64 bit write access on PCIe device
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi everybody,
> 
> perhaps this issue is off-topic, but I expect that there are many experts on that issue reading the Xenomai list...
> I have a Core2Duo Intel CPU (32 bit mode) and a proprietary PCI Express I/O board plugged in.
> This PCI Express I/O board has some 64 bit registers that are mapped into address space via mmap.
> Now, I want to write atomically (one PCIe access) to one of the 64 bit registers.
> Unfortunately, the Intel CPUs does not have an atomic 64 bit write operations when running the CPU in 32 bit mode.
> When doing something like
> 
> volatile unsigned long long *ull = register_address;
> *ull = my_new_register_value;
> 
> I see the gcc is generating two 32 bit write accesses. Of course this will not lead to an atomic 64 bit write access.
> 
> Any idea, how I can write 64 bit integers atomically to such an 64 bit register?
>

Assuming this register may only be accessed from userland through
mmapped memory (and not concurrently from a kernel driver), and that you
may write this value as 2 x 32bit as far as the hw is concerned but you
want to avoid software access races doing so, something like this would
probably do:

iopl(3)
...
mutex_lock(&lock); /* prevent SMP race */
asm volatile("cli"); /* prevent local preemption */
*ull = my_new_register_value;
asm volatile("sti");
mutex_unlock(&lock);

Yeah, that's pretty ugly. Yum.

> 
> Thanks for any feedback!
> 
> Regards
> 
> Mathias
> 


-- 
Philippe.

