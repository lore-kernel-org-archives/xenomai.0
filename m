From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Tue, 26 Sep 2006 21:34:48 +0200
References: <200609232013.27649.niklaus.giger@domain.hid>
	<1159217987.4981.10.camel@domain.hid>
	<200609252315.38689.niklaus.giger@domain.hid>
In-Reply-To: <200609252315.38689.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262134.48627.niklaus.giger@domain.hid>
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
To: xenomai@xenomai.org

Here is the stack with adeos-ipipe 1.3 after applying your patch 

(gdb) info stack
#0  xnpod_fault_handler (fltinfo=0xc1489e18) at 
kernel/xenomai/nucleus/pod.c:216
#1  0xc004bad4 in xnpod_trap_fault (fltinfo=0x73) at 
kernel/xenomai/nucleus/pod.c:2907
#2  0xc0043ee8 in xnarch_trap_fault (event=115, domid=0, data=0xc01a9435) at 
include/asm/xenomai/bits/init.h:46
#3  0xc012dc38 in exception_event (event=3223286668, ipd=0x0, data=0xc01a9435) 
at arch/ppc/xenomai/hal.c:385
#4  0xc003fe18 in __ipipe_dispatch_event (event=0, data=0xc1489f50) at 
kernel/ipipe/core.c:665
#5  0xc000aecc in do_page_fault (regs=0xc1489f50, address=268448708, 
error_code=0) at include/linux/ipipe.h:445
#6  0xc0003258 in handle_page_fault ()
Previous frame inner to this frame (corrupt stack?)
(gdb) 

Hope it helps you
-- 
Niklaus Giger

