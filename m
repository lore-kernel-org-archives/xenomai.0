MIME-Version: 1.0
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Message-ID: <OF4D873F49.344BC96D-ONC1257260.005DC836-C1257260.00617F2A@retarus.de>
Date: Thu, 11 Jan 2007 18:44:56 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [Xenomai-core] [BUG?] registry usage + module removal causes kernel
	oops (xenomai native)
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

Hi again,

I observed another wrong(?) behaviour of xenomai, caused by a wrong
behaviour in our code :) The resources (tested with mutexes) are not
deleted after the process which created them exits without cleaning up
(for example, it crashes).

For anonymous objects, i don't see a reason why this would be a
defined behaviour, since there is no way to reuse those objects.
Therefore, I consider this to be a bug, as it will finally eat up all 
memory.
Or are there any technical reasons for this?

Another bug appeared for objects registered at the registry. When
using xeno-native and xeno-rtdm, the order of removal seems to be
important. I appended a small code sample to register a mutex at
the registry. After the program exits, the modules can not be unloaded
in the order
  1) xeno-native
  2) xeno-rtdm,
but the other way around works fine. Instead, rmmod ends up with a
segmentation fault, dmesg output appended.

I tested this on xenomai 2.3.0/linux 2.6.19 and 2.2.5-svn/linux2.6.17.14.


Thanks for fixing the previously posted bug ;)

Thomas Wiedemann

-------------
/* The test code: */
/* compile with */
/* gcc -g -o xenwatchtest xenwatchtest.c  `/usr/xenomai/bin/xeno-config 
--xeno-cflags` `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lnative */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>


int main() {
        RT_TASK  rttask;
        RT_MUTEX *m;
        int i;
 
        mlockall(MCL_CURRENT | MCL_FUTURE);

        if(rt_task_shadow(&rttask,"test",50,0)<0) {
                fprintf(stderr,"Error creating rt task!\n");
                exit(0);
        }
        if((m=(RT_MUTEX *)malloc(sizeof(RT_MUTEX))) == NULL) {
                perror("malloc");
                exit(1);
        }
        i=rt_mutex_create(m, "ich_bin_ein_berliner");
        if(i!=0) {
                fprintf(stderr,"rt_mutex_create(): %s\n",strerror(-i));
        }

        /* do not clean up ... */
        exit(0);
}
-- end of test code

-- dmesg output after 'rmmod xeno-native ; rmmod xeno-rtdm':
[  175.831909] Xenomai: stopping native API services.
[  178.671282] Xenomai: stopping RTDM services.
[  178.867527] BUG: unable to handle kernel paging request at virtual 
address debb7e54
[  178.867533]  printing eip:
[  178.867535] deb8e663
[  178.867537] *pde = 01435067
[  178.867539] *pte = 00000000
[  178.867542] Oops: 0000 [#1]
[  178.867547] Modules linked in: xeno_rtdm xeno_nucleus loop i2c_i801 
iTCO_wdt e100 ehci_hcd mii 8250_pnp 8250 serial_core softdog
[  178.867561] CPU:    0
[  178.867562] EIP:    0060:[<deb8e663>]    Tainted: GF     VLI
[  178.867563] EFLAGS: 00010282   (2.6.19-x5 #1)
[  178.867589] EIP is at xnregistry_cleanup+0x43/0x140 [xeno_nucleus]
[  178.867594] eax: dc300b58   ebx: dc300928   ecx: c03c8640   edx: 
debb7e54
[  178.867598] esi: 00000000   edi: 0000002e   ebp: d5972000   esp: 
d5973f48
[  178.867602] ds: 007b   es: 007b   ss: 0068
[  178.867606] Process rmmod (pid: 2503, ti=d5972000 task=c1502a90 
task.ti=d5972000)
[  178.867610] Stack: 00000000 00000000 00000003 deb86992 de86b340 
00000000 c01327bb 6f6e6578
[  178.867618]        6474725f d8bd006d c0148651 b7ef2000 dd1a1040 
c0149037 ffffffff b7ef3000
[  178.867626]        dd1a1044 d6c83a58 b7ef3000 d6c83a64 d6c83a58 
001a1040 de86b340 00000880
[  178.867634] Call Trace:
[  178.867637]  [<deb86992>] xnpod_shutdown+0x122/0x1a0 [xeno_nucleus]
[  178.867655]  [<c01327bb>] sys_delete_module+0x12b/0x1a0
[  178.867663]  [<c0148651>] remove_vma+0x41/0x50
[  178.867670]  [<c0149037>] do_munmap+0x197/0x1f0
[  178.867677]  [<c0102cac>] sysenter_past_esp+0x65/0x69
[  178.867683]  =======================
[  178.867685] Code: 90 8d b4 26 00 00 00 00 8b 1c ba 85 db 74 50 89 f6 8d 
bc 27 00 00 00 00 8b 03 8b 73 04 85 c0 74 21 8b 50 40 85 d2 74 1a 8b 40 0c 
<8b> 12 e8 96 57 5f e1 8b 03 8b 40 40 8b 50 08 4a 85 d2 89 50 08
[  178.867712] EIP: [<deb8e663>] xnregistry_cleanup+0x43/0x140 
[xeno_nucleus] SS:ESP 0068:d5973f48

