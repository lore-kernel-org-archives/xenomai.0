Subject: Re: [Adeos-main] sysenter / sysexit with Adeos
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <B213B204A377E148A31BC71DE4955C97029AF292@domain.hid>
References: 
	 <B213B204A377E148A31BC71DE4955C97029AF292@domain.hid>
Content-Type: text/plain
Message-Id: <1094157066.622.18.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 22:31:06 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Neugebauer Manfred <manfred.neugebauer@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2004-09-02 at 10:10, Neugebauer Manfred wrote:
> I'm using the Adeos nanokernel (2.6.8.1-i386-r6) within a project to
> implement a specific realtime environment embedded within Linux. I
> recognized the following problem within the routines for the kernel entry
> calls which we also use for our special code:
> 
> For every call to the Linux kernel (x86 architecture using Int 0x80) Adeos
> provides a hook within entry.s to call a subroutine within a higher priority
> domain. When this subroutine returns a nonzero value, the "standard" code
> sequence in entry.s is stopped and the code returns immediately. 
> 
> This works also when you use the kernel entry via sysenter() which is much
> faster. However, when the subroutine of the higher priority domain wants to
> skip the "standard" code sequence during its return, Adeos uses a normal
> "iret" to leave the kernel. The "standard" procedure would be to use
> sysexit(). As a result returning back to the user code costs much more time
> with Adeos than within Linux.
> 
> I wonder whether there are reasons for this different behavior or whether it
> was simply forgotten. I modified the code in this way that Adeos also uses
> sysexit() and did not recognize any problems so far but a performance gain.
> 

The reason for this is... my mistake; I overlooked this.
sysenter_entry() should not branch to .adeos_restore_all but rather to
the sysexit portion, you are right. Patch welcome.

PS: if you happen to chase latencies with 2.6.8.1 in SMP mode, be aware
that something still needs to be fixed for Adeos in asm-i386/spinlock.h
(just found it this afternoon actually), namely, the brand new
spin_lock_string_flags macro which embeds verbative cli/sti pairs in
order to release interrupts while spinning. This already proved to
induce massive jittery to high priority domains (bad side-effect with
IRQ virtualization). Fortunately, only 2.6.8.1/x86-SMP is concerned as
of now. UP is ok. I'll fix this asap.

> Manfred
> 
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


