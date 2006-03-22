From: Marco Jackel <ich@domain.hid>
Date: Wed, 22 Mar 2006 16:46:21 +0100
Message-ID: <dvrrgc$g2a$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] read data from serial device
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

Hi there,

ATTENTION: I'm a xenomai-newbie
I want to read data from the serial device

I got the serial driver loop demo from
http://www.captain.at/xenomai-serial-port-example.php
It worked without any problems.
Then I modified the demo to read data only (remove all the write_task
stuff).

But I get this error when I do a "echo 123 > /dev/ttyS0" on a other
computer connected with a serial cable.

> voyage:/usr/src/tests/getserial# ./getserial
> rt_serial_uprog: PRESS CTRL-C to EXIT
> rt_serial_uprog: timer started
> rt_serial_uprog: rtser_file opened
> rt_serial_uprog: serial-port-config written
> rt_serial_uprog: read-task created
> rt_serial_uprog: starting read-task
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (1 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (2 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (3 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (4 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (5 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (6 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (7 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (8 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (9 times)
> rt_serial_uprog: rtser0 (rtser) -> EAGAIN (10 times)
> rt_serial_uprog: delete write_task
> rt_serial_uprog: stop timer
> rt_serial_uprog: exit

and:

> Mar 22 15:02:46 voyage kernel: 00000000
> Mar 22 15:02:46 voyage kernel: PREEMPT
> Mar 22 15:02:46 voyage kernel: Modules linked in: xeno_16550A xeno_rtdm ohci_hcd usbcore sis900 mii dm_mod
> Mar 22 15:02:46 voyage kernel: CPU:    0
> Mar 22 15:02:46 voyage kernel: EIP:    0060:[<00000000>]    Not tainted VLI
> Mar 22 15:02:46 voyage kernel: EFLAGS: 00010002   (2.6.15.4-gx1-25)
> Mar 22 15:02:46 voyage kernel: EIP is at _stext+0x3feffdc0/0xb4
> Mar 22 15:02:46 voyage kernel: eax: c0316b80   ebx: c03168e0   ecx: c03173a0   edx: c03168e0
> Mar 22 15:02:46 voyage kernel: esi: 00000004   edi: c03168e8   ebp: c03173d0   esp: cdc8ddd4
> Mar 22 15:02:46 voyage kernel: ds: 007b   es: 007b   ss: 0068
> Mar 22 15:02:46 voyage kernel: Process read_task (pid: 1320, threadinfo=cdc8c000 task=ce951a50)
> Mar 22 15:02:46 voyage kernel: Stack: c010c6ad 00000004 00000000 cffdf2fa 00000048 c03173e0 00000000 c03168e0
> Mar 22 15:02:46 voyage kernel:        ffffffff 00000001 00000000 00000002 c03168e0 c03168e0 00000046 c012f6fe
> Mar 22 15:02:46 voyage kernel:        018f7a35 00000048 00000000 00000000 ffffffd5 ce84a110 d0054c07 c02482c6
> Mar 22 15:02:46 voyage kernel: Call Trace:
> Mar 22 15:02:46 voyage kernel:  [__ipipe_sync_stage+468/606] __ipipe_sync_stage+0x1d4/0x25e
> Mar 22 15:02:46 voyage kernel:  [ipipe_unstall_pipeline_from+196/238] ipipe_unstall_pipeline_from+0xc4/0xee
> Mar 22 15:02:46 voyage kernel:  [pg0+265423879/1070375936] rtdm_event_timedwait+0x167/0x171 [xeno_rtdm]
> Mar 22 15:02:46 voyage kernel:  [tcp_v4_rcv+1295/2273] tcp_v4_rcv+0x50f/0x8e1
> Mar 22 15:02:46 voyage kernel:  [pg0+265260884/1070375936] rt_16550_ioctl+0x571/0x70e [xeno_16550A]
> Mar 22 15:02:46 voyage kernel:  [xnpod_announce_tick+83/164] xnpod_announce_tick+0x53/0xa4
> Mar 22 15:02:46 voyage kernel:  [xnintr_clock_handler+16/19] xnintr_clock_handler+0x10/0x13
> Mar 22 15:02:46 voyage kernel:  [__ipipe_sync_stage+468/606] __ipipe_sync_stage+0x1d4/0x25e
> Mar 22 15:02:46 voyage kernel:  [pg0+265416973/1070375936] rtdm_context_get+0x10d/0x116 [xeno_rtdm]
> Mar 22 15:02:46 voyage kernel:  [pg0+265418994/1070375936] _rtdm_ioctl+0x3c/0x50 [xeno_rtdm]
> Mar 22 15:02:46 voyage kernel:  [pg0+265428189/1070375936] sys_rtdm_ioctl+0x15/0x19 [xeno_rtdm]
> Mar 22 15:02:46 voyage kernel:  [hisyscall_event+521/768] hisyscall_event+0x209/0x300
> Mar 22 15:02:46 voyage kernel:  [__ipipe_dispatch_event+91/222] __ipipe_dispatch_event+0x5b/0xde
> Mar 22 15:02:46 voyage kernel:  [__ipipe_syscall_root+78/186] __ipipe_syscall_root+0x4e/0xba
> Mar 22 15:02:46 voyage kernel:  [system_call+32/65] system_call+0x20/0x41
> Mar 22 15:02:46 voyage kernel: Code:  Bad EIP value.

I think the error is in the following part:



> void read_task_proc(void *arg) {
>   int ret;
> //  RTIME irq_time   = 0;
>   ssize_t sz = sizeof(RTIME);
>   ssize_t red = 0;
>   struct rtser_event rx_event;
>   unsigned char buf[17];
> 
>   // we are in secondary mode now
>   while (1) {
>     /* switch to primary mode */
>     ret = rt_task_set_mode(0, T_PRIMARY, NULL);
>     if (ret) {
>       printf(RTASK_PREFIX "error while rt_task_set_mode, code %d\n",ret);
>       goto exit_read_task;
>     }
>     /* waiting for event */
>     // be careful not to do printf or so here. Otherwise rt_dev_ioctl
>     //    returns with an error, because we're not in hard real time
>     //    anymore (primary mode)
>     ret = rt_dev_ioctl(my_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
>     if (ret) {
>       printf(RTASK_PREFIX "error while RTSER_RTIOC_WAIT_EVENT, code %d\n",ret);
>       goto exit_read_task;
>     }
>     //irq_time = rx_event.rxpend_timestamp;
>     sz = sizeof(buf);
>     red = rt_dev_read(my_fd, &buf, sizeof(buf));
>     if (red == sz ) {
>                 printf(RTASK_PREFIX "rt_dev_read=%s\n",buf);
>     } else {
>       if (red < 0 ) {
>         printf(RTASK_PREFIX "error while rt_dev_read, code %d\n",red);
>       } else {
>         printf(RTASK_PREFIX "only %d / %d byte received \n",red,sz);
>       }
>       goto exit_read_task;
>     }
>   }
> exit_read_task:
>   if (my_state & STATE_FILE_OPENED) {
>     if (!close_file( my_fd, READ_FILE " (rtser)")) {
>       my_state &= ~STATE_FILE_OPENED;
>     }
>   }
>   printf(RTASK_PREFIX "exit\n");
> }

When I use the kernel serial-drivers and do a "cat /dev/ttyS0" I get the
data that I sent from the other computer

Thanks Marco


