Message-ID: <448D366E.20802@domain.hid>
Date: Mon, 12 Jun 2006 11:39:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	not start up
References: <446F852B.7090400@domain.hid>
	<200605222208.15908.niklaus.giger@domain.hid>
	<44722DCF.80208@domain.hid>
	<200606120708.52090.niklaus.giger@domain.hid>
In-Reply-To: <200606120708.52090.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi Philippe
> 
> I redid my testing wit revision 1188 (+ modification from me for the 
> xeno-test). 
> 
> The lockup at startup is still there if CONFIG_XENO_OPT_TIMING_PERIOD !=  0 
> and if the skins native, posix, rtdm, uvm and skins skins are compiled in.
> Timing settings was always CONFIG_XENO_OPT_TIMING_PERIODIC=y.
> 
> Linux version 2.6.14-1188M-hcu3 (root@domain.hid) (gcc version 3.4.4) #4 Sun Jun 11 
> 19:45:36 CEST 2006
> HCU3 Netstal Maschinen AG with U-Boot 1.1.2.
> Built 1 zonelists
> Kernel command line: console=ttyS0,9600 root=/dev/nfs rw 
> nfsroot=172.25.1.58:/home/hcu/rootfs ip=172.25.1.5:172.15.1.58:::hcu4::off 
> panic=30
> PID hash table entries: 256 (order: 8, 4096 bytes)
> I-pipe 1.3-03: pipeline enabled.
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 29884k available (1740k kernel code, 608k data, 92k init, 0k highmem)
> Mount-cache hash table entries: 512
> softlockup thread 0 started up.
> NET: Registered protocol family 16
> 
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.2-rc2 (Engines Of Creation) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> Xenomai: starting UVM services.
> Xenomai: incompatible timer mode (aperiodic found, need periodic).
> Xenomai: VxWorks skin init failed, code -16.

This error (-EBUSY) is expected, since native, posix and uvm need 
aperiodic setup and vxworks wants periodic. Since all are built-ins and 
initialize immediately during the kernel boot up, a conflict arises.

I initially thought reading your post about the issue a few weeks ago 
that a lockup would occur even with:

CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
# CONFIG_XENO_SKIN_POSIX is unset
# CONFIG_XENO_SKIN_UVM is unset
# CONFIG_XENO_SKIN_VXWORKS is unset
# CONFIG_XENO_SKIN_PSOS is unset
# CONFIG_XENO_SKIN_VRTX is unset
# CONFIG_XENO_SKIN_UITRON is unset

but would not with:

CONFIG_XENO_SKIN_NATIVE=m
CONFIG_XENO_OPT_TIMING_PERIODIC=y
# CONFIG_XENO_SKIN_POSIX is unset
# CONFIG_XENO_SKIN_UVM is unset
# CONFIG_XENO_SKIN_VXWORKS is unset
# CONFIG_XENO_SKIN_PSOS is unset
# CONFIG_XENO_SKIN_VRTX is unset
# CONFIG_XENO_SKIN_UITRON is unset

Is it the case, or is the VxWorks skin always involved when the lockup 
occurs?

> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> <..>
> 
> Best regards 
> 


-- 

Philippe.

