From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Wed, 15 Nov 2006 11:21:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151121.51836.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Kernel crash during queue create/destroy
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

Hello,
I got some trouble with the native skin and queues, when creating / deleting 
queues, my Kernel sometimes (actually very often...) crashes, leading to a 
frozen system, with my Xenomai program continuing until it returns. I tried 
to isolate / reproduce the problem, which lead me to the following demo-code.

This piece of code lets reproducible crash my Systems running Kernel 
2.6.17.14 / Xenomai 2.2.5  as well as Kernel 2.6.17.6 / Xenomai 2.2.0. 

<code>
#include <iostream>
#include <sys/mman.h>
#include <assert.h>
#include "native/task.h"
#include "native/timer.h"
#include "native/queue.h"

RT_TASK maintask;

int main(void){
	std::cout << "xenomai 2.2.4 timer-test" << std::endl;
	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	int err;

	err = rt_task_shadow (&maintask,"maintask",10,0);
	std::cout << "task shadow:" << err << std::endl;
	
	err = rt_timer_set_mode(1000000);
	std::cout << "timer set mode:" << err << std::endl;
	
	err = rt_task_sleep(10);
	std::cout << "task sleep:" << err << std::endl;
	
	std::cout << "testing XENOMAI q-functions" << std::endl;
		RT_QUEUE* testq;
		for(int i = 0; i < 100; i++){
			for(int j = 0; j < 10; j++){
				testq = new RT_QUEUE;
				err = rt_queue_create(testq,"testq",10240,100,Q_FIFO);
				if(err == -EEXIST){
					err = rt_queue_bind(testq,"testq",100000000);
				}
				assert(err == 0);
				rt_task_sleep(1); // commenting this seems to make things work
				err = rt_queue_delete(testq);
				assert(err == 0);
				delete testq;
				//rt_task_sleep(10); // uncommenting this seems to make things work 
			}
			std::cout << "." << std::flush;
		}	
		std::cout << "ok" << std::endl;
	return 0;
}

</code>

The crash leads ti the following information in syslog:

<syslog>

Nov 14 16:47:55 localhost kernel: BUG: unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 14 16:47:55 localhost kernel:  printing eip:
Nov 14 16:47:55 localhost kernel: c01a6f66
Nov 14 16:47:55 localhost kernel: *pde = 00000000
Nov 14 16:47:55 localhost kernel: Oops: 0000 [#1]
Nov 14 16:47:55 localhost kernel: PREEMPT
Nov 14 16:47:55 localhost kernel: Modules linked in: ipv6 nfs lockd sunrpc 
snd_mpu401 floppy pcspkr rtc snd_via82xx gameport snd_ac97_codec snd_ac97_bus 
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device 
snd soundcore i2c_viapro i2c_core generic 8139cp amd64_agp agpgart tsdev 
mousedev ehci_hcd usbhid uhci_hcd usbcore via82cxxx 8139too mii psmouse 
ide_generic ide_disk ide_cd cdrom ide_core unix
Nov 14 16:47:55 localhost kernel: CPU:    0
Nov 14 16:47:55 localhost kernel: EIP:    0060:[remove_proc_entry+51/333]    
Not tainted VLI
Nov 14 16:47:55 localhost kernel: EFLAGS: 00010286   (2.6.17.14 #5)
Nov 14 16:47:55 localhost kernel: EIP is at remove_proc_entry+0x33/0x14d
Nov 14 16:47:55 localhost kernel: eax: 00000000   ebx: c03d10f4   ecx: 
ffffffff   edx: 00000000
Nov 14 16:47:55 localhost kernel: esi: c03cd7f8   edi: 00000000   ebp: 
f790f8c0   esp: c1907f00
Nov 14 16:47:55 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov 14 16:47:55 localhost kernel: Process events/0 (pid: 4, 
threadinfo=c1906000 task=c190ea90)
Nov 14 16:47:55 localhost kernel: Stack: 00000000 c03d10f4 c03cd7f8 c03464cc 
c0148919 00000000 f790f8c0 00000000
Nov 14 16:47:55 localhost kernel:        00000000 c02ff30d c02ff282 f617b440 
f6371ac0 c18e0640 c03460e0 00000200
Nov 14 16:47:55 localhost kernel:        00000000 c0126773 00000000 c0147fa5 
c1906000 c190ea90 fffffffb c18e0640
Nov 14 16:47:55 localhost kernel: Call Trace:
Nov 14 16:47:55 localhost kernel:  <c0148919> 
registry_proc_callback+0x974/0x9ec  <c0126773> run_workqueue+0xd7/0x172
Nov 14 16:47:55 localhost kernel:  <c0147fa5> registry_proc_callback+0x0/0x9ec  
<c0126906> worker_thread+0xf8/0x12a
Nov 14 16:47:55 localhost kernel:  <c0112a33> default_wake_function+0x0/0x12  
<c02e04a4> schedule+0x62e/0x64d
Nov 14 16:47:55 localhost kernel:  <c0112a33> default_wake_function+0x0/0x12  
<c012680e> worker_thread+0x0/0x12a
Nov 14 16:47:55 localhost kernel:  <c0129922> kthread+0x79/0xa3  <c01298a9> 
kthread+0x0/0xa3
Nov 14 16:47:55 localhost kernel:  <c0101385> kernel_thread_helper+0x5/0xb
Nov 14 16:47:55 localhost kernel: Code: 00 8b 54 24 14 89 14 24 75 19 89 e0 50 
8d 44 24 1c 50 52 e8 a4 f5 ff ff 83 c4 0c 85 c0 0f 85 1d 01 00 00 8b 3c 24 31 
c0 83 c9 ff <f2> ae f7 d1 49 81 3d 80 5c 34 c0 00 39 34 c0 89 ce 75 0a b8 01
Nov 14 16:47:55 localhost kernel: EIP: [remove_proc_entry+51/333] 
remove_proc_entry+0x33/0x14d SS:ESP 0068:c1907f00

</syslog>

Thanks again, 
Stephan

