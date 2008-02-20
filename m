Message-ID: <2ff1a98a0802200055o54fd1a43j265e80594ed08f17@domain.hid>
Date: Wed, 20 Feb 2008 09:55:27 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <23559868.1203495913401.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <23559868.1203495913401.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Atomic 64 bit write access on PCIe device
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

On Feb 20, 2008 9:25 AM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
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
>
> Thanks for any feedback!

Maybe using a spinlock would be possible ?
I do not think that using inline assembly would work (I would expect
the assembler to refuse 64 bits instructions when in 32 bits mode).
Why not compiling the kernel and Xenomai in 64 bits mode ?

-- 
                                               Gilles Chanteperdrix

