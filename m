Message-ID: <49074C83.5090209@domain.hid>
Date: Tue, 28 Oct 2008 18:31:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <3DF7E8D9-8E93-4165-9A62-F15D08CFFDE4@domain.hid>
In-Reply-To: <3DF7E8D9-8E93-4165-9A62-F15D08CFFDE4@domain.hid>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] sock_sendmsg() causes crash
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Alphan Ulusoy wrote:
> Hi all,
>=20
> I' am trying to send small UDP datagrams in a real-time system. I can't
> get a satisfactory performance when I send these packets from a
> userspace Xenomai task using sendto() call.
>=20
> That's why I tried to code a small kernel module to make some
> measurements. However; whenever
>     =95 A xenomai task
>     =95 An alarm function
>     =95 A thread created with kthread_run() form a xenomai task
> that includes the sock_sendmsg() call runs, system crashes. However, if
> a write a regular kernel module, the it works just fine...
>=20
> Below you can find the code and the crash dump.
>=20
> Does anyone have any suggestions?
>

You are misusing a co-kernel system. You may want to start from there:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-re=
v-B.pdf

You should try xenomai-help instead; the current list is for Xenomai develo=
pment
matters.

>=20
> Best regards,
>=20
> alphan
>=20
> ------- Code ---------
>=20
> #include "misc_kernel.h"
> #include "ncs_const.h"
> #include "xenomai.h"
> //TODO: Remove unnecessary includes
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/kthread.h>
>=20
> #include <linux/errno.h>
> #include <linux/types.h>
>=20
> #include <linux/netdevice.h>
> #include <linux/ip.h>
> #include <linux/in.h>
>=20
> #include <linux/delay.h>
>=20
> #define TASK_PRIO           99                           /* Highest RT
> priority */
> #define TASK_MODE         T_CPU(0)                /* Bound to CPU #0 */
> #define TASK_STKSZ          32000                       /* Stack size
> (in bytes) *  =20
> #define ALARM_PERIOD         1000000000
> #define INADDR_SEND         (unsigned long int)0xC0A80204  =20
> //192.168.2.4 in hex
> #define CONNECT_PORT     6355
>=20
>=20
> MODULE_LICENSE("GPL v2");
> MODULE_DESCRIPTION("Kernel UDP Transmission Latency & Jitter Test Module"=
);
>=20
> static RT_ALARM aid;
> static RT_TASK tid;
> static startMarkFrame currentStartMark;
> static struct socket* sock_send;
> static struct sockaddr_in addr_send;
> static struct msghdr msg;
> static struct iovec iov;
> static mm_segment_t oldfs;
>=20
> static void coordTask(void *cookie) {
>=20
>     printk("\n");
>     iov.iov_base =3D &currentStartMark;
>     iov.iov_len =3D sizeof(currentStartMark);
>    =20
>     msg.msg_flags =3D 0;
>     msg.msg_name =3D &addr_send;
>     msg.msg_namelen  =3D sizeof(struct sockaddr_in);
>     msg.msg_control =3D NULL;
>     msg.msg_controllen =3D 0;
>     msg.msg_iov =3D &iov;
>     msg.msg_iovlen =3D 1;
>     msg.msg_control =3D NULL;
>    =20
>     oldfs =3D get_fs();
>     printk("21 ");
>     set_fs(KERNEL_DS);
>     printk("22 ");
>     sock_sendmsg(sock_send,&msg,sizeof(currentStartMark));
>     printk("23 ");
>     set_fs(oldfs);
>     printk("24 ");
>    =20
>     currentStartMark.sequenceNumber++;
>     printk("25 ");
> }
>=20
> int coordInit(void) {
>    =20
>     int err;
>=20
>     printk("\nStarting Kernel UDP Transmission Test Module...\n");
>=20
>     /*                                */
>     /* Create Socket                    */
>     /*                                */  =20
>     if ((err =3D sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP,
> &sock_send)) < 0 )
>     {
>         printk("sock_create() failed with code: %d\n",err);
>         goto fail;
>     }
>     addr_send.sin_family =3D AF_INET;
>     addr_send.sin_addr.s_addr =3D htonl(INADDR_SEND);
>     addr_send.sin_port =3D htons(CONNECT_PORT);
>    =20
>     if ((err =3D sock_send->ops->connect(sock_send, (struct sockaddr
> *)&addr_send, sizeof(struct sockaddr), 0) < 0 ))
>     {
>         printk("connect() failed with code: %d \n",err);
>         goto fail;
>     }
>    =20
>=20
>     /*                                */
>     /* Initialize variables                */
>     /*                                */
>     currentStartMark.frameType =3D START_MARK_FRAME;
>     currentStartMark.sequenceNumber =3D 0x00;
>=20
>    =20
>     err =3D rt_task_create(&tid, "Kenrel UDP Task", TASK_STKSZ, TASK_PRIO,
> TASK_MODE);
>     if (err) {
>         printk("rt_task_create() failed: code %d\n", err);
>         goto fail;
>     }
>    =20
>    =20
>     rt_task_start(&tid,&coordTask,NULL);
>    =20
>=20
> fail:
>=20
>     return err;
>    =20
> }
>=20
> void coordCleanup(void) {
>     //rt_alarm_delete(&aid);
>     rt_task_delete(&tid);
>     printk("\nKernel UDP module removed!\n");
> }
>=20
> module_init(coordInit);
> module_exit(coordCleanup);
>=20
>=20
> -------- Stack trace ----------
>=20
> [  454.999957] Starting Kernel UDP Transmission Test Module...
> [  455.021232] 1 2 3 4 5 6 <3>BUG: Unhandled exception over domain
> Xenomai at 0xc0145cfe - switching to ROOT
> [  455.021484] Pid: 3643, comm: insmod Not tainted 2.6.26.5 #9
> [  455.021558]  [<c0112351>] __ipipe_handle_exception+0x1b1/0x1c0
> [  455.021644]  [<c0145cfe>] __ipipe_restore_root+0x1e/0x30
> [  455.021724]  [<c03a7633>] error_code+0x6f/0x7c
> [  455.021803]  [<c0326c96>] __alloc_skb+0x36/0x120
> [  455.021881]  [<c0145cfe>] __ipipe_restore_root+0x1e/0x30
> [  455.021960]  [<c0182795>] kmem_cache_alloc+0x55/0xd0
> [  455.022001]  [<c0326c96>] __alloc_skb+0x36/0x120
> [  455.022001]  [<c0322c08>] sock_alloc_send_skb+0x168/0x1b0
> [  455.022001]  [<c0348611>] ip_append_data+0x711/0x970
> [  455.022001]  [<c0349540>] ip_generic_getfrag+0x0/0xb0
> [  455.022001]  [<c0364730>] udp_sendmsg+0x2f0/0x660
> [  455.022001]  [<c036ab37>] inet_sendmsg+0x37/0x70
> [  455.022001]  [<c032062e>] sock_sendmsg+0xbe/0xf0
> [  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
> [  455.022001]  [<c012ef50>] autoremove_wake_function+0x0/0x50
> [  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
> [  455.022001]  [<c014bc35>] xnpod_suspend_thread+0x1f5/0x200
> [  455.022001]  [<c027e184>] vscnprintf+0x14/0x20
> [  455.022001]  [<c011cc04>] printk+0xc4/0xe0
> [  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
> [  455.022001]  [<f890b238>] coordTask+0xb8/0x104 [deneme2]
> [  455.022001]  [<c014c162>] xnarch_thread_redirect+0x32/0x50
> [  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
> [  455.022001]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [  455.022001] ------------[ cut here ]------------
> [  455.022001] kernel BUG at kernel/ipipe/core.c:323!
> [  455.022001] invalid opcode: 0000 [#1] PREEMPT
> [  455.022001] Modules linked in: deneme2(+) arc4 ecb crypto_blkcipher
> cryptomgr crypto_algapi [last unloaded: deneme2]
> [  455.022001]
> [  455.022001] Pid: 3643, comm: insmod Not tainted (2.6.26.5 #9)
> [  455.022001] EIP: 0060:[<c0145cfe>] EFLAGS: 00010202 CPU: 0
> [  455.022001] EIP is at __ipipe_restore_root+0x1e/0x30
> [  455.022001] EAX: 00000000 EBX: f74586c0 ECX: c0326c96 EDX: c0491b9c
> [  455.022001] ESI: 00000000 EDI: c0491b20 EBP: 000000c0 ESP: f7d37870
> [  455.022001]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> [  455.022001] Process insmod (pid: 3643, ti=3Df7d36000 task=3Df7f2aa20
> task.ti=3Df7512000)<0>
> [  455.022001] I-pipe domain Linux
> [  455.022001] Stack: c0182795 00000000 00000000 000004d0 00000200
> 00000000 0000003d 000004d0
> [  455.022001]        c0491b20 c0326c96 00000000 f7c3ea00 7fffffff
> 0000000a 000004d0 c0322c08
> [  455.022001]        ffffffff 0000003d 00000000 00000000 f74fa700
> 00000000 00000000 f74fa700
> [  455.022001] Call Trace:
> [  455.022001]  [<c0182795>] kmem_cache_alloc+0x55/0xd0
> [  455.022001]  [<c0326c96>] __alloc_skb+0x36/0x120
> [  455.022001]  [<c0322c08>] sock_alloc_send_skb+0x168/0x1b0
> [  455.022001]  [<c0348611>] ip_append_data+0x711/0x970
> [  455.022001]  [<c0349540>] ip_generic_getfrag+0x0/0xb0
> [  455.022001]  [<c0364730>] udp_sendmsg+0x2f0/0x660
> [  455.022001]  [<c036ab37>] inet_sendmsg+0x37/0x70
> [  455.022001]  [<c032062e>] sock_sendmsg+0xbe/0xf0
> [  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
> [  455.022001]  [<c012ef50>] autoremove_wake_function+0x0/0x50
> [  455.022001]  [<c0150260>] xntimer_start_aperiodic+0x0/0x200
> [  455.022001]  [<c014bc35>] xnpod_suspend_thread+0x1f5/0x200
> [  455.022001]  [<c027e184>] vscnprintf+0x14/0x20
> [  455.022001]  [<c011cc04>] printk+0xc4/0xe0
> [  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
> [  455.022001]  [<f890b238>] coordTask+0xb8/0x104 [deneme2]
> [  455.022001]  [<c014c162>] xnarch_thread_redirect+0x32/0x50
> [  455.022001]  [<f890b180>] coordTask+0x0/0x104 [deneme2]
> [  455.022001]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [  455.022001] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 81 3d 20 e8
> 45 c0 c0 0a 55 c0 75 12 85 c0 74 09 0f ba 2d c0 d4 45 c0 00 c3 e9 a2 ff
> ff ff <0f> 0b eb fe 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 89 c1 8b
> [  455.022001] EIP: [<c0145cfe>] __ipipe_restore_root+0x1e/0x30 SS:ESP
> 0068:f7d37870
> [  455.022001] ---[ end trace 415d3c300348194e ]---
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20
Philippe.

