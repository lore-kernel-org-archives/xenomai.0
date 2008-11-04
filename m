Date: Tue, 4 Nov 2008 14:22:27 +0100
From: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Message-ID: <20081104132227.GA25486@domain.hid>
References: <20081030094458.GA13464@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20081030094458.GA13464@domain.hid>
Subject: Re: [Xenomai-help] RTDM driver hangs
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
Cc: jagredondo@domain.hid


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 30/10/08 10:44, Juan Antonio Garcia Redondo wrote:
> Hi all,
> 
> My application hangs when receive the signal SIGINT(CTRL-C) or SIGTERM. I've activated the
> debug flags related to xenomai plus ipipe, and the console shows the
> following:
> 
> <3>Xenomai: fatal: inserting element twice, holder=c3ce0a18, qslot=bf002dfc at include/xenomai/nucleus/queue.h:321
> <4> CPU  PID    PRI      TIMEOUT  STAT      NAME
> <4>   0  0       -1      0        00500088  ROOT
> <4>   0  0        1      5140450  00000084  rtdm_task
> <4>   0  1676     1      95406250 00300186  test_rtdm-1676
> <4>>  0  1694     1      0        00300180  test_rtdm-1694
> <4>Master time base: clock=428928724
> <4>[<c002a828>] (show_stack+0x0/0x48) from [<c00750a0>] (xnsynch_sleep_on+0xd7c/0xf1c)
> <4>[<c0074324>] (xnsynch_sleep_on+0x0/0xf1c) from [<c00afb14>] (rtdm_mutex_timedlock+0x124/0x184)
> <4>[<c00af9f0>] (rtdm_mutex_timedlock+0x0/0x184) from [<c00afb90>] (rtdm_mutex_lock+0x1c/0x20)
> <4>[<c00afb74>] (rtdm_mutex_lock+0x0/0x20) from [<bf0020d0>] (rtdm_test_ioctl+0x20/0x164 [rtdm_drv_01])
> <4>[<bf0020b0>] (rtdm_test_ioctl+0x0/0x164 [rtdm_drv_01]) from [<c00ae260>] (__rt_dev_ioctl+0x60/0x178)
> <4> r7:c3ce1010 r6:c3c1e660 r5:fffffff7 r4:00000000
> <4>[<c00ae200>] (__rt_dev_ioctl+0x0/0x178) from [<c00b00ec>] (sys_rtdm_ioctl+0x2c/0x30)
> <4> r3:00000000 r2:0000f301
> <4> r8:00000000 r7:c3ce0620 r6:00000003 r5:c3e6ffb0 r4:00000050
> <4>[<c00b00c0>] (sys_rtdm_ioctl+0x0/0x30) from [<c007c29c>] (hisyscall_event+0x14c/0x278)
> <4>[<c007c150>] (hisyscall_event+0x0/0x278) from [<c0066d7c>] (__ipipe_dispatch_event+0xd0/0x1c8)
> <4>[<c0066cac>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002b6a0>] (__ipipe_syscall_root+0x80/0x100)
> <4>[<c002b620>] (__ipipe_syscall_root+0x0/0x100) from [<c0026c68>]
> (vector_swi+0x68/0xa8)
> 
> Environment:
>         AT9260 based board.
>         xenomai-2.4.5
>         kernel 2.6.25
>         User app + rtdm driver.
> 
> I've attached an example which reproduces the problem.
> 
> To reproduce:
> 	# insmod rtdm_drv_01.ko
> 	# ./test_rtdm 10000000 &
> 	# ./test_rtdm 10000000 &
> 
> and now kill one of them. The crash doesn't occurs everytime but is easy
> to reproduce it after several tries.
> 
> The appliccation just send a lot of dummy ioctl to the rtdm driver. The driver
> launchs a periodic real time task which is in charge of wakeup the
> process which is waiting on the ioctl. To avoid concurrent access (I'm
> simulating the real app) to the ioctl commands there is a mutex which is
> locked at the begin of the ioctl function and released at the end of the
> ioctl function.
> 
> Any hints ?
> 
> Regards,
>         Juan Antonio
> 


Hi all,

I've been invetigating further the problem and I've found that the
crash occurs in the following situation (now just one process using a
rtdm driver):

o A real time process call to rtdm_ioctl function.
o The rtdm_ioctl function blocks at rtdm_task_sleep (or any other blocking
system call).
o Arrive a signal which switch the process to executable state. The
blocking system call returns -EINTR.
o Whithout exit the RTDM driver, call to another blocking system call
(rtdm_task_timedwait for instance). This system call returns -EINTR and the
rtdm_ioctl function retuns -EINTR.
o Although the caller process is testing the return value the rtdm_ioctl
executes again, and then the crassh appears.

The relate process code (the signal SIGTERM and SIGINT are trapped to
change the variable to_close to 1).

        while((to_close == 0) && (loops < max_loops)) {
                rt_printf("[%d]Ioctl(user) START\n", loops);
                ret = rt_dev_ioctl(fd, RTDM_TEST_WRITE, 0);
                rt_printf("[%d]Ioctl(user) END ret %d\n", loops, ret);
                if (ret < 0) {
                        rt_printf("%s: ERROR: rt_dev_ioctl: %d\n", program_name, ret);
                        break;
                }
                loops ++;
                rt_printf("%s: Num. loops %d\n", program_name, loops);
                rt_task_sleep(1 * NSEC_PER_MSEC);
        }

        rt_printf("[%d] Exit Task\n", loops);

And the related driver code:

static int rtdm_test_ioctl (struct rtdm_dev_context *context, 
                            rtdm_user_info_t *user_info, 
                            unsigned int cmd, 
                            void __user *arg)
{
        ........................

        case RTDM_TEST_WRITE: {
                if (sleep_before) {
                        printk("[%d]%s Sleeping ...\n", 
                               loops, MODULE_NAME);
                        ret = rtdm_task_sleep((sleep_before == -1) ? 
                                              RTDM_TIMEOUT_INFINITE:
                                              sleep_before * NSEC_PER_MSEC);
                        if (ret < 0) {
                                printk("[%d]%s: Error rtdm_task_sleep %d\n", 
                                       loops, 
                                       MODULE_NAME,
                                       ret);
                                if (ret != -EINTR) {
                                        goto exit_ioctl;
                                }
                                else if (ignore_eintr == 0) {
                                        goto exit_ioctl;
                                }
                        } else {
                                printk("[%d]%s Wakeup\n", loops, MODULE_NAME);
                        }
                }
                rtdm_test.waiting ++;
                printk("[%d]%s timedwait ...\n", 
                       loops, MODULE_NAME);
                ret = rtdm_event_timedwait(&rtdm_test.event,
                                           RTDM_TIMEOUT_INFINITE,
                                           NULL);
                printk("[%d]%s timedwait wakeup\n", 
                       loops, MODULE_NAME);
                rtdm_test.waiting --;
                if (ret < 0) {
                        printk("[%d]%s rtdm_event_timedwait: error %d\n", 
                               loops, MODULE_NAME, ret);
                        break;
                }
                break;
        }
        default:
                printk("%s Unsupported ioctl %d\n", MODULE_NAME, cmd);
                break;
        }

exit_ioctl:
        if (ret) {
                printk("[%d]%s ret->%d\n", loops, MODULE_NAME, ret);
        }
        loops ++;
        return ret;
}

The traces:

[0]Ioctl(user) START
[0]rtdm_drv Sleeping ...
[0]rtdm_drv: Error rtdm_task_sleep -4
[0]rtdm_drv timedwait ...
[0]rtdm_drv timedwait wakeup
[0]rtdm_drv rtdm_event_timedwait: error -4
[0]rtdm_drv ret->-4     (*)
[1]rtdm_drv Sleeping ...



(*) After that, the process doesn't receive the -EINTR error neither show
the trace "[0]Ioctl (user) END ret..."

And the crash:

Xenomai: fatal: inserting element twice, holder=c4801810, qslot=bf006f78 at include/xenomai/nucleus/queue.h:321
 CPU  PID    PRI      TIMEOUT  STAT      NAME
   0  0        1      0        00500088  ROOT
   0  0        1      464041433 00000084  rtdm_task
   0  1664     1      0        00300380  test_rtdm-1664
>  0  1667    10      0        00300180  task_ioctl
Master time base: clock=313085528

[<c002ade4>] (show_stack+0x0/0x48) from [<c0073b84>] (xnsynch_sleep_on+0x4c8/0x1108)
[<c00736bc>] (xnsynch_sleep_on+0x0/0x1108) from [<c00b1898>] (rtdm_event_timedwait+0x104/0x190)
[<c00b1794>] (rtdm_event_timedwait+0x0/0x190) from [<bf0061f4>] (rtdm_test_ioctl+0x144/0x208 [rtdm_drv_02])
[<bf0060b0>] (rtdm_test_ioctl+0x0/0x208 [rtdm_drv_02]) from [<c00b034c>] (__rt_dev_ioctl+0x60/0x170)
 r6:c3c63120 r5:fffffff7 r4:00000000
[<c00b02ec>] (__rt_dev_ioctl+0x0/0x170) from [<c00b23e4>] (sys_rtdm_ioctl+0x20/0x24)
 r3:00000000 r2:0000f301
 r8:00000020 r7:00000001 r6:c3e30000 r5:c3e31fb0 r4:00000013
[<c00b23c4>] (sys_rtdm_ioctl+0x0/0x24) from [<c007c1b4>] (losyscall_event+0xb4/0x1a0)
[<c007c100>] (losyscall_event+0x0/0x1a0) from [<c0065138>] (__ipipe_dispatch_event+0xd0/0x1c8)
[<c0065068>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002bc5c>] (__ipipe_syscall_root+0x80/0x100)
[<c002bbdc>] (__ipipe_syscall_root+0x0/0x100) from [<c0027108>]
(vector_swi+0x68/0xa8)

Attached the complete code.

Regards,
        Juan Antonio



--UugvWAfsgieZRqgk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="test_rtdm_01.bz2"
Content-Transfer-Encoding: base64

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
JDqcB2pdvlhraVg7YD/xdyRThQkJO8eEMA==

--UugvWAfsgieZRqgk--

