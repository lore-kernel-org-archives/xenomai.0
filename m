From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 7 Jan 2006 21:24:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601072124.44626.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems cross-compiling for PPC405
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
To: xenomai-core <xenomai@xenomai.org>

Hi

I just upgraded to revision 392 of xenomai and got the following error trying
to compile the linux 2.6.14 kernel
  CC      kernel/xenomai/nucleus/heap.o
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1017:1: 
pasting "," and "args" does not give a valid preprocessing token
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c: In 
function `xnheap_mount':
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
error: `args' undeclared (first use in this function)
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
error: (Each undeclared identifier is reported only once
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
error: for each function it appears in.)
/mnt/data.ng/hcu/kernel/linux-2.6.14/kernel/xenomai/nucleus/heap.c:1015: 
warning: too many arguments for format
make[4]: *** [kernel/xenomai/nucleus/heap.o] Fehler 1
make[3]: *** [kernel/xenomai/nucleus] Fehler 2
make[2]: *** [kernel/xenomai] Fehler 2
make[1]: *** [kernel] Fehler 2


I am using GCC 3.4.4.

Best regards 
-- 
Niklaus Giger

