Message-ID: <4BB22A99.4010705@domain.hid>
Date: Tue, 30 Mar 2010 18:45:13 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <162274.76484.qm@domain.hid>
In-Reply-To: <162274.76484.qm@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020008040409050001080703"
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space
	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chtourou Sonda <chtourou_sonda@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020008040409050001080703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by plan.enseirb.fr id o2UGiWIs002997

Le 30/03/2010 17:40, Chtourou Sonda a =C3=A9crit :
> Hi Patrice,
> Thanks a lot for your answer and for the tutorial.
> I had used xenomai-2.5.0 and I had modified (ligne 11) one file:=20
> xenomai-2.5.0/src/testsuite/unit/check-vdso.c
> extern unsigned long xeno_sem_heap[2]; --> unsigned long=20
> xeno_sem_heap[2];
>
You may use Xenomai v2.5.2 now. Everything is fixed now. See the other=20
messages of this thread.
> Then, I had no more error to cross-compile Xenomai user-space support.
>
> But, when I run the kernel on the board 1s40, the xenomai didn't=20
> start. I explain:
>
> As motioned in the tutorial=20
> (http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II=
%20Softcore%20Processor%20Guide-v1.1.pdf):=20
>
> The main points to respect are:
> =E2=80=A2 Peripheral name.
> =E2=80=A2 IRQ attributions.
> =E2=80=A2 Memory mapping for each peripheral.
>
> I had respected the Peripheral name and the Memory mapping for each=20
> peripheral. But for IRQ attribution, if I put (as shown on attached=20
> document figure1):
> IRO =3D 1 for hrtimer
> IRQ =3D 2 for hrclock
> IRQ =3D 3 for sys_clk_timer
>
>
> On the board, I got only this message:
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> Uncompressing Linux... Ok, booting the kernel
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> So, the kernel can't boot.
>
> But if I put (as shown on figure2):
> IRO =3D 7 for hrtimer
> IRQ =3D 8 for hrclock
> IRQ =3D 1 for sys_clk_timer
> On the borad, I've got this message:
>
OK. Please, verify first that you can boot =C2=B5Clinux without Xenomai o=
n=20
your board with the 2 extra hrtimer and hrclock peripherals.
There is no priority on IRQ with NIOS.
Please verify that you have correctly enabled all the right options=20
under SOPC builder for hrtimer and hrclock.
Because we have flexibility in HW configuration with SoPC, we must be=20
more careful.

For uCLinux configuration leave, do:
$ cd uClinux_dist
$ make menuconfig
In the menuconfig screens, verify that the following options are enabled:
Vendor/Product Selection --->
--- Select the Vendor you wish to target
Vendor (Altera) --->
--- Select the Product you wish to target
Altera Products (nios2) --->
Kernel/Library/Defaults Selection --->
--- Kernel is linux-2.6.x
Libc Version (None) --->
[*] Default all settings (lose changes)
[ ] Customize Kernel Settings
[ ] Customize Vendor/User Settings
[ ] Update Default Vendor Settings

and follow the doc from page 25 (keep all options by default).

According to errno.h, code -19  is ENODEV, please verify your timer=20
configuration and respect naming convention.

Patrice
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
>
>
> Uncompressing Linux... Ok, booting the kernel.
> Linux version 2.6.30 (root@domain.hid) (gcc version 3.4.6) #40 PREEMPT=20
> Tue Mar 30 10:45:46 CEST 2010
>
>
> uClinux/Nios II
> Built 1 zonelists in Zone order, mobility grouping off. Total pages: 40=
64
> Kernel command line:
> NR_IRQS:32
> PID hash table entries: 64 (order: 6, 256 bytes)
> I-pipe 1.1-00: pipeline enabled.
> Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Memory available: 11772k/4324k RAM, 0k/0k ROM (1932k kernel code,=20
> 2391k data)
> Calibrating delay loop... 24.06 BogoMIPS (lpj=3D120320)
> Mount-cache hash table entries: 512
> net_namespace: 264 bytes
> NET: Registered protocol family 16
> init_BSP(): registering device resources
> bio: create slab <bio-0> at 0
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 512 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 512 bind 512)
> TCP reno registered
> NET: Registered protocol family 1
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/nios2 started.
> Xenomai: system init failed, code -19.
> Xenomai: native skin init failed, code -19.
> Xenomai: starting POSIX services.
> Xenomai: POSIX skin init failed, code -19.
> Xenomai: RTDM skin init failed, code -19.
> io scheduler noop registered
> io scheduler deadline registered (default)
> ttyJ0 at MMIO 0x810820 (irq =3D 4) is a Altera JTAG UART
> console [ttyJ0] enabled
> ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera UART
> ttyS1 at MMIO 0x8108e0 (irq =3D 8) is a Altera UART
> smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@domain.hid>
> eth0: SMC91C11xFD (rev 1) at 80800300 IRQ 7 [nowait]
> eth0: Invalid ethernet MAC address. Please set using ifconfig
> dm9000 Ethernet Driver, V1.31
> TCP cubic registered
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Freeing unused kernel memory: 2076k freed (0x1232000 - 0x1438000)
> Shell invoked to run file: /etc/rc
> Command: hostname uClinux
> Command: mount -t proc proc /proc -o noexec,nosuid,nodev
> Command: mount -t sysfs sysfs /sys -o noexec,nosuid,nodev
> Command: mount -t devpts devpts /dev/pts -o noexec,nosuid
> Command: mount -t usbfs none /proc/bus/usb
> mount: mounting none on /proc/bus/usb failed: No such file or directory
> Command: mkdir /var/tmp
> Command: mkdir /var/log
> Command: mkdir /var/run
> Command: mkdir /var/lock
> Command: mkdir /var/empty
> Command: ifconfig lo 127.0.0.1
> Command: route add -net 127.0.0.0 netmask 255.0.0.0 lo
> Command: cat /etc/motd
> Welcome to
> ____ _ _
> / __| ||_|
> _ _| | | | _ ____ _ _ _ _
> | | | | | | || | _ \| | | |\ \/ /
> | |_| | |__| || | | | | |_| |/ \
> | ___\____|_||_|_| |_|\____|\_/\_/
> | |
> |_|
>
> For further information check:
> http://www.uclinux.org/
>
> Execution Finished, Exiting
>
> Sash command shell (version 1.1.1)
> />
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
>
> So, the xenomai didn't start:
>
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/nios2 started.
> Xenomai: system init failed, code -19.
> Xenomai: native skin init failed, code -19.
> Xenomai: starting POSIX services.
> Xenomai: POSIX skin init failed, code -19.
> Xenomai: RTDM skin init failed, code -19.
>
>
>
> So, I wonder if the number IQR had caused this error.
> What should I do?
>
> RQ: In the configuration of the xenomai, I chose the default parameter:
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
>
> linux-n0mi:/home/sonda/Desktop/nios2-linux/uClinux-dist # make=20
> vendor_hwselect SYSPTF=3D/home/sonda/Desktop/f/standard/std_1s40.ptf
> make ARCH=3Dnios2 -C vendors vendor_hwselect
> make[1]: entrant dans le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors =C2=BB
> make -C=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2/.=20
> dir_v=3D/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nio=
s2/.=20
> -f=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/vendors-common.mak=
 vendor_hwselect=20
>
> make[2]: entrant dans le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2 =C2=BB
> [ -d /home/sonda/Desktop/nios2-linux/uClinux-dist/romfs/$i ] || mkdir=20
> -p /home/sonda/Desktop/nios2-linux/uClinux-dist/romfs
> make ARCH=3Dnios2 CROSS_COMPILE=3Dnios2-linux-uclibc- -C=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/../linux-2.6=20
> O=3D/home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x hwselect
> make[3]: entrant dans le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/linux-2.6 =C2=BB
> no emulation specific options.
> no emulation specific options.
> GEN /home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x/Makefile
> scripts/kconfig/conf -s arch/nios2/Kconfig
> *
> * Restart config...
> *
> *
> * Real-time sub-system
> *
> Xenomai (XENOMAI) [Y/n/?] (NEW) y
> Nucleus (XENO_OPT_NUCLEUS) [Y/n] (NEW) y
> Pervasive real-time support in user-space (XENO_OPT_PERVASIVE) [Y/n/?]=20
> (NEW) y
> Priority coupling support (XENO_OPT_PRIOCPL) [Y/n/?] (NEW) y
> Optimize as pipeline head (XENO_OPT_PIPELINE_HEAD) [Y/n/?] (NEW) y
> Extra scheduling classes (XENO_OPT_SCHED_CLASSES) [N/y/?] (NEW) n
> Number of pipe devices (XENO_OPT_PIPE_NRDEV) [32] (NEW) 32
> Number of registry slots (XENO_OPT_REGISTRY_NRSLOTS) [512] (NEW) 512
> Size of the system heap (Kb) (XENO_OPT_SYS_HEAPSZ) [256] (NEW) 256
> Size of the private stack pool (Kb) (XENO_OPT_SYS_STACKPOOLSZ) [128]=20
> (NEW) 128
> Size of private semaphores heap (Kb) (XENO_OPT_SEM_HEAPSZ) [12] (NEW) 1=
2
> Size of global semaphores heap (Kb) (XENO_OPT_GLOBAL_SEM_HEAPSZ) [12]=20
> (NEW) 12
> Statistics collection (XENO_OPT_STATS) [Y/n/?] (NEW) y
> Debug support (XENO_OPT_DEBUG) [N/y/?] (NEW) n
> Shared interrupts (XENO_OPT_SHIRQ) [N/y/?] (NEW) n
> *
> * Timing
> *
> Enable periodic timing (XENO_OPT_TIMING_PERIODIC) [N/y/?] (NEW) n
> Virtual tick duration in aperiodic mode (us) (XENO_OPT_TIMING_VIRTICK)=20
> [1000] (NEW) 1000
> Scheduling latency (ns) (XENO_OPT_TIMING_SCHEDLAT) [0] (NEW) 0
> *
> * Scalability
> *
> O(1) scheduler (XENO_OPT_SCALABLE_SCHED) [N/y/?] (NEW) n
> Timer indexing method
> > 1. Linear (XENO_OPT_TIMER_LIST) (NEW)
> 2. Tree (XENO_OPT_TIMER_HEAP) (NEW)
> 3. Hash (XENO_OPT_TIMER_WHEEL) (NEW)
> choice[1-3?]: 1
> *
> * Native API
> *
> Native API (XENO_SKIN_NATIVE) [Y/n/?] (NEW) y
> Message pipes (XENO_OPT_NATIVE_PIPE) [Y/n/?] (NEW) y
> Bytes in buffer space (XENO_OPT_NATIVE_PIPE_BUFSZ) [1024] (NEW) 1024
> Counting semaphores (XENO_OPT_NATIVE_SEM) [Y/n/?] (NEW) y
> Event flags (XENO_OPT_NATIVE_EVENT) [Y/n/?] (NEW) y
> Mutexes (XENO_OPT_NATIVE_MUTEX) [Y/n/?] (NEW) y
> Condition variables (XENO_OPT_NATIVE_COND) [Y/n/?] (NEW) y
> Message queues (XENO_OPT_NATIVE_QUEUE) [Y/n/?] (NEW) y
> Buffers (XENO_OPT_NATIVE_BUFFER) [Y/n/?] (NEW) y
> Memory heaps (XENO_OPT_NATIVE_HEAP) [Y/n/?] (NEW) y
> Alarms (XENO_OPT_NATIVE_ALARM) [Y/n/?] (NEW) y
> Message passing support (XENO_OPT_NATIVE_MPS) [Y/n/?] (NEW) y
> Interrupts (XENO_OPT_NATIVE_INTR) [N/y/?] (NEW) n
> *
> * POSIX API
> *
> POSIX API (XENO_SKIN_POSIX) [Y/n/?] (NEW) y
> Shared memory (XENO_OPT_POSIX_SHM) [N/y/?] (NEW) n
> Interrupts (XENO_OPT_POSIX_INTR) [N/y/?] (NEW) n
> Select syscall (XENO_OPT_POSIX_SELECT) [N/y/?] (NEW) n
> Debugging support (XENO_OPT_DEBUG_POSIX) [N/y/?] (NEW) n
> *
> * pSOS+ emulator
> *
> pSOS+ emulator (XENO_SKIN_PSOS) [N/y/?] (NEW) n
> *
> * uITRON API
> *
> uITRON API (XENO_SKIN_UITRON) [N/y/?] (NEW) n
> *
> * VRTX emulator
> *
> VRTX emulator (XENO_SKIN_VRTX) [N/y/?] (NEW) n
> *
> * VxWorks emulator
> *
> VxWorks emulator (XENO_SKIN_VXWORKS) [N/y/?] (NEW) n
> *
> * RTAI emulator
> *
> RTAI emulator (XENO_SKIN_RTAI) [N/y/?] (NEW) n
> *
> * Interfaces
> *
> Do not warn about deprecated skin usage (XENO_OPT_NOWARN_DEPRECATED)=20
> [N/y/?] (NEW) n
> *
> * Real-Time Driver Model
> *
> Real-Time Driver Model (XENO_SKIN_RTDM) [Y/n/?] (NEW) y
> Maximum number of RTDM file descriptors (XENO_OPT_RTDM_FILDES) [128]=20
> (NEW) 128
> Select support for RTDM file descriptors (XENO_OPT_RTDM_SELECT)=20
> [N/y/?] (NEW) n
> *
> * Serial drivers
> *
> 16550A UART driver (XENO_DRIVERS_16550A) [N/y/?] (NEW) n
> *
> * Testing drivers
> *
> Timer benchmark driver (XENO_DRIVERS_TIMERBENCH) [Y/n/?] (NEW) y
> IRQ benchmark driver (XENO_DRIVERS_IRQBENCH) [N/y/?] (NEW) n
> Context switch unit testing driver (XENO_DRIVERS_SWITCHTEST) [Y/n/?]=20
> (NEW) y
> *
> * CAN drivers
> *
> RT-Socket-CAN, CAN raw socket interface (XENO_DRIVERS_CAN) [N/y/?]=20
> (NEW) n
> *
> * ANALOGY drivers
> *
> ANALOGY interface (XENO_DRIVERS_ANALOGY) [N/y/?] (NEW) n
> *
> * Real-time IPC drivers
> *
> RTIPC protocol family (XENO_DRIVERS_RTIPC) [N/y/?] (NEW) n
> *
> * Processor type and features
> *
> *
> * Platform dependant setup
> *
> CPU
> > 1. NIOS2 (NIOS2)
> choice[1]: 1
> MMU support (MMU) [N/y/?] n
> Platform
> 1. Microtronix uKit board support (MICROTRONIX_UKIT)
> 2. Microtronix Stratix board support (MICROTRONIX_STRATIX)
> 3. Microtronix Cyclone board support (MICROTRONIX_CYCLONE)
> 4. Microtronix PSK (Product Starter Kit) support (MICROTRONIX_PSK)
> 5. Altera Stratix Development board support (ALTERA_STRATIX)
> 6. Altera Stratix Pro Development board support (ALTERA_STRATIX_PRO)
> 7. Altera Stratix II Development board support (ALTERA_STRATIX_II)
> 8. Altera Cyclone Development board support (ALTERA_CYCLONE)
> 9. Altera CYCLONE II Development board support (ALTERA_CYCLONE_II)
> 10. Altera Cyclone 1C12 Evaluation board support=20
> (ALTERA_CYCLONE_1C12_EVAL)
> > 11. Altera DE2 Development board support (ALTERA_DE2)
> 12. Altera Nios II Embedded Evaluation Kit support (ALTERA_NEEK_C3)
> 13. Altera CYCLONE III 3C120 Development board support=20
> (ALTERA_CYCLONE_III)
> choice[1-13]: 11
> Nios II Hardware Multiply Support
> 1. None (NIOS2_HW_MUL_OFF)
> > 2. Enable mul instruction (NIOS2_HW_MUL)
> 3. Enable mul and mulx instructions (NIOS2_HW_MULX)
> choice[1-3?]: 2
> *
> * Platform drivers Options
> *
> GPIO interface (GENERIC_GPIO) [N/y/?] n
> Support of DMA controller with Avalon interface (AVALON_DMA) [N/y/?] n
> Altera PCI host bridge (PCI_ALTPCI) [N/y] n
> Remote update support (ALTERA_REMOTE_UPDATE) [N/y/?] n
> *
> * Miscellaneous Options
> *
> Include breakpoint trap on kernel startup (BREAK_ON_START) [N/y/?] n
> Kernel executes from
> > 1. RAM (RAMKERNEL)
> choice[1]: 1
> Preemption Model
> 1. No Forced Preemption (Server) (PREEMPT_NONE)
> 2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)
> > 3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT)
> choice[1-3]: 3
> Timer frequency
> > 1. 100 HZ (HZ_100)
> 2. 250 HZ (HZ_250)
> 3. 300 HZ (HZ_300)
> 4. 1000 HZ (HZ_1000)
> choice[1-4?]: 1
> Default kernel command string (CMDLINE) []
> Passed kernel command line from u-boot (PASS_CMDLINE) [N/y/?] n
> Interrupt pipeline (IPIPE) [Y/?] (NEW) y
> Max domains (IPIPE_DOMAINS) [4] (NEW) 4
> Maintain code compatibility with older releases (IPIPE_COMPAT) [Y/n/?]=20
> (NEW) y
> Memory model
> > 1. Flat Memory (FLATMEM_MANUAL)
> choice[1]: 1
> Add LRU list to track non-evictable pages (UNEVICTABLE_LRU) [Y/n/?] y
> Turn on mmap() excess space trimming before booting=20
> (NOMMU_INITIAL_TRIM_EXCESS) [1] 1
> Link address offset for booting (BOOT_LINK_OFFSET) [0x00500000]=20
> 0x00500000
> *
> * Kernel hacking
> *
> Show timing information on printks (PRINTK_TIME) [N/y/?] n
> Enable __deprecated logic (ENABLE_WARN_DEPRECATED) [Y/n/?] y
> Enable __must_check logic (ENABLE_MUST_CHECK) [N/y/?] n
> Warn for stack frames larger than (needs gcc 4.4) (FRAME_WARN) [1024]=20
> 1024
> Magic SysRq key (MAGIC_SYSRQ) [N/y/?] n
> Enable unused/obsolete exported symbols (UNUSED_SYMBOLS) [N/y/?] n
> Debug Filesystem (DEBUG_FS) [N/y/?] n
> Run 'make headers_check' when building vmlinux (HEADERS_CHECK) [N/y/?] =
n
> I-pipe debugging (IPIPE_DEBUG) [N/y] (NEW) n
> Kernel debugging (DEBUG_KERNEL) [Y/n/?] y
> Debug shared IRQ handlers (DEBUG_SHIRQ) [N/y/?] n
> Detect Soft Lockups (DETECT_SOFTLOCKUP) [Y/n/?] y
> Panic (Reboot) On Soft Lockups (BOOTPARAM_SOFTLOCKUP_PANIC) [N/y/?] n
> Detect Hung Tasks (DETECT_HUNG_TASK) [Y/n/?] y
> Panic (Reboot) On Hung Tasks (BOOTPARAM_HUNG_TASK_PANIC) [N/y/?] n
> Collect scheduler debugging info (SCHED_DEBUG) [Y/n/?] y
> Collect scheduler statistics (SCHEDSTATS) [N/y/?] n
> Collect kernel timers statistics (TIMER_STATS) [N/y/?] n
> Debug object operations (DEBUG_OBJECTS) [N/y/?] n
> Debug slab memory allocations (DEBUG_SLAB) [N/y/?] n
> RT Mutex debugging, deadlock detection (DEBUG_RT_MUTEXES) [N/y/?] n
> Built-in scriptable tester for rt-mutexes (RT_MUTEX_TESTER) [N/y/?] n
> Spinlock and rw-lock debugging: basic checks (DEBUG_SPINLOCK) [N/y/?] n
> Mutex debugging: basic checks (DEBUG_MUTEXES) [N/y/?] n
> Spinlock debugging: sleep-inside-spinlock checking=20
> (DEBUG_SPINLOCK_SLEEP) [N/y/?] n
> Locking API boot-time self-tests (DEBUG_LOCKING_API_SELFTESTS) [N/y/?] =
n
> kobject debugging (DEBUG_KOBJECT) [N/y/?] n
> Compile the kernel with debug info (DEBUG_INFO) [Y/n/?] y
> Debug VM (DEBUG_VM) [N/y/?] n
> Debug the global anon/private NOMMU mapping region tree=20
> (DEBUG_NOMMU_REGIONS) [N/y/?] n
> Debug filesystem writers count (DEBUG_WRITECOUNT) [N/y/?] n
> Debug memory initialisation (DEBUG_MEMORY_INIT) [N/y/?] n
> Debug linked list manipulation (DEBUG_LIST) [N/y/?] n
> Debug SG table operations (DEBUG_SG) [N/y/?] n
> Debug notifier call chains (DEBUG_NOTIFIERS) [N/y/?] n
> Delay each boot printk message by N milliseconds (BOOT_PRINTK_DELAY)=20
> [N/y/?] n
> torture tests for RCU (RCU_TORTURE_TEST) [N/y/?] n
> Check for stalled CPUs delaying RCU grace periods=20
> (RCU_CPU_STALL_DETECTOR) [N/y/?] n
> Self test for the backtrace code (BACKTRACE_SELF_TEST) [N/y/?] n
> Force extended block device numbers and spread them=20
> (DEBUG_BLOCK_EXT_DEVT) [N/y/?] n
> Fault-injection framework (FAULT_INJECTION) [N/y/?] n
> Debug page memory allocations (PAGE_POISONING) [N/y/?] n
> #
> # configuration written to .config
> #
> no emulation specific options.
> RUNNING hwselect
>
> --- Please select which CPU you wish to build the kernel against:
>
> (1) cpu - Class: altera_nios2 Type: s Version: 7.080910
>
> Selection: 1
>
> --- Please select a device to execute kernel from:
>
> (1) ext_flash
> Class: altera_avalon_cfi_flash
> Size: 8388608 bytes
>
> (2) onchip_ram_64_kbytes
> Class: altera_avalon_onchip_memory2
> Size: 65536 bytes
>
> (3) ext_ram
> Class: altera_nios_dev_kit_stratix_edition_sram2
> Size: 1048576 bytes
>
> (4) sdram
> Class: altera_avalon_new_sdram_controller
> Size: 16777216 bytes
>
> Selection: 4
>
> --- Summary using
>
> PTF: /home/sonda/Desktop/f/standard/std_1s40.ptf
> CPU: cpu
> Program memory to execute from: sdram
>
> --- Settings written to=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x/arch/nios2/har=
dware.mk=20
>
>
> make[3]: quittant le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/linux-2.6 =C2=BB
> make[2]: quittant le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2 =C2=BB
> make[1]: quittant le r=C3=A9pertoire =C2=AB=20
> /home/sonda/Desktop/nios2-linux/uClinux-dist/vendors =C2=BB
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
> -----------------------------------------------------------------------=
-----------------------------------------------------------------------=20
>
>
> Regards,
>
> --- En date de : *Dim 28.3.10, Patrice Kadionik=20
> /<kadionik@domain.hid>/* a =C3=A9crit :
>
>
>     De: Patrice Kadionik <kadionik@domain.hid>
>     Objet: Re: [Xenomai-help] Problem to cross-compile Xenomai
>     user-space support
>     =C3=80: "Chtourou Sonda" <chtourou_sonda@domain.hid>
>     Cc: xenomai@xenomai.org
>     Date: Dimanche 28 mars 2010, 13h26
>
>     Le 20:59, Chtourou Sonda a =C3=A9crit :
>>
>>     Dears,
>>
>     Hi,
>
>>
>>     I built the uClinux kernel for NIOS II and it run well on the
>>     target board. I followed the typical actions available here :
>>     http://www.nioswiki.com/
>>
>>     Now, I want to add a co-scheduler xenomai to the kernel (uclinux)
>>     to reduce its latency. I followed these steps:
>>     (http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL)
>>
>     I've tried to reproduce your compilation error but without success.
>
>     For using Xenomai on NIOS II processor with uClinux, you must add
>     extra hardware in your SoPC design as explained in this tutorial
>     (http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%=
20II%20Softcore%20Processor%20Guide-v1.1.pdf).
>
>     It is OK on my Altera 1S10 board  with Xenomai v2.5.1 (see traces).
>
>     Sincerely;
>
>     Patrice
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     Uncompressing Linux... Ok, booting the kernel.
>     Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4
>     PREEMPT Sun Mar 0
>
>
>     uClinux/Nios II
>     Built 1 zonelists in Zone order, mobility grouping off.  Total
>     pages: 4064
>     Kernel command line:
>     NR_IRQS:32
>     PID hash table entries: 64 (order: 6, 256 bytes)
>     I-pipe 1.1-00: pipeline enabled.
>     Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
>     Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
>     Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code,
>     2059k data)
>     Calibrating delay loop... 24.06 BogoMIPS (lpj=3D120320)
>     Mount-cache hash table entries: 512
>     net_namespace: 264 bytes
>     NET: Registered protocol family 16
>     init_BSP(): registering device resources
>     bio: create slab <bio-0> at 0
>     NET: Registered protocol family 2
>     IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>     TCP established hash table entries: 512 (order: 0, 4096 bytes)
>     TCP bind hash table entries: 512 (order: -1, 2048 bytes)
>     TCP: Hash tables configured (established 512 bind 512)
>     TCP reno registered
>     NET: Registered protocol family 1
>     I-pipe: Domain Xenomai registered.
>     Xenomai: hal/nios2 started.
>     Xenomai: scheduling class idle registered.
>     Xenomai: scheduling class rt registered.
>     Xenomai: real-time nucleus v2.5.1 (Speed Of Light) loaded.
>     Xenomai: starting native API services.
>     Xenomai: starting POSIX services.
>     Xenomai: starting RTDM services.
>     io scheduler noop registered
>     io scheduler deadline registered (default)
>     ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera UART
>     console [ttyS0] enabled
>
>
>
>
>>     $ $xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2
>>     --adeos=3D$xenomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.3=
0-nios2-1.1-00.patch
>>       --linux=3D$linux_tree
>>     $ $xenomai-2.5.1/configure --host=3Dnios2-linux
>>     $ make install DESTDIR=3D$uClinux-dist/romfs
>>
>>     But, in this step, I got this error:
>>
>>     eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -l=
m
>>     libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc
>>     -Wl,-elf2flt -o check-vdso check_vdso-check-vdso.o=20
>>     ../../skins/native/.libs/libnative.a -lpthread -lm
>>     check-vdso.elf2flt(.text+0x16c): In function `main':
>>     : undefined reference to `xeno_sem_heap'
>>     check-vdso.elf2flt(.text+0x170): In function `main':
>>     : undefined reference to `xeno_sem_heap'
>>     collect2: ld returned 1 exit status
>>     make[3]: *** [check-vdso] Erreur 1
>>     make[3]: quittant le r=C3=A9pertoire =C2=AB
>>     /home/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit =C2=BB
>>     make[2]: *** [all-recursive] Erreur 1
>>     make[2]: quittant le r=C3=A9pertoire =C2=AB
>>     /home/sonda/Desktop/xenomai-2.5.1/src/testsuite =C2=BB
>>     make[1]: *** [all-recursive] Erreur 1
>>     make[1]: quittant le r=C3=A9pertoire =C2=AB
>>     /home/sonda/Desktop/xenomai-2.5.1/src =C2=BB
>>     make: *** [all-recursive] Erreur 1
>>
>>     what can I do? Please help
>>
>>     Regards,
>>
>>
>>
>>     _______________________________________________
>>     Xenomai-help mailing list
>>     Xenomai-help@domain.hid
>>     https://mail.gna.org/listinfo/xenomai-help
>>       =20
>
>
>     --=20
>     Patrice Kadionik. F6KQH / F4CUQ
>     -----------
>
>     +------------------------------------------------------------------=
----+
>     +"Tout doit etre aussi simple que possible, pas seulement plus simp=
le" +
>     +------------------------------------------------------------------=
----+
>     + Patrice Kadionikhttp://www.enseirb-matmeca.fr/~kadionik  +
>     + IMS Laboratoryhttp://www.ims-bordeaux.fr/              +
>     + ENSEIRB-MATMECAhttp://www.enseirb-matmeca.fr            +
>     + PO BOX 99                    fax   : +33 5.56.37.20.23           =
    +
>     + 33402 TALENCE Cedex
>              voice : +33 5.56.84.23.47               +
>     + FRANCEmailto:patrice.kadionik@domain.hid  +
>     +------------------------------------------------------------------=
----+
>               =20
>
>


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+


--------------020008040409050001080703
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by plan.enseirb.fr id o2UGiWIs002997

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Le 30/03/2010 17:40, Chtourou Sonda a =C3=A9crit=C2=A0:
<blockquote cite=3D"mid:162274.76484.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">Hi Patrice,=C2=A0
        <br>
Thanks a lot for your answer and for the tutorial.
        <br>
I had used xenomai-2.5.0 and I had modified (ligne 11) one file:
xenomai-2.5.0/src/testsuite/unit/check-vdso.c
        <br>
extern unsigned long xeno_sem_heap[2]; --&gt; unsigned long
xeno_sem_heap[2];
        <br>
        </td>
      </tr>
    </tbody>
  </table>
</blockquote>
You may use Xenomai v2.5.2 now. Everything is fixed now. See the other
messages of this thread.<br>
<blockquote cite=3D"mid:162274.76484.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">Then, I had no more error to cross-compile Xenomai
user-space support.
        <br>
=C2=A0<br>
But, when I run the kernel on the board 1s40, the xenomai didn't start.
I explain:
        <br>
=C2=A0<br>
As motioned in the tutorial
(<a class=3D"moz-txt-link-freetext" href=3D"http://uuu.enseirb.fr/~kadion=
ik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20Processor%20Guide-=
v1.1.pdf">http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NI=
OS%20II%20Softcore%20Processor%20Guide-v1.1.pdf</a>):=C2=A0
        <br>
The main points to respect are:
        <br>
=E2=80=A2 Peripheral name.
        <br>
=E2=80=A2 IRQ attributions.
        <br>
=E2=80=A2 Memory mapping for each peripheral.
        <br>
=C2=A0<br>
I had respected the Peripheral name and the Memory mapping for
each peripheral. But for IRQ attribution, if I put (as shown on
attached document figure1):
        <br>
IRO =3D 1 for hrtimer=C2=A0
        <br>
IRQ =3D 2 for hrclock
        <br>
IRQ =3D 3 for sys_clk_timer
        <br>
=C2=A0<br>
=C2=A0<br>
On the board, I got only this message:
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
Uncompressing Linux... Ok, booting the kernel
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
So, the kernel can't boot.
        <br>
=C2=A0<br>
But if I put (as shown on figure2):
        <br>
IRO =3D 7 for hrtimer=C2=A0
        <br>
IRQ =3D 8 for hrclock
        <br>
IRQ =3D 1 for sys_clk_timer
        <br>
On the borad, I've got this message:
        <br>
        </td>
      </tr>
    </tbody>
  </table>
</blockquote>
OK. Please, verify first that you can boot =C2=B5Clinux without Xenomai o=
n
your board with the 2 extra hrtimer and hrclock peripherals.<br>
There is no priority on IRQ with NIOS.<br>
Please verify that you have correctly enabled all the right options
under SOPC builder for hrtimer and hrclock.<br>
Because we have flexibility in HW configuration with SoPC, we must be
more careful.<br>
<br>
For uCLinux configuration leave, do:<br>
$ cd uClinux_dist<br>
$ make menuconfig<br>
In the menuconfig screens, verify that the following options are
enabled:<br>
Vendor/Product Selection ---&gt;<br>
--- Select the Vendor you wish to target<br>
Vendor (Altera) ---&gt;<br>
--- Select the Product you wish to target<br>
Altera Products (nios2) ---&gt;<br>
Kernel/Library/Defaults Selection ---&gt;<br>
--- Kernel is linux-2.6.x<br>
Libc Version (None) ---&gt;<br>
[*] Default all settings (lose changes)<br>
[ ] Customize Kernel Settings<br>
[ ] Customize Vendor/User Settings<br>
[ ] Update Default Vendor Settings<br>
<br>
and follow the doc from page 25 (keep all options by default).<br>
<br>
According to errno.h, code -19=C2=A0 is ENODEV, please verify your timer
configuration and respect naming convention.<br>
<br>
Patrice<br>
<blockquote cite=3D"mid:162274.76484.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">=C2=A0<br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
=C2=A0<br>
=C2=A0<br>
Uncompressing Linux... Ok, booting the kernel.
        <br>
Linux version 2.6.30 (root@domain.hid) (gcc version 3.4.6) #40 PREEMPT
Tue Mar 30 10:45:46 CEST 2010
        <br>
=C2=A0<br>
=C2=A0<br>
uClinux/Nios II
        <br>
Built 1 zonelists in Zone order, mobility grouping off. Total pages:
4064
        <br>
Kernel command line:=C2=A0
        <br>
NR_IRQS:32=C2=A0
        <br>
PID hash table entries: 64 (order: 6, 256 bytes)=C2=A0
        <br>
I-pipe 1.1-00: pipeline enabled.=C2=A0
        <br>
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)=C2=A0
        <br>
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)=C2=A0
        <br>
Memory available: 11772k/4324k RAM, 0k/0k ROM (1932k kernel code, 2391k
data)
        <br>
Calibrating delay loop... 24.06 BogoMIPS (lpj=3D120320)=C2=A0
        <br>
Mount-cache hash table entries: 512=C2=A0
        <br>
net_namespace: 264 bytes=C2=A0
        <br>
NET: Registered protocol family 16=C2=A0
        <br>
init_BSP(): registering device resources=C2=A0
        <br>
bio: create slab &lt;bio-0&gt; at 0=C2=A0
        <br>
NET: Registered protocol family 2=C2=A0
        <br>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)=C2=A0
        <br>
TCP established hash table entries: 512 (order: 0, 4096 bytes)=C2=A0
        <br>
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
        <br>
TCP: Hash tables configured (established 512 bind 512)
        <br>
TCP reno registered
        <br>
NET: Registered protocol family 1
        <br>
I-pipe: Domain Xenomai registered.
        <br>
Xenomai: hal/nios2 started.
        <br>
Xenomai: system init failed, code -19.
        <br>
Xenomai: native skin init failed, code -19.
        <br>
Xenomai: starting POSIX services.
        <br>
Xenomai: POSIX skin init failed, code -19.
        <br>
Xenomai: RTDM skin init failed, code -19.
        <br>
io scheduler noop registered
        <br>
io scheduler deadline registered (default)
        <br>
ttyJ0 at MMIO 0x810820 (irq =3D 4) is a Altera JTAG UART
        <br>
console [ttyJ0] enabled
        <br>
ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera UART
        <br>
ttyS1 at MMIO 0x8108e0 (irq =3D 8) is a Altera UART
        <br>
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <a class=3D"moz-txt-link-rfc=
2396E" href=3D"mailto:nico@domain.hid">&lt;nico@domain.hid&gt;</a>
        <br>
eth0: SMC91C11xFD (rev 1) at 80800300 IRQ 7 [nowait]
        <br>
eth0: Invalid ethernet MAC address. Please set using ifconfig
        <br>
dm9000 Ethernet Driver, V1.31
        <br>
TCP cubic registered
        <br>
NET: Registered protocol family 17
        <br>
RPC: Registered udp transport module.
        <br>
RPC: Registered tcp transport module.
        <br>
Freeing unused kernel memory: 2076k freed (0x1232000 - 0x1438000)
        <br>
Shell invoked to run file: /etc/rc=C2=A0
        <br>
Command: hostname uClinux=C2=A0
        <br>
Command: mount -t proc proc /proc -o noexec,nosuid,nodev=C2=A0
        <br>
Command: mount -t sysfs sysfs /sys -o noexec,nosuid,nodev=C2=A0
        <br>
Command: mount -t devpts devpts /dev/pts -o noexec,nosuid=C2=A0
        <br>
Command: mount -t usbfs none /proc/bus/usb
        <br>
mount: mounting none on /proc/bus/usb failed: No such file or directory
        <br>
Command: mkdir /var/tmp
        <br>
Command: mkdir /var/log
        <br>
Command: mkdir /var/run
        <br>
Command: mkdir /var/lock
        <br>
Command: mkdir /var/empty
        <br>
Command: ifconfig lo 127.0.0.1
        <br>
Command: route add -net 127.0.0.0 netmask 255.0.0.0 lo
        <br>
Command: cat /etc/motd
        <br>
Welcome to
        <br>
____ _ _
        <br>
/ __| ||_|
        <br>
_ _| | | | _ ____ _ _ _ _
        <br>
| | | | | | || | _ \| | | |\ \/ /
        <br>
| |_| | |__| || | | | | |_| |/ \
        <br>
| ___\____|_||_|_| |_|\____|\_/\_/
        <br>
| |
        <br>
|_|
        <br>
=C2=A0<br>
For further information check:
        <br>
<a class=3D"moz-txt-link-freetext" href=3D"http://www.uclinux.org/">http:=
//www.uclinux.org/</a>
        <br>
=C2=A0<br>
Execution Finished, Exiting
        <br>
=C2=A0<br>
Sash command shell (version 1.1.1)
        <br>
/&gt;
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
=C2=A0<br>
So, the xenomai didn't start:
        <br>
=C2=A0<br>
I-pipe: Domain Xenomai registered.
        <br>
Xenomai: hal/nios2 started.
        <br>
Xenomai: system init failed, code -19.
        <br>
Xenomai: native skin init failed, code -19.
        <br>
Xenomai: starting POSIX services.
        <br>
Xenomai: POSIX skin init failed, code -19.
        <br>
Xenomai: RTDM skin init failed, code -19.
        <br>
=C2=A0<br>
=C2=A0<br>
=C2=A0<br>
So, I wonder if the number IQR had caused this error.
        <br>
What should I do?=C2=A0
        <br>
=C2=A0<br>
RQ: In the configuration of the xenomai, I chose the default parameter:
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
=C2=A0<br>
linux-n0mi:/home/sonda/Desktop/nios2-linux/uClinux-dist #
make vendor_hwselect
SYSPTF=3D/home/sonda/Desktop/f/standard/std_1s40.ptf=C2=A0
        <br>
make ARCH=3Dnios2 -C vendors vendor_hwselect=C2=A0
        <br>
make[1]: entrant dans le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors =C2=BB=C2=A0
        <br>
make -C
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2/.
dir_v=3D/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2=
/.
-f
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/vendors-common.mak
vendor_hwselect=C2=A0
        <br>
make[2]: entrant dans le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2 =C2=BB=C2=
=A0
        <br>
[ -d /home/sonda/Desktop/nios2-linux/uClinux-dist/romfs/$i ] || mkdir
-p /home/sonda/Desktop/nios2-linux/uClinux-dist/romfs=C2=A0
        <br>
make ARCH=3Dnios2 CROSS_COMPILE=3Dnios2-linux-uclibc- -C
/home/sonda/Desktop/nios2-linux/uClinux-dist/../linux-2.6
O=3D/home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x hwselect=C2=A0
        <br>
make[3]: entrant dans le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/linux-2.6 =C2=BB=C2=A0
        <br>
no emulation specific options.=C2=A0
        <br>
no emulation specific options.=C2=A0
        <br>
GEN /home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x/Makefile=C2=A0
        <br>
scripts/kconfig/conf -s arch/nios2/Kconfig=C2=A0
        <br>
*=C2=A0
        <br>
* Restart config...=C2=A0
        <br>
*=C2=A0
        <br>
*=C2=A0
        <br>
* Real-time sub-system=C2=A0
        <br>
*=C2=A0
        <br>
Xenomai (XENOMAI) [Y/n/?] (NEW) y=C2=A0
        <br>
Nucleus (XENO_OPT_NUCLEUS) [Y/n] (NEW) y=C2=A0
        <br>
Pervasive real-time support in user-space (XENO_OPT_PERVASIVE) [Y/n/?]
(NEW) y=C2=A0
        <br>
Priority coupling support (XENO_OPT_PRIOCPL) [Y/n/?] (NEW) y=C2=A0
        <br>
Optimize as pipeline head (XENO_OPT_PIPELINE_HEAD) [Y/n/?] (NEW) y=C2=A0
        <br>
Extra scheduling classes (XENO_OPT_SCHED_CLASSES) [N/y/?] (NEW) n=C2=A0
        <br>
Number of pipe devices (XENO_OPT_PIPE_NRDEV) [32] (NEW) 32=C2=A0
        <br>
Number of registry slots (XENO_OPT_REGISTRY_NRSLOTS) [512] (NEW) 512=C2=A0
        <br>
Size of the system heap (Kb) (XENO_OPT_SYS_HEAPSZ) [256] (NEW) 256=C2=A0
        <br>
Size of the private stack pool (Kb) (XENO_OPT_SYS_STACKPOOLSZ) [128]
(NEW) 128=C2=A0
        <br>
Size of private semaphores heap (Kb) (XENO_OPT_SEM_HEAPSZ) [12] (NEW)
12=C2=A0
        <br>
Size of global semaphores heap (Kb) (XENO_OPT_GLOBAL_SEM_HEAPSZ) [12]
(NEW) 12=C2=A0
        <br>
Statistics collection (XENO_OPT_STATS) [Y/n/?] (NEW) y=C2=A0
        <br>
Debug support (XENO_OPT_DEBUG) [N/y/?] (NEW) n=C2=A0
        <br>
Shared interrupts (XENO_OPT_SHIRQ) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Timing=C2=A0
        <br>
*=C2=A0
        <br>
Enable periodic timing (XENO_OPT_TIMING_PERIODIC) [N/y/?] (NEW) n=C2=A0
        <br>
Virtual tick duration in aperiodic mode (us) (XENO_OPT_TIMING_VIRTICK)
[1000] (NEW) 1000=C2=A0
        <br>
Scheduling latency (ns) (XENO_OPT_TIMING_SCHEDLAT) [0] (NEW) 0=C2=A0
        <br>
*=C2=A0
        <br>
* Scalability=C2=A0
        <br>
*=C2=A0
        <br>
O(1) scheduler (XENO_OPT_SCALABLE_SCHED) [N/y/?] (NEW) n=C2=A0
        <br>
Timer indexing method=C2=A0
        <br>
&gt; 1. Linear (XENO_OPT_TIMER_LIST) (NEW)=C2=A0
        <br>
2. Tree (XENO_OPT_TIMER_HEAP) (NEW)=C2=A0
        <br>
3. Hash (XENO_OPT_TIMER_WHEEL) (NEW)=C2=A0
        <br>
choice[1-3?]: 1=C2=A0
        <br>
*=C2=A0
        <br>
* Native API=C2=A0
        <br>
*=C2=A0
        <br>
Native API (XENO_SKIN_NATIVE) [Y/n/?] (NEW) y=C2=A0
        <br>
Message pipes (XENO_OPT_NATIVE_PIPE) [Y/n/?] (NEW) y=C2=A0
        <br>
Bytes in buffer space (XENO_OPT_NATIVE_PIPE_BUFSZ) [1024] (NEW) 1024=C2=A0
        <br>
Counting semaphores (XENO_OPT_NATIVE_SEM) [Y/n/?] (NEW) y=C2=A0
        <br>
Event flags (XENO_OPT_NATIVE_EVENT) [Y/n/?] (NEW) y=C2=A0
        <br>
Mutexes (XENO_OPT_NATIVE_MUTEX) [Y/n/?] (NEW) y=C2=A0
        <br>
Condition variables (XENO_OPT_NATIVE_COND) [Y/n/?] (NEW) y=C2=A0
        <br>
Message queues (XENO_OPT_NATIVE_QUEUE) [Y/n/?] (NEW) y=C2=A0
        <br>
Buffers (XENO_OPT_NATIVE_BUFFER) [Y/n/?] (NEW) y=C2=A0
        <br>
Memory heaps (XENO_OPT_NATIVE_HEAP) [Y/n/?] (NEW) y=C2=A0
        <br>
Alarms (XENO_OPT_NATIVE_ALARM) [Y/n/?] (NEW) y=C2=A0
        <br>
Message passing support (XENO_OPT_NATIVE_MPS) [Y/n/?] (NEW) y=C2=A0
        <br>
Interrupts (XENO_OPT_NATIVE_INTR) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* POSIX API=C2=A0
        <br>
*=C2=A0
        <br>
POSIX API (XENO_SKIN_POSIX) [Y/n/?] (NEW) y=C2=A0
        <br>
Shared memory (XENO_OPT_POSIX_SHM) [N/y/?] (NEW) n=C2=A0
        <br>
Interrupts (XENO_OPT_POSIX_INTR) [N/y/?] (NEW) n=C2=A0
        <br>
Select syscall (XENO_OPT_POSIX_SELECT) [N/y/?] (NEW) n=C2=A0
        <br>
Debugging support (XENO_OPT_DEBUG_POSIX) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* pSOS+ emulator=C2=A0
        <br>
*=C2=A0
        <br>
pSOS+ emulator (XENO_SKIN_PSOS) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* uITRON API=C2=A0
        <br>
*=C2=A0
        <br>
uITRON API (XENO_SKIN_UITRON) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* VRTX emulator=C2=A0
        <br>
*=C2=A0
        <br>
VRTX emulator (XENO_SKIN_VRTX) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* VxWorks emulator=C2=A0
        <br>
*=C2=A0
        <br>
VxWorks emulator (XENO_SKIN_VXWORKS) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* RTAI emulator=C2=A0
        <br>
*=C2=A0
        <br>
RTAI emulator (XENO_SKIN_RTAI) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Interfaces=C2=A0
        <br>
*=C2=A0
        <br>
Do not warn about deprecated skin usage (XENO_OPT_NOWARN_DEPRECATED)
[N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Real-Time Driver Model=C2=A0
        <br>
*=C2=A0
        <br>
Real-Time Driver Model (XENO_SKIN_RTDM) [Y/n/?] (NEW) y=C2=A0
        <br>
Maximum number of RTDM file descriptors (XENO_OPT_RTDM_FILDES) [128]
(NEW) 128=C2=A0
        <br>
Select support for RTDM file descriptors (XENO_OPT_RTDM_SELECT) [N/y/?]
(NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Serial drivers=C2=A0
        <br>
*=C2=A0
        <br>
16550A UART driver (XENO_DRIVERS_16550A) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Testing drivers=C2=A0
        <br>
*=C2=A0
        <br>
Timer benchmark driver (XENO_DRIVERS_TIMERBENCH) [Y/n/?] (NEW) y=C2=A0
        <br>
IRQ benchmark driver (XENO_DRIVERS_IRQBENCH) [N/y/?] (NEW) n=C2=A0
        <br>
Context switch unit testing driver (XENO_DRIVERS_SWITCHTEST) [Y/n/?]
(NEW) y=C2=A0
        <br>
*=C2=A0
        <br>
* CAN drivers=C2=A0
        <br>
*=C2=A0
        <br>
RT-Socket-CAN, CAN raw socket interface (XENO_DRIVERS_CAN) [N/y/?]
(NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* ANALOGY drivers=C2=A0
        <br>
*=C2=A0
        <br>
ANALOGY interface (XENO_DRIVERS_ANALOGY) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Real-time IPC drivers=C2=A0
        <br>
*=C2=A0
        <br>
RTIPC protocol family (XENO_DRIVERS_RTIPC) [N/y/?] (NEW) n=C2=A0
        <br>
*=C2=A0
        <br>
* Processor type and features=C2=A0
        <br>
*=C2=A0
        <br>
*=C2=A0
        <br>
* Platform dependant setup=C2=A0
        <br>
*=C2=A0
        <br>
CPU=C2=A0
        <br>
&gt; 1. NIOS2 (NIOS2)=C2=A0
        <br>
choice[1]: 1=C2=A0
        <br>
MMU support (MMU) [N/y/?] n=C2=A0
        <br>
Platform=C2=A0
        <br>
1. Microtronix uKit board support (MICROTRONIX_UKIT)=C2=A0
        <br>
2. Microtronix Stratix board support (MICROTRONIX_STRATIX)=C2=A0
        <br>
3. Microtronix Cyclone board support (MICROTRONIX_CYCLONE)=C2=A0
        <br>
4. Microtronix PSK (Product Starter Kit) support (MICROTRONIX_PSK)=C2=A0
        <br>
5. Altera Stratix Development board support (ALTERA_STRATIX)=C2=A0
        <br>
6. Altera Stratix Pro Development board support (ALTERA_STRATIX_PRO)=C2=A0
        <br>
7. Altera Stratix II Development board support (ALTERA_STRATIX_II)=C2=A0
        <br>
8. Altera Cyclone Development board support (ALTERA_CYCLONE)=C2=A0
        <br>
9. Altera CYCLONE II Development board support (ALTERA_CYCLONE_II)=C2=A0
        <br>
10. Altera Cyclone 1C12 Evaluation board support
(ALTERA_CYCLONE_1C12_EVAL)=C2=A0
        <br>
&gt; 11. Altera DE2 Development board support (ALTERA_DE2)=C2=A0
        <br>
12. Altera Nios II Embedded Evaluation Kit support (ALTERA_NEEK_C3)=C2=A0
        <br>
13. Altera CYCLONE III 3C120 Development board support
(ALTERA_CYCLONE_III)=C2=A0
        <br>
choice[1-13]: 11=C2=A0
        <br>
Nios II Hardware Multiply Support=C2=A0
        <br>
1. None (NIOS2_HW_MUL_OFF)=C2=A0
        <br>
&gt; 2. Enable mul instruction (NIOS2_HW_MUL)=C2=A0
        <br>
3. Enable mul and mulx instructions (NIOS2_HW_MULX)=C2=A0
        <br>
choice[1-3?]: 2=C2=A0
        <br>
*=C2=A0
        <br>
* Platform drivers Options=C2=A0
        <br>
*=C2=A0
        <br>
GPIO interface (GENERIC_GPIO) [N/y/?] n=C2=A0
        <br>
Support of DMA controller with Avalon interface (AVALON_DMA) [N/y/?] n=C2=
=A0
        <br>
Altera PCI host bridge (PCI_ALTPCI) [N/y] n=C2=A0
        <br>
Remote update support (ALTERA_REMOTE_UPDATE) [N/y/?] n=C2=A0
        <br>
*=C2=A0
        <br>
* Miscellaneous Options=C2=A0
        <br>
*=C2=A0
        <br>
Include breakpoint trap on kernel startup (BREAK_ON_START) [N/y/?] n=C2=A0
        <br>
Kernel executes from=C2=A0
        <br>
&gt; 1. RAM (RAMKERNEL)=C2=A0
        <br>
choice[1]: 1=C2=A0
        <br>
Preemption Model=C2=A0
        <br>
1. No Forced Preemption (Server) (PREEMPT_NONE)=C2=A0
        <br>
2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)=C2=A0
        <br>
&gt; 3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT)=C2=A0
        <br>
choice[1-3]: 3=C2=A0
        <br>
Timer frequency=C2=A0
        <br>
&gt; 1. 100 HZ (HZ_100)=C2=A0
        <br>
2. 250 HZ (HZ_250)=C2=A0
        <br>
3. 300 HZ (HZ_300)=C2=A0
        <br>
4. 1000 HZ (HZ_1000)=C2=A0
        <br>
choice[1-4?]: 1=C2=A0
        <br>
Default kernel command string (CMDLINE) []=C2=A0
        <br>
Passed kernel command line from u-boot (PASS_CMDLINE) [N/y/?] n=C2=A0
        <br>
Interrupt pipeline (IPIPE) [Y/?] (NEW) y=C2=A0
        <br>
Max domains (IPIPE_DOMAINS) [4] (NEW) 4=C2=A0
        <br>
Maintain code compatibility with older releases (IPIPE_COMPAT) [Y/n/?]
(NEW) y=C2=A0
        <br>
Memory model=C2=A0
        <br>
&gt; 1. Flat Memory (FLATMEM_MANUAL)=C2=A0
        <br>
choice[1]: 1=C2=A0
        <br>
Add LRU list to track non-evictable pages (UNEVICTABLE_LRU) [Y/n/?] y=C2=A0
        <br>
Turn on mmap() excess space trimming before booting
(NOMMU_INITIAL_TRIM_EXCESS) [1] 1=C2=A0
        <br>
Link address offset for booting (BOOT_LINK_OFFSET) [0x00500000]
0x00500000=C2=A0
        <br>
*=C2=A0
        <br>
* Kernel hacking=C2=A0
        <br>
*=C2=A0
        <br>
Show timing information on printks (PRINTK_TIME) [N/y/?] n=C2=A0
        <br>
Enable __deprecated logic (ENABLE_WARN_DEPRECATED) [Y/n/?] y=C2=A0
        <br>
Enable __must_check logic (ENABLE_MUST_CHECK) [N/y/?] n=C2=A0
        <br>
Warn for stack frames larger than (needs gcc 4.4) (FRAME_WARN) [1024]
1024=C2=A0
        <br>
Magic SysRq key (MAGIC_SYSRQ) [N/y/?] n=C2=A0
        <br>
Enable unused/obsolete exported symbols (UNUSED_SYMBOLS) [N/y/?] n=C2=A0
        <br>
Debug Filesystem (DEBUG_FS) [N/y/?] n=C2=A0
        <br>
Run 'make headers_check' when building vmlinux (HEADERS_CHECK) [N/y/?]
n=C2=A0
        <br>
I-pipe debugging (IPIPE_DEBUG) [N/y] (NEW) n=C2=A0
        <br>
Kernel debugging (DEBUG_KERNEL) [Y/n/?] y=C2=A0
        <br>
Debug shared IRQ handlers (DEBUG_SHIRQ) [N/y/?] n=C2=A0
        <br>
Detect Soft Lockups (DETECT_SOFTLOCKUP) [Y/n/?] y=C2=A0
        <br>
Panic (Reboot) On Soft Lockups (BOOTPARAM_SOFTLOCKUP_PANIC) [N/y/?] n=C2=A0
        <br>
Detect Hung Tasks (DETECT_HUNG_TASK) [Y/n/?] y=C2=A0
        <br>
Panic (Reboot) On Hung Tasks (BOOTPARAM_HUNG_TASK_PANIC) [N/y/?] n=C2=A0
        <br>
Collect scheduler debugging info (SCHED_DEBUG) [Y/n/?] y=C2=A0
        <br>
Collect scheduler statistics (SCHEDSTATS) [N/y/?] n=C2=A0
        <br>
Collect kernel timers statistics (TIMER_STATS) [N/y/?] n=C2=A0
        <br>
Debug object operations (DEBUG_OBJECTS) [N/y/?] n=C2=A0
        <br>
Debug slab memory allocations (DEBUG_SLAB) [N/y/?] n=C2=A0
        <br>
RT Mutex debugging, deadlock detection (DEBUG_RT_MUTEXES) [N/y/?] n=C2=A0
        <br>
Built-in scriptable tester for rt-mutexes (RT_MUTEX_TESTER) [N/y/?] n=C2=A0
        <br>
Spinlock and rw-lock debugging: basic checks (DEBUG_SPINLOCK) [N/y/?]
n=C2=A0
        <br>
Mutex debugging: basic checks (DEBUG_MUTEXES) [N/y/?] n=C2=A0
        <br>
Spinlock debugging: sleep-inside-spinlock checking
(DEBUG_SPINLOCK_SLEEP) [N/y/?] n=C2=A0
        <br>
Locking API boot-time self-tests (DEBUG_LOCKING_API_SELFTESTS) [N/y/?]
n=C2=A0
        <br>
kobject debugging (DEBUG_KOBJECT) [N/y/?] n=C2=A0
        <br>
Compile the kernel with debug info (DEBUG_INFO) [Y/n/?] y=C2=A0
        <br>
Debug VM (DEBUG_VM) [N/y/?] n=C2=A0
        <br>
Debug the global anon/private NOMMU mapping region tree
(DEBUG_NOMMU_REGIONS) [N/y/?] n=C2=A0
        <br>
Debug filesystem writers count (DEBUG_WRITECOUNT) [N/y/?] n=C2=A0
        <br>
Debug memory initialisation (DEBUG_MEMORY_INIT) [N/y/?] n=C2=A0
        <br>
Debug linked list manipulation (DEBUG_LIST) [N/y/?] n=C2=A0
        <br>
Debug SG table operations (DEBUG_SG) [N/y/?] n=C2=A0
        <br>
Debug notifier call chains (DEBUG_NOTIFIERS) [N/y/?] n=C2=A0
        <br>
Delay each boot printk message by N milliseconds (BOOT_PRINTK_DELAY)
[N/y/?] n=C2=A0
        <br>
torture tests for RCU (RCU_TORTURE_TEST) [N/y/?] n=C2=A0
        <br>
Check for stalled CPUs delaying RCU grace periods
(RCU_CPU_STALL_DETECTOR) [N/y/?] n=C2=A0
        <br>
Self test for the backtrace code (BACKTRACE_SELF_TEST) [N/y/?] n=C2=A0
        <br>
Force extended block device numbers and spread them
(DEBUG_BLOCK_EXT_DEVT) [N/y/?] n=C2=A0
        <br>
Fault-injection framework (FAULT_INJECTION) [N/y/?] n=C2=A0
        <br>
Debug page memory allocations (PAGE_POISONING) [N/y/?] n=C2=A0
        <br>
#=C2=A0
        <br>
# configuration written to .config=C2=A0
        <br>
#=C2=A0
        <br>
no emulation specific options.=C2=A0
        <br>
RUNNING hwselect=C2=A0
        <br>
=C2=A0<br>
--- Please select which CPU you wish to build the kernel against:
        <br>
=C2=A0<br>
(1) cpu - Class: altera_nios2 Type: s Version: 7.080910
        <br>
=C2=A0<br>
Selection: 1
        <br>
=C2=A0<br>
--- Please select a device to execute kernel from:
        <br>
=C2=A0<br>
(1) ext_flash
        <br>
Class: altera_avalon_cfi_flash
        <br>
Size: 8388608 bytes=C2=A0
        <br>
=C2=A0<br>
(2) onchip_ram_64_kbytes
        <br>
Class: altera_avalon_onchip_memory2
        <br>
Size: 65536 bytes
        <br>
=C2=A0<br>
(3) ext_ram
        <br>
Class: altera_nios_dev_kit_stratix_edition_sram2
        <br>
Size: 1048576 bytes
        <br>
=C2=A0<br>
(4) sdram
        <br>
Class: altera_avalon_new_sdram_controller
        <br>
Size: 16777216 bytes
        <br>
=C2=A0<br>
Selection: 4
        <br>
=C2=A0<br>
--- Summary using
        <br>
=C2=A0<br>
PTF: /home/sonda/Desktop/f/standard/std_1s40.ptf
        <br>
CPU: cpu
        <br>
Program memory to execute from: sdram
        <br>
=C2=A0<br>
--- Settings written to
/home/sonda/Desktop/nios2-linux/uClinux-dist/linux-2.6.x/arch/nios2/hardw=
are.mk
        <br>
=C2=A0<br>
make[3]: quittant le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/linux-2.6 =C2=BB
        <br>
make[2]: quittant le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors/Altera/nios2 =C2=BB
        <br>
make[1]: quittant le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/nios2-linux/uClinux-dist/vendors =C2=BB
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
-------------------------------------------------------------------------=
---------------------------------------------------------------------
        <br>
=C2=A0<br>
Regards,<br>
        <br>
--- En date de=C2=A0: <b>Dim 28.3.10, Patrice Kadionik <i><a class=3D"moz=
-txt-link-rfc2396E" href=3D"mailto:kadionik@domain.hid">&lt;kadio=
nik@domain.hid&gt;</a></i></b>
a =C3=A9crit=C2=A0:<br>
        <blockquote
 style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padd=
ing-left: 5px;"><br>
De: Patrice Kadionik <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:ka=
dionik@domain.hid">&lt;kadionik@domain.hid&gt;</a><br>
Objet: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space
support<br>
=C3=80: "Chtourou Sonda" <a class=3D"moz-txt-link-rfc2396E" href=3D"mailt=
o:chtourou_sonda@domain.hid">&lt;chtourou_sonda@domain.hid&gt;</a><br>
Cc: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:xenomai@xenomai.org=
.org">xenomai@xenomai.org</a><br>
Date: Dimanche 28 mars 2010, 13h26<br>
          <br>
          <div id=3D"yiv1992270376"> Le 20:59, Chtourou Sonda a =C3=A9cri=
t=C2=A0:
          <blockquote type=3D"cite">
            <style type=3D"text/css"><!--#yiv1992270376 DIV {margin:0px;}=
--></style>
            <div
 style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;">
            <div>
            <p style=3D"margin: 0cm 0cm 10pt;" class=3D"MsoNormal"><span
 style=3D"" lang=3D"EN-US"><font face=3D"Calibri">Dears, <br style=3D"">
            </font></span></p>
            </div>
            </div>
          </blockquote>
Hi,<br>
          <br>
          <blockquote type=3D"cite">
            <div
 style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;">
            <div>
            <p style=3D"margin: 0cm 0cm 10pt;" class=3D"MsoNormal"><span
 style=3D"" lang=3D"EN-US"><font face=3D"Calibri"><br style=3D"">
            </font></span></p>
            <p style=3D"margin: 0cm 0cm 10pt;" class=3D"MsoNormal"><span
 style=3D"" lang=3D"EN-US"><font face=3D"Calibri">I built the uClinux ker=
nel
for NIOS
II and it run well on the target board. I followed the typical actions
available here : <a moz-do-not-send=3D"true" rel=3D"nofollow"
 class=3D"moz-txt-link-freetext" target=3D"_blank"
 href=3D"http://www.nioswiki.com/">http://www.nioswiki.com/</a> <br>
            <br>
Now, I want to add a co-scheduler xenomai to the kernel (uclinux) to
reduce its latency. I followed these steps:
(<a moz-do-not-send=3D"true" rel=3D"nofollow" class=3D"moz-txt-link-freet=
ext"
 target=3D"_blank"
 href=3D"http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL"=
>http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL</a>)<br>
            </font></span></p>
            </div>
            </div>
          </blockquote>
I've tried to reproduce your compilation error but without success.<br>
          <br>
For using Xenomai on NIOS II processor with uClinux, you must add extra
hardware in your SoPC design as explained in this tutorial
(<a moz-do-not-send=3D"true" rel=3D"nofollow" class=3D"moz-txt-link-freet=
ext"
 target=3D"_blank"
 href=3D"http://uuu.enseirb.fr/%7Ekadionik/nios2-xenomai/Xenomai%20on%20N=
IOS%20II%20Softcore%20Processor%20Guide-v1.1.pdf">http://uuu.enseirb.fr/~=
kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20Processor%20=
Guide-v1.1.pdf</a>).<br>
          <br>
It is OK on my Altera 1S10 board=C2=A0 with Xenomai v2.5.1 (see traces).<=
br>
          <br>
Sincerely;<br>
          <br>
Patrice<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
          <br>
          <tt>Uncompressing Linux... Ok, booting the
kernel.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4 PREEMPT
Sun Mar 0<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
          <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
          <br>
uClinux/Nios
II=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 <br>
Built 1 zonelists in Zone order, mobility grouping off.=C2=A0 Total pages=
:
4064=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Kernel command
line:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
NR_IRQS:32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          <br>
PID hash table entries: 64 (order: 6, 256
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
I-pipe 1.1-00: pipeline
enabled.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Dentry cache hash table entries: 2048 (order: 1, 8192
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Inode-cache hash table entries: 1024 (order: 0, 4096
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code, 2059k
data)=C2=A0=C2=A0 <br>
Calibrating delay loop... 24.06 BogoMIPS
(lpj=3D120320)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <br>
Mount-cache hash table entries:
512=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
net_namespace: 264
bytes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
NET: Registered protocol family
16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
init_BSP(): registering device
resources=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <br>
bio: create slab &lt;bio-0&gt; at
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 <br>
NET: Registered protocol family
2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
IP route cache hash table entries: 1024 (order: 0, 4096
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
TCP established hash table entries: 512 (order: 0, 4096
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
TCP bind hash table entries: 512 (order: -1, 2048
bytes)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br=
>
TCP: Hash tables configured (established 512 bind
512)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <br>
TCP reno
registered=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
<br>
NET: Registered protocol family
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
I-pipe: Domain Xenomai
registered.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: hal/nios2
started.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: scheduling class idle
registered.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <br>
Xenomai: scheduling class rt
registered.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: real-time nucleus v2.5.1 (Speed Of Light)
loaded.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: starting native API
services.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: starting POSIX
services.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
Xenomai: starting RTDM
services.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
io scheduler noop
registered=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <br>
io scheduler deadline registered
(default)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <br>
ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera
UART=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
console [ttyS0] enabled=C2=A0=C2=A0</tt>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <br>
          <br>
          <br>
          <br>
          <br>
          <blockquote type=3D"cite">
            <div
 style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;">
            <div>
            <p style=3D"margin: 0cm 0cm 10pt;" class=3D"MsoNormal"><span
 style=3D"" lang=3D"EN-US"><font face=3D"Calibri">$
$xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2
--adeos=3D$xenomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nios2=
-1.1-00.patch<br>
=C2=A0 --linux=3D$linux_tree<br>
$ $xenomai-2.5.1/configure --host=3Dnios2-linux<br>
$ make install DESTDIR=3D$uClinux-dist/romfs<br>
            <br>
But, in this step, I got this error:<br>
            <br>
eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm<br>
libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc
-Wl,-elf2flt -o check-vdso check_vdso-check-vdso.o=C2=A0
../../skins/native/.libs/libnative.a -lpthread -lm<br>
check-vdso.elf2flt(.text+0x16c): In function `main':<br>
: undefined reference to `xeno_sem_heap'<br>
check-vdso.elf2flt(.text+0x170): In function `main':<br>
: undefined reference to `xeno_sem_heap'<br>
collect2: ld returned 1 exit status<br>
make[3]: *** [check-vdso] Erreur 1<br>
make[3]: quittant le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit =C2=BB<br>
make[2]: *** [all-recursive] Erreur 1<br>
make[2]: quittant le r=C3=A9pertoire =C2=AB
/home/sonda/Desktop/xenomai-2.5.1/src/testsuite =C2=BB<br>
make[1]: *** [all-recursive] Erreur 1<br>
make[1]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenomai-2=
.5.1/src
=C2=BB<br>
make: *** [all-recursive] Erreur 1<br>
            <br>
what can I do? Please help</font></span></p>
            <p style=3D"margin: 0cm 0cm 10pt;" class=3D"MsoNormal"><span
 style=3D"" lang=3D"EN-US"><font face=3D"Calibri"> Regards,</font></span>=
</p>
            </div>
            </div>
            <br>
            <pre><fieldset class=3D"mimeAttachmentHeader"></fieldset>
_______________________________________________
Xenomai-help mailing list
<a moz-do-not-send=3D"true" rel=3D"nofollow"
 class=3D"moz-txt-link-abbreviated" ymailto=3D"mailto:Xenomai-help@domain.hid=
g"
 target=3D"_blank" href=3D"/mc/compose?to=3DXenomai-help@domain.hid">Xenomai=
-help@domain.hid</a>
<a moz-do-not-send=3D"true" rel=3D"nofollow" class=3D"moz-txt-link-freete=
xt"
 target=3D"_blank" href=3D"https://mail.gna.org/listinfo/xenomai-help">ht=
tps://mail.gna.org/listinfo/xenomai-help</a>
  </pre>
          </blockquote>
          <br>
          <br>
          <pre class=3D"moz-signature">--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             <a moz-do-not-send=3D"true" rel=3D"nofollo=
w"
 class=3D"moz-txt-link-freetext" target=3D"_blank"
 href=3D"http://www.enseirb-matmeca.fr/%7Ekadionik">http://www.enseirb-ma=
tmeca.fr/~kadionik</a> +
+ IMS Laboratory               <a moz-do-not-send=3D"true" rel=3D"nofollo=
w"
 class=3D"moz-txt-link-freetext" target=3D"_blank"
 href=3D"http://www.ims-bordeaux.fr/">http://www.ims-bordeaux.fr/</a>    =
         +
+ ENSEIRB-MATMECA              <a moz-do-not-send=3D"true" rel=3D"nofollo=
w"
 class=3D"moz-txt-link-freetext" target=3D"_blank"
 href=3D"http://www.enseirb-matmeca.fr">http://www.enseirb-matmeca.fr</a>=
           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex =20
        voice : +33 5.56.84.23.47               +
+ FRANCE                       <a moz-do-not-send=3D"true" rel=3D"nofollo=
w"
 class=3D"moz-txt-link-freetext"
 ymailto=3D"mailto:patrice.kadionik@domain.hid" target=3D"_blank"
 href=3D"/mc/compose?to=3Dpatrice.kadionik@domain.hid">mailto:patric=
e.kadionik@domain.hid</a> +
+----------------------------------------------------------------------+
          </pre>
          </div>
        </blockquote>
        </td>
      </tr>
    </tbody>
  </table>
  <br>
</blockquote>
<br>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.enseirb-matmeca.fr/~kadionik">http://www.enseirb-matmeca.fr/~=
kadionik</a> +
+ IMS Laboratory               <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.ims-bordeaux.fr/">http://www.ims-bordeaux.fr/</a>            =
 +
+ ENSEIRB-MATMECA              <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.enseirb-matmeca.fr">http://www.enseirb-matmeca.fr</a>        =
   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       <a class=3D"moz-txt-link-freetext" href=3D=
"mailto:patrice.kadionik@domain.hid">mailto:patrice.kadionik@domain.hid=
deaux.fr</a> +
+----------------------------------------------------------------------+
</pre>
</body>
</html>

--------------020008040409050001080703--

