From: Michael Neuhauser <mike@domain.hid>
Content-Type: text/plain
Message-Id: <1106857570.3241.76.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 27 Jan 2005 21:26:12 +0100
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] non-atomic bitop in __adeos_stall_root()
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
To: "Adeos-Main@domain.hid" <adeos-main@gna.org>

Hello!

During my work on Adeos for ARM I've noticed the following: In
__adeos_stall_root() (both 2.4 & 2.6) the stall flag is set like this:

	adeos_get_cpu(flags);
	__set_bit(IPIPE_STALL_FLAG,&adp_root->cpudata[cpuid].status);
	adeos_put_cpu(flags);

I don't understand why the non-atomic __set_bit() is used instead of the
atomic set_bit(). Maybe someone can shed some light on this.

Suppose we have a non-SMP machine. In this case, adeos_get_cpu() is a
nop. Hence, hw-irqs may be enabled when __set_bit() is executed. On ARM,
__set_bit() is implemented as

	read from memory; modify register; write to memory

Assume an interrupt happens after the read and before the write and that
some other bit of "status" is modified during the interrupt
=> this modification is lost as the interrupted __set_bit() uses the
value of "status" before the interrupt!

This may not happen on i386 where __set_bit() is implemented as a single
asm instruction (which I assume is interrupt safe). But as
__adeos_stall_root() is contained in include/linux/adeos.h (i.e. generic
code) I think the atomic bitop has to be used.

__adeos_test_and_stall_root() and adeos_unstall_pipeline_from() also use
some non-atomic bitop without ensuring that hw-interrupts are disabled.

Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/



