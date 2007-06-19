Message-ID: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
From: apittaluga@domain.hid
Date: Tue, 19 Jun 2007 09:23:50 +0200
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=4EBBF86CDFBBFC6E8f9e8a93df938690918c4EBBF86CDFBBFC6E"
Content-Disposition: inline
Subject: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
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

--0__=4EBBF86CDFBBFC6E8f9e8a93df938690918c4EBBF86CDFBBFC6E
Content-type: text/plain; charset=US-ASCII

Hi,
running a simple test application which spawns a periodic task writing on a
serial interface
the system hangs performing the rt_dev_close.
The test program ran fine with xeno 2.2.6 with "Shared Interrupts" enabled,
so as with
xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno 2.3.1 with
"Shared Interrupts" enabled, so the problem seems to be in the shared
interrupts handling area.
kernel is 2.6.20 adeos patched

Any suggestion?

Many Thanks

here follows the kernel dumps:

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000008
printing eip:
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: xeno_16550A ipv6 nfs lockd sunrpc ide_scsi i2c_i801
i2c_core sg shpchp rng_core evdev ehci_hcd uhci_hcd intel
_agp agpgart e1000 serio_raw pcspkr
CPU: 0
EIP: 0060: Not tainted VLI
EFLAGS: 00010046 (2.6.20.1-xeno-2.3.1 #16)
EIP is at xnintr_edge_shirq_handler+0xda/0x2f0
eax: 00000000 ebx: 00000000 ecx: f2d58074 edx: c0529080
esi: c05290c0 edi: 69bfb728 ebp: 000000c9 esp: c04b9f08
ds: 007b es: 007b ss: 0068
I-pipe domain Xenomai
Process modprobe (pid: 1876, ti=f7a44000 task=f7d7d030 task.ti=f7a44000)
Stack: c047d100 c0487400 00000001 00000001 00000001 f2d58050 c0527a10
c05293f8
00000004 c04fbc38 c051d100 00000004 00000000 c0143fa8 00000000 c047d100
c051d100 c04fbc38 00000000 00000004 c0527400 c0112de2 c03bc88a 00000000
Call Trace:
__ipipe_dispatch_wired+0xdB/0x120
__ipipe_handle_irq+0x72/0x2b0
schedule+0x41a/0x880
common_interrupt+0x21/0x38
mwait_idle_with_hints+0x3f/0x50
mwait_idle+0x0/0x10
cpu_idle+0x6f/0x90
start_kernel+0x1d0/0x240
unknown_bootoption+0x0/0x190
=======================
Code: 03 00 00 89 f0 89 96 b4 03 00 00 8b 15 80 87 52 c0 29 d0 83 e8 40 c1
f8 04 69 c0 ab aa aa aa 8d 44 18 24 87 86 b8 03 00 00
89 d9 <ff> 53 08 09 44 24 10 0f b6 d0 83 fa 02 0f 84 04 01 00 00 4a 0f
EIP: xnintr_edge_shirq_handler+0xda/0x2f0 SS:ESP 0068:c04b9f08
Kernel panic - not syncing: Attempted to kill the idle task!

hardware:
Intel Core DUO Processor Single Board Computer

here follows the test application:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#include <signal.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <rtdm/rtserial.h>

#define FALSE 0
#define TRUE 1
#define BAUDRATE B115200

#define WRITE_FILE "rtser0"

RT_TASK rt_writer_tid;
int fd;

static const struct rtser_config write_config = {
0xFFDF, /* config_mask */
115200, /* baud_rate */
RTSER_DEF_PARITY, /* parity */
RTSER_DEF_BITS, /* data_bits */
RTSER_DEF_STOPB, /* stop_bits */
RTSER_DEF_HAND, /* handshake */
RTSER_DEF_FIFO_DEPTH, /* fifo_depth*/
RTSER_DEF_TIMEOUT, /* rx_timeout */
RTSER_DEF_TIMEOUT, /* tx_timeout */
RTSER_DEF_TIMEOUT, /* event_timeout */
RTSER_DEF_TIMESTAMP_HISTORY /* timestamp_history */
};

void rt_writer (void *cookie)
{
int error;
int res;
char* msg = "abrac";
error = rt_task_set_periodic(NULL,
TM_NOW,
rt_timer_ns2ticks(32000000));

for (;;) {
error = rt_task_wait_period(NULL);
res = rt_dev_write(fd, msg, strlen(msg));

}
}


void cleanup_upon_sig(int sig __attribute__((unused)))
{


rt_dev_close(fd);

exit(0);
}

int main(int argc, char** argv)
{
int error;


mlockall(MCL_CURRENT|MCL_FUTURE);

signal(SIGINT, cleanup_upon_sig);
signal(SIGTERM, cleanup_upon_sig);
signal(SIGHUP, cleanup_upon_sig);
signal(SIGALRM, cleanup_upon_sig);

fd = rt_dev_open(WRITE_FILE, 0);
if (fd < 0) {
perror(WRITE_FILE);
cleanup_upon_sig(0);
}
error = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
if (error) {
printf("error while RTSER_RTIOC_SET_CONFIG, code %d\n",error);
cleanup_upon_sig(0);
}

error = rt_task_spawn(&rt_writer_tid,"rt_writer",0,99,T_FPU,
rt_writer, NULL);
if (error) {
printf("rt_task_spawn: code %d\n",error);
return 2;
}
pause();
exit(0);

}


Alessandro Pittaluga

Alenia Aeronautica
Avionic System Qualification
Test Systems
Corso Marche, 41
10146 Torino (Italy)
Phone +39-011-756.2915
+39-011-996.0714
Fax +39-011-756.2517
--0__=4EBBF86CDFBBFC6E8f9e8a93df938690918c4EBBF86CDFBBFC6E
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font size="4">Hi,<br>
running a simple test application which spawns a periodic task writing on a serial interface<br>
the system hangs performing the rt_dev_close.<br>
The test program ran fine with xeno 2.2.6 with &quot;Shared Interrupts&quot; enabled, so as with<br>
xeno 2.3.1 with &quot;Shared Interrupts&quot; disabled. It fails with xeno 2.3.1 with &quot;Shared Interrupts&quot; enabled, so the problem seems to be in the shared interrupts handling area.<br>
kernel is 2.6.20 adeos patched<br>
<br>
Any suggestion?<br>
<br>
Many Thanks<br>
<br>
here follows the kernel dumps:<br>
<br>
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008<br>
printing eip:<br>
*pde = 00000000<br>
Oops: 0000 [#1]<br>
SMP <br>
Modules linked in: xeno_16550A ipv6 nfs lockd sunrpc ide_scsi i2c_i801 i2c_core sg shpchp rng_core evdev ehci_hcd uhci_hcd intel<br>
_agp agpgart e1000 serio_raw pcspkr <br>
CPU: 0<br>
EIP: 0060: Not tainted VLI<br>
EFLAGS: 00010046 (2.6.20.1-xeno-2.3.1 #16)<br>
EIP is at xnintr_edge_shirq_handler+0xda/0x2f0<br>
eax: 00000000 ebx: 00000000 ecx: f2d58074 edx: c0529080<br>
esi: c05290c0 edi: 69bfb728 ebp: 000000c9 esp: c04b9f08<br>
ds: 007b es: 007b ss: 0068<br>
I-pipe domain Xenomai<br>
Process modprobe (pid: 1876, ti=f7a44000 task=f7d7d030 task.ti=f7a44000)<br>
Stack: c047d100 c0487400 00000001 00000001 00000001 f2d58050 c0527a10 c05293f8 <br>
00000004 c04fbc38 c051d100 00000004 00000000 c0143fa8 00000000 c047d100 <br>
c051d100 c04fbc38 00000000 00000004 c0527400 c0112de2 c03bc88a 00000000 <br>
Call Trace:<br>
__ipipe_dispatch_wired+0xdB/0x120<br>
__ipipe_handle_irq+0x72/0x2b0<br>
schedule+0x41a/0x880<br>
common_interrupt+0x21/0x38<br>
mwait_idle_with_hints+0x3f/0x50<br>
mwait_idle+0x0/0x10<br>
cpu_idle+0x6f/0x90<br>
start_kernel+0x1d0/0x240<br>
unknown_bootoption+0x0/0x190 <br>
=======================<br>
Code: 03 00 00 89 f0 89 96 b4 03 00 00 8b 15 80 87 52 c0 29 d0 83 e8 40 c1 f8 04 69 c0 ab aa aa aa 8d 44 18 24 87 86 b8 03 00 00<br>
89 d9 &lt;ff&gt; 53 08 09 44 24 10 0f b6 d0 83 fa 02 0f 84 04 01 00 00 4a 0f <br>
EIP: xnintr_edge_shirq_handler+0xda/0x2f0 SS:ESP 0068:c04b9f08<br>
Kernel panic - not syncing: Attempted to kill the idle task!<br>
<br>
hardware:<br>
Intel Core DUO Processor Single Board Computer<br>
<br>
here follows the test application:<br>
<br>
#include &lt;sys/types.h&gt;<br>
#include &lt;sys/stat.h&gt;<br>
#include &lt;fcntl.h&gt;<br>
#include &lt;stdio.h&gt;<br>
#include &lt;string.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
<br>
#include &lt;signal.h&gt;<br>
#include &lt;sys/mman.h&gt;<br>
<br>
#include &lt;native/task.h&gt;<br>
#include &lt;native/timer.h&gt;<br>
#include &lt;rtdm/rtserial.h&gt;<br>
<br>
#define FALSE 0<br>
#define TRUE 1<br>
#define BAUDRATE B115200<br>
<br>
#define WRITE_FILE &quot;rtser0&quot;<br>
<br>
RT_TASK rt_writer_tid;<br>
int fd;<br>
<br>
static const struct rtser_config write_config = {<br>
0xFFDF, /* config_mask */<br>
115200, /* baud_rate */<br>
RTSER_DEF_PARITY, /* parity */<br>
RTSER_DEF_BITS, /* data_bits */<br>
RTSER_DEF_STOPB, /* stop_bits */<br>
RTSER_DEF_HAND, /* handshake */<br>
RTSER_DEF_FIFO_DEPTH, /* fifo_depth*/<br>
RTSER_DEF_TIMEOUT, /* rx_timeout */<br>
RTSER_DEF_TIMEOUT, /* tx_timeout */<br>
RTSER_DEF_TIMEOUT, /* event_timeout */<br>
RTSER_DEF_TIMESTAMP_HISTORY /* timestamp_history */<br>
};<br>
<br>
void rt_writer (void *cookie)<br>
{<br>
int error;<br>
int res;<br>
char* msg = &quot;abrac&quot;; <br>
error = rt_task_set_periodic(NULL,<br>
TM_NOW,<br>
rt_timer_ns2ticks(32000000));<br>
<br>
for (;;) {<br>
error = rt_task_wait_period(NULL);<br>
res = rt_dev_write(fd, msg, strlen(msg));<br>
<br>
}<br>
}<br>
<br>
<br>
void cleanup_upon_sig(int sig __attribute__((unused)))<br>
{<br>
<br>
<br>
rt_dev_close(fd);<br>
<br>
exit(0);<br>
}<br>
<br>
int main(int argc, char** argv)<br>
{<br>
int error;<br>
<br>
<br>
mlockall(MCL_CURRENT|MCL_FUTURE);<br>
<br>
signal(SIGINT, cleanup_upon_sig);<br>
signal(SIGTERM, cleanup_upon_sig);<br>
signal(SIGHUP, cleanup_upon_sig);<br>
signal(SIGALRM, cleanup_upon_sig); <br>
<br>
fd = rt_dev_open(WRITE_FILE, 0);<br>
if (fd &lt; 0) {<br>
perror(WRITE_FILE);<br>
cleanup_upon_sig(0);<br>
}<br>
error = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &amp;write_config);<br>
if (error) {<br>
printf(&quot;error while RTSER_RTIOC_SET_CONFIG, code %d\n&quot;,error);<br>
cleanup_upon_sig(0);<br>
}<br>
<br>
error = rt_task_spawn(&amp;rt_writer_tid,&quot;rt_writer&quot;,0,99,T_FPU,<br>
rt_writer, NULL);<br>
if (error) {<br>
printf(&quot;rt_task_spawn: code %d\n&quot;,error);<br>
return 2;<br>
} <br>
pause();<br>
exit(0);<br>
<br>
}<br>
<br>
<br>
Alessandro Pittaluga<br>
<br>
Alenia Aeronautica<br>
Avionic System Qualification<br>
Test Systems<br>
Corso Marche, 41<br>
10146 Torino (Italy)<br>
Phone +39-011-756.2915<br>
+39-011-996.0714<br>
Fax +39-011-756.2517</font></body></html>
--0__=4EBBF86CDFBBFC6E8f9e8a93df938690918c4EBBF86CDFBBFC6E--



