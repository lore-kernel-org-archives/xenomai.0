Subject: Re: [Adeos-main] non-atomic bitop in __adeos_stall_root()
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <1106859277.707.64.camel@domain.hid>
References: <1106857570.3241.76.camel@domain.hid>
	 <1106859277.707.64.camel@domain.hid>
Content-Type: text/plain
Message-Id: <1106861559.707.72.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 27 Jan 2005 22:32:39 +0100
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
To: Michael Neuhauser <mike@domain.hid>
Cc: "Adeos-Main@domain.hid" <adeos-main@gna.org>

On Thu, 2005-01-27 at 21:54, Philippe Gerum wrote:
> On Thu, 2005-01-27 at 21:26, Michael Neuhauser wrote:
> > Hello!
> > 
> > During my work on Adeos for ARM I've noticed the following: In
> > __adeos_stall_root() (both 2.4 & 2.6) the stall flag is set like this:
> > 
> > 	adeos_get_cpu(flags);
> > 	__set_bit(IPIPE_STALL_FLAG,&adp_root->cpudata[cpuid].status);
> > 	adeos_put_cpu(flags);
> > 
> > I don't understand why the non-atomic __set_bit() is used instead of the
> > atomic set_bit(). Maybe someone can shed some light on this.
> > 
> > Suppose we have a non-SMP machine. In this case, adeos_get_cpu() is a
> > nop. Hence, hw-irqs may be enabled when __set_bit() is executed. On ARM,
> > __set_bit() is implemented as
> > 
> > 	read from memory; modify register; write to memory
> > 
> > Assume an interrupt happens after the read and before the write and that
> > some other bit of "status" is modified during the interrupt
> > => this modification is lost as the interrupted __set_bit() uses the
> > value of "status" before the interrupt!
> > 
> > This may not happen on i386 where __set_bit() is implemented as a single
> > asm instruction (which I assume is interrupt safe). But as
> > __adeos_stall_root() is contained in include/linux/adeos.h (i.e. generic
> > code) I think the atomic bitop has to be used.
> > 
> > __adeos_test_and_stall_root() and adeos_unstall_pipeline_from() also use
> > some non-atomic bitop without ensuring that hw-interrupts are disabled.
> > 
> 
> Ack, it's a bug non-x86 wise; likely a collision between two past change
> sets, namely using adeos_get_cpu() when adeos_lock_cpu() would have been
> overkill on UP, and set/clear_bits() changed to __set/__clear_bits() for
> the same reason given that the interrupts were guaranteed to be off at
> that time. The problem is that #1 came after #2, and introduced this bug
> recently

Should be fixed in the CVS by now. I tried to refrain from using the
adeos_get_cpu/adeos_put_cpu construct but rather differenciate the
UP/SMP cases explicitely, because the former is confusing and leads to
less efficient code in the UP case. At some point in time, I guess that
we will need to get rid of them completely.

> .
> 
> > Mike
-- 

Philippe.


