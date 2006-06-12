From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	not start up
Date: Mon, 12 Jun 2006 07:08:51 +0200
References: <446F852B.7090400@domain.hid>
	<200605222208.15908.niklaus.giger@domain.hid>
	<44722DCF.80208@domain.hid>
In-Reply-To: <44722DCF.80208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606120708.52090.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe

I redid my testing wit revision 1188 (+ modification from me for the 
xeno-test). 

The lockup at startup is still there if CONFIG_XENO_OPT_TIMING_PERIOD !=  0 
and if the skins native, posix, rtdm, uvm and skins skins are compiled in.
Timing settings was always CONFIG_XENO_OPT_TIMING_PERIODIC=y.

Linux version 2.6.14-1188M-hcu3 (root@domain.hid) (gcc version 3.4.4) #4 Sun Jun 11 
19:45:36 CEST 2006
HCU3 Netstal Maschinen AG with U-Boot 1.1.2.
Built 1 zonelists
Kernel command line: console=ttyS0,9600 root=/dev/nfs rw 
nfsroot=172.25.1.58:/home/hcu/rootfs ip=172.25.1.5:172.15.1.58:::hcu4::off 
panic=30
PID hash table entries: 256 (order: 8, 4096 bytes)
I-pipe 1.3-03: pipeline enabled.
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29884k available (1740k kernel code, 608k data, 92k init, 0k highmem)
Mount-cache hash table entries: 512
softlockup thread 0 started up.
NET: Registered protocol family 16

I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.2-rc2 (Engines Of Creation) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting UVM services.
Xenomai: incompatible timer mode (aperiodic found, need periodic).
Xenomai: VxWorks skin init failed, code -16.
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
<..>

Best regards 

-- 
Niklaus Giger

