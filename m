MIME-Version: 1.0
In-Reply-To: <49E0F949.5040900@domain.hid>
References: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>
	<49E0F949.5040900@domain.hid>
Date: Thu, 16 Apr 2009 01:13:56 +0200
Message-ID: <d6c8ef150904151613j39f43928xd1a25f37184ad30b@domain.hid>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intel EP80579 support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi!

I manged to boot my Tolapai with 2.6.28.8 Linux kernel and Xenomai
2.4.7. Rootfs is based on buildroot, meaning uclibc. I've compiled
Xenomai libs and my app by uclibc toolchain. Xenomai is built without
--enable-x86-sep.

First test, to create & start RT task (from user space) passed ok.
But, second one, enabling an interrupt failed. Here is the output,
followed by test code. What am I doing wrong? :)

# ./user_irq
Task created!
BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<00000000>] 0x0
*pde = 00000000
Oops: 0000 [#1]
last sysfs file:
Modules linked in:

Pid: 655, comm: user_irq Not tainted (2.6.28.8-ipipe #8) Intel Tolapai
Based Board
EIP: 0060:[<00000000>] EFLAGS: 00010206 CPU: 0
EIP is at 0x0
EAX: 00000026 EBX: fffffffd ECX: 00000026 EDX: c06ebf80
ESI: 00000000 EDI: c06edf20 EBP: 00000000 ESP: df043f2c
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process user_irq (pid: 655, ti=df043000 task=df1a8960 task.ti=df043000)
I-pipe domain Linux
Stack:
 c05b4a2c c044ded9 fffffffd df043fb8 c0447fe4 00000001 00000000 c0441ba7
 00000000 c06edf20 df1a8960 00000001 00000280 00000000 00000000 00000002
 c07b2204 c07b2200 c043841e df043fb8 00000021 c07a6f00 c0441a67 c07a6f04
Call Trace:
 [<c05b4a2c>] rthal_irq_enable+0x26/0x29
 [<c044ded9>] rt_intr_enable+0x28/0x49
 [<c0447fe4>] __rt_intr_enable+0x34/0x3b
 [<c0441ba7>] hisyscall_event+0x140/0x24a
 [<c043841e>] __ipipe_dispatch_event+0x96/0x14e
 [<c0441a67>] hisyscall_event+0x0/0x24a
 [<c041083e>] __ipipe_syscall_root+0x44/0x96
 [<c0403693>] system_call+0x2b/0x4c
Code:  Bad EIP value.
EIP: [<00000000>] 0x0 SS:ESP 0068:df043f2c
---[ end trace e8aec4c9df299570 ]---
Segmentation fault

Code:
#define IRQ_NUMBER 38
#define TASK_PRIO  50
#define TASK_MODE  T_JOINABLE
#define TASK_STKSZ 0

RT_INTR intr_desc;
RT_TASK task_desc;

void irq_server (void *cookie)
{
int err, counter=0;

    for (;;counter++) {
      rt_task_set_mode(0, T_PRIMARY, NULL);
      err = rt_intr_wait(&intr_desc,TM_INFINITE);

      if (err > 0) {
           printf ("Interrupt received %d!!\n", counter);
       } else {
           printf ("rt_intr_wait(): %d\n", err);
       }
       rt_intr_enable (&intr_desc);
    }
}

int main (int argc, char *argv[])
{
    int err;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err = rt_intr_create(&intr_desc, "MyIrq", 38, I_NOAUTOENA);

    if (err) {
      printf ("rt_intr_create: %d\n", err);
      return 0;
    }

    err = rt_task_create(&task_desc, "MyIrqServer", TASK_STKSZ,
TASK_PRIO, TASK_MODE);
    printf ("Task created!\n");

    rt_intr_enable (&intr_desc);
    printf ("Interrupt enabled!\n");

    if (!err)
      rt_task_start(&task_desc,&irq_server,NULL);
    else
      printf ("rt_intr_create: %d\n", err);

    printf ("user_irq [%d]: started.\n", getpid());
    if (rt_task_join (&task_desc)) {
      printf ("Error joining task\n");
    }
    return 0;
}

--
Bosko

