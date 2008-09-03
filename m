Message-ID: <48BE7B64.8090501@domain.hid>
Date: Wed, 03 Sep 2008 13:56:20 +0200
From: Giulio Gaio <giulio.gaio@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] mpc8641d smp hangs on boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,
i have some problems with smp on mpc8641d (which equips a vme cpu board 
mvme7100).
I'm using linux-2.6.20 (which is the only version supported by the board 
manifacturer) patched with xenomai 2.4.3.
The cpu (which performs a tftpboot) boots fine in up mode.
Instead, when enabling smp, it freezes after enabling the ipipe ("I-pipe 
1.7-13: pipeline enabled");
I have inserted in the kernel code some printk's to find the point of 
freezing and i have found that it is located in kernel/printk.c in the 
acquire_console_sem() just before down(&console_sem). See the console 
output below of the boot.


Linux/PowerPC load: console=ttyS0,9600 root=/dev/nfs ip=::::::dhcp
Finalizing device tree... flat tree at 0x799000
Using MVME7100 machine description
Total memory = 1024MB; using 2048kB for hash table (at 8fe00000)
Linux version 2.6.20-xeno-2.4.3 (giulio@domain.hid) (gcc version 4.1.3 
20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #27 SMP PR8
kernel/printk.c - acquire_console_sem(): before BUG_ON(in_interrupt());
kernel/printk.c - acquire_console_sem(): after BUG_ON(in_interrupt());
kernel/printk.c - acquire_console_sem(): before  if (console_suspended)
kernel/printk.c - acquire_console_sem(): before down(&console_sem);
kernel/printk.c - acquire_console_sem(): after down(&console_sem);
kernel/printk.c - acquire_console_sem(): after console_may_schedule = 1;
Found FSL PCI host bridge at 0x00000000f1008000.Firmware bus number: 0->255
Found FSL PCI host bridge at 0x00000000f1009000.Firmware bus number: 0->255
MVME7100 board from Emerson Network Power - Embedded Computing
L2 cache enabled. L2CTL reg: 0xb0000000
Zone PFN ranges:
  DMA             0 ->   262144
  Normal     262144 ->   262144
  HighMem    262144 ->   262144
early_node_map[1] active PFN ranges
    0:        0 ->   262144
Built 1 zonelists.  Total pages: 260096
Kernel command line: console=ttyS0,9600 root=/dev/nfs ip=::::::dhcp
linux/init/main.c - start_kernel(): before sort_main_extable();
linux/init/main.c - start_kernel(): before trap_init();
linux/init/main.c - start_kernel(): before rcu_init();
linux/init/main.c - start_kernel(): before init_IRQ();
mpic: Setting up MPIC " MPIC     " version 1.2 at f1040000, max 2 CPUs
mpic: ISU size: 16, shift: 4, mask: f
mpic: Initializing for 80 sources
linux/init/main.c - start_kernel(): before pidhash_init();
PID hash table entries: 4096 (order: 12, 16384 bytes)
linux/init/main.c - start_kernel(): before init_timers();
linux/init/main.c - start_kernel(): before hrtimers_init();
linux/init/main.c - start_kernel(): before softirq_init();
linux/init/main.c - start_kernel(): before timekeeping_init();
linux/init/main.c - start_kernel(): before time_init();
linux/init/main.c - start_kernel(): before ipipe_init();
I-pipe 1.7-13: pipeline enabled.
linux/init/main.c - start_kernel(): before profile_init();
linux/init/main.c - start_kernel(): before if (!irqs_disabled());
linux/init/main.c  - start_kernel(): before local_irq_enable();
linux/init/main.c - start_kernel(): before console_init();
drivers/char/tty_io.c - console_init(void): before disable_early_printk()
arch/powerpc/kernel/udbg.c - disable_early_printk(): before 
unregister_console()
kernel/printk.c - unregister_console(): before acquire_console_sem();
kernel/printk.c - acquire_console_sem(): before BUG_ON(in_interrupt());
kernel/printk.c - acquire_console_sem(): after BUG_ON(in_interrupt());
kernel/printk.c - acquire_console_sem(): before  if (console_suspended)
kernel/printk.c -  : before down(&console_sem);
-------------- CPU freezed ---------------


I have found on the net that there are patches for printk.c due possible 
racing conditions during the boot in smp configuration (see 
http://www.ussg.iu.edu/hypermail/linux/kernel/0804.1/0258.html).
So this could be the problem.
But it could be also that the printk's, which i inserted, determined 
that the freezing point was in one of the printk.c functions and there 
is a more general problem of locking/unlocking resources in smp 
configuration.

In the end, in my case, vanilla linux-2.60.20-smp works, 
linux-2.60.20-smp-xenomai doesn't work, linux-2.60.20-up-xenomai works.

So my question (and my doubt) is: has anyone worked with mpc8641d with 
linux-2.60.20 smp and xenomai?

Any help will be appreciated.

    Giulio Gaio


