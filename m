From: Ando Yuta <andouyuuta@yamaha-motor.co.jp>
Subject: Trying Xenomai3.2 and has some web browser problem
Date: Wed, 10 Nov 2021 06:33:00 +0000
Message-ID: <TY2PR04MB3838919175C4210652E4FCD4AA939@TY2PR04MB3838.apcprd04.prod.outlook.com>
Content-Language: ja-JP
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

We are now testing xenomai3.2 with dovetail core(kernel ver5.10.70)
The kernel build was successful with some modifications to the ipipe config=
uration we had been using.
Building our application was also successful without any problems, just by =
slightly changing the flags in cmake.
So our application is working well, except for one thing.

When using xenomai 3.1 with ipipe patch 5.4.77, there was no problem,
but when using 5.10.70 dovetail, the web browser started to crash.

Firefox didn't work at all.
When using Google Chrome and chromium, some pages don't crash and some,
in particular, video sites like youtube and sites that require login such a=
s github did.

Attached below are the results of strace when using chrome.
The problem seems to be around seccomp.

If we follow this web(https://chromium.googlesource.com/chromium/src/+/refs=
/heads/main/docs/linux/sandboxing.md)
and specify --disable-seccomp-filter-sandbox, the crash was apparently avoi=
ded.
However, this option disables sandbox, which causes a security problem.
Therefore, we do not want to disable sandbox if possible.

This browser crash does not occur on the same 5.10.70 kernel unless we enab=
le the dovetail realtime kernel, so
It seems to be an issue with a system call related to dovetail's seccomp.
Is there any way to solve this problem?

The strace results are as follows


set_robust_list(0x7f81172e19e0, 24) =3D 0
gettid() =3D 17
stat("/sys/fs/cgroup/cpuset/chrome", 0x7f81172e07c0) =3D -1 ENOSYS (Functio=
n not implemented)
setpriority(PRIO_PROCESS, 0, 0) =3D 0
getpid() =3D 1
prctl(PR_SET_NAME, "ServiceWorker t"...) =3D 0
mmap(0x196a00000000, 4294967296, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x196a00000000
mprotect(0x196a00000000, 4096, PROT_READ|PROT_WRITE) =3D 0
sched_getaffinity(17, 32, <unfinished ...>
--- SIGSYS {si_signo=3DSIGSYS, si_code=3DSYS_SECCOMP, si_errno=3DENXIO, si_=
call_addr=3D0x7f8131c01c33, si_syscall=3D__NR_sched_getaffinity, si_arch=3D=
AUDIT_ARCH_X86_64} ---
0x3ed603ae9440) =3D -1 ENOSYS (Function not implemented)
write(2, "Sanity checks are failing after "..., 49) =3D -1 ENOSYS (Function=
 not implemented)
write(2, "\n", 1) =3D -1 ENOSYS (Function not implemented)
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) =3D -1 ENOSYS (Function not im=
plemented)
rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], 0x7f81172df6e0, 8) =3D -1 ENOSYS (=
Function not implemented)
getpid() =3D -38
gettid() =3D -38
tgkill(1, 17, SIGABRT) =3D -1 ENOSYS (Function not implemented)
rt_sigprocmask(SIG_SETMASK, [], <unfinished ...>
--- SIGABRT {si_signo=3DSIGABRT, si_code=3DSI_TKILL, si_pid=3D1, si_uid=3D1=
000} ---
NULL, 8) =3D -1 ENOSYS (Function not implemented)
gettid() =3D -38
prctl(PR_GET_DUMPABLE) =3D -1 ENOSYS (Function not implemented)
rt_sigprocmask(SIG_BLOCK, [CONT], 0x7f81172de810, 8) =3D -1 ENOSYS (Functio=
n not implemented)
sendmsg(18, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_base=3D"\1\0=
\0\0\1\0\0\0\10\351-\27\201\177\0\0\10\246\32\0\326>\0\0\0\0\0\0\0\0\0\0"..=
., iov_len=3D40}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3D0}, MSG_=
NOSIGNAL) =3D -1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigtimedwait([CONT], 0x7f81172de820, {tv_sec=3D5, tv_nsec=3D0}, 8) =3D -=
1 ENOSYS (Function not implemented)
rt_sigprocmask(SIG_SETMASK, [ABRT], NULL, 8) =3D -1 ENOSYS (Function not im=
plemented)
rt_sigaction(SIGABRT, {sa_handler=3D0x56013b2b5688, sa_mask=3D[], sa_flags=
=3DSA_RESTORER, sa_restorer=3D0x7f8131c01980}, NULL, 8) =3D -1 ENOSYS (Func=
tion not implemented)
rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], 0x7f81172de810, 8) =3D -1 ENOSYS (=
Function not implemented)
getpid() =3D -38
gettid() =3D -38
tgkill(1, 17, SIGABRT) =3D -1 ENOSYS (Function not implemented)
rt_sigprocmask(SIG_SETMASK, [ABRT], NULL, 8) =3D -1 ENOSYS (Function not im=
plemented)
syscall_0xffffffffffffffff(0x2, 0x7f81172df6e0, 0, 0x8, 0, 0x7f81172df6e0 <=
unfinished ...>
--- SIGABRT {si_signo=3DSIGABRT, si_code=3DSI_TKILL, si_pid=3D1, si_uid=3D1=
000} ---
) =3D -1 (errno 38)
+++ exited with 250 +++

Yuta Ando
