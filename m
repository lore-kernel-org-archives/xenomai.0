Message-ID: <13327.62.39.72.60.1213617847.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0806160233o1e37d876xc5210aa16ade0f70@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<2766.81.252.86.91.1211992159.squirrel@domain.hid> 
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid> 
	<16273.81.252.86.91.1212060383.squirrel@domain.hid> 
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid> 
	<13639.81.252.86.91.1212153659.squirrel@domain.hid> 
	<18496.31292.674733.417262@domain.hid> 
	<3380.62.39.72.60.1213367793.squirrel@domain.hid> 
	<2ff1a98a0806130843u17a146c5g38daf88bcd5ab7f6@domain.hid> 
	<3842.81.252.86.91.1213598456.squirrel@domain.hid>
	<2ff1a98a0806160233o1e37d876xc5210aa16ade0f70@domain.hid>
Date: Mon, 16 Jun 2008 14:04:07 +0200 (CEST)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with time-out ends
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
Cc: xenomai@xenomai.org, Fabien MAHOT <fabien.mahot@domain.hid>

> On Mon, Jun 16, 2008 at 8:40 AM, Fabien MAHOT
> <fabien.mahot@domain.hid> wrote:
>> Hello,
>>
>> I enabled debug traces for rtc drivers.
>
> This will not help. What you need to enable are the "frame pointers",
> in the kernel configuration, menu kernel hacking, enable "Kernel
> debugging", then enable frame pointers.
>
> --
>  Gilles
>

Sorry, I didn t understand...

I enable frame pointers:

#############################################################
Debug traces :

TimeOutEnd thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutEnd thread
threadTimeOutEnd thread : before sem_wait
TimeOut thread
0 : Start of time out 1 - 500ms
Display thread
1 : Start of time out 2 - 500ms
2 : Start of time out 3 - 500ms
3 : Start of time out 4 - 500ms
4 : Start of time out 5 - 500ms

...

0 : Start of time out 41 - 500ms
1 : Start of time out 42 - 500ms
2 : Start of time out 43 - 500ms
3 : Start of time out 44 - 500ms
Number of time-outs ends : 0
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut thread : bTimeOutEnd : 1
Number of time-outs ends : 1
TimeOut40 ends
4 : Start of time out 45 - 500ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
threadTimeOutEnd thread : after sem_wait
TimeOut thread : bTimeOutEnd : 1
threadTimeOutEnd thread : before sem_wait
Number of time-outs ends : 2
TimeOut41 ends
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut42 ends
0 : Start of time out 46 - 500ms
1 : Start of time out 47 - 500ms
Number of time-outs ends : 2
TimeOut43 ends
TimeOut44 ends
2 : Start of time out 48 - 500ms
3 : Start of time out 49 - 500ms
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut thread : bTimeOutEnd : 1
Number of time-outs ends : 1
TimeOut45 ends
4 : Start of time out 50 - 500ms
Display thread :92353

#############################################################
kernel traces :

c7397e60 00000086 c70e1220 00300182 c70e1a20 ffffffff 00000001 c7397ee8
c71f9400 c7397ef0 00300182 c70e1a20 ffffffff 00000001 c70e1c78 c70e10a0
00000102 c71f9400 00000033 c7074b90 c70375d0 c7074b90 c71d01e0 c70bbf98
Call Trace:
 [<c0142985>] ? xnpod_schedule+0x3c5/0x10f0
 [<c0144233>] xnpod_suspend_thread+0x413/0x490
 [<c014de14>] ? schedule_event+0x184/0x880
 [<c0106ea4>] ? native_sched_clock+0x64/0xb0
 [<c0110132>] ? __update_rq_clock+0x22/0x130
 [<c0149df2>] xnsynch_sleep_on+0x8f2/0xd20
 [<c0152f2c>] pse51_mutex_timedlock_break+0x1ec/0x210
 [<c016190e>] __pthread_mutex_lock+0x4e/0x60
 [<c013bd02>] ? __ipipe_restore_root+0x22/0x30
 [<c014f337>] losyscall_event+0xb7/0x170
 [<c014f280>] ? losyscall_event+0x0/0x170
 [<c013c45c>] __ipipe_dispatch_event+0x9c/0x170
 [<c010c811>] __ipipe_syscall_root+0x41/0x100
 [<c0102ea9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Xenomai: fatal: Hardened thread threadTimeOut[2934] running in Linux
domain?! (status=3D0x300182, sig=3D1, prev=3Dgatekeeper/0[148])
 CPU  PID    PRI      TIMEOUT  STAT      NAME
>  0  0       80      0        00500080  ROOT
   0  2931     0      0        00300380  testTimer12_cor
   0  2933    85      0        00300182  threadTimeOutEnd
   0  2934    80      0        00300182  threadTimeOut
   0  2935    80      0        00300380  threadDisplay
Master time base: clock=3D187444262538

c70bbeb0 00000000 00000000 00000001 c70bbed8 c01041e7 00000000 c0440251
00000b76 c70e1dec c70bbf3c c014e03e c043a6a0 c70c0000 00000b76 00300182
00000001 c70377ac 00000094 000000b1 00000094 c7074b90 00000086 c70e1220
Call Trace:
 [<c01041e7>] ? show_stack+0x37/0x50
 [<c014e03e>] ? schedule_event+0x3ae/0x880
 [<c0142bba>] ? xnpod_schedule+0x5fa/0x10f0
 [<c0106ea4>] ? native_sched_clock+0x64/0xb0
 [<c014dc90>] ? schedule_event+0x0/0x880
 [<c013c45c>] ? __ipipe_dispatch_event+0x9c/0x170
 [<c03da5d6>] ? schedule+0x226/0x3b0
 [<c013bafa>] ? __ipipe_walk_pipeline+0x6a/0xa0
 [<c014faed>] ? gatekeeper_thread+0xad/0x140
 [<c01117c0>] ? default_wake_function+0x0/0x10
 [<c014fa40>] ? gatekeeper_thread+0x0/0x140
 [<c0127ca2>] ? kthread+0x42/0x70
 [<c0127c60>] ? kthread+0x0/0x70
 [<c01032c7>] ? kernel_thread_helper+0x7/0x10
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




