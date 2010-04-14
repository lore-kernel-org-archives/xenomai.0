MIME-Version: 1.0
From: Luc ANTOLINOS <luciogistr@domain.hid>
Date: Wed, 14 Apr 2010 12:55:11 +0200
Message-ID: <g2u132366a01004140355v13765a3hcd5940f489b25dba@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] prepare_kernel.sh for PowerPC
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

Hi,
(Xenomai 2.5.2, Linux 2.6.33, PowerPC)
I noticed the following behaviour in the prepare_kernel.sh script.
When using target name "powerpc" all is fine, but when using "ppc" the
script hangs after patching all files.
Strace indicate the script hangs waiting for an entry (probably a file
not found and a grep or other tool wait on the stdin). Strace output
is at the end of this email.

Is ppc a correct target name ? In the prepare_kernel.sh script the
variable $linux_arch seams to have a different value when using ppc.
arch/ppc directory does not exists in Linux 2.6.33 sources.
   ppc|ppc32)
      linux_arch=ppc
      xenomai_arch=powerpc
      ;;
   ppc64|powerpc64)
      linux_arch=ppc64
      xenomai_arch=powerpc
      ;;
   powerpc)
      linux_arch=powerpc
      xenomai_arch=powerpc
      ;;




Strace output :
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file mm/memory.c
patching file mm/mmu_context.c
patching file mm/vmalloc.c
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 9764
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbfdb3f38, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x807ef30, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb7df76f8) = 9765
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x807ef30, [], 0}, {SIG_DFL}, 8) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 9765
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbfdb4598, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x807ef30, [], 0}, 8) = 0
stat64("/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/src", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
stat64("/usr/src/xenomai-2.5.2", {st_mode=S_IFDIR|S_ISGID|0777,
st_size=4096, ...}) = 0
stat64("/usr/src/xenomai-2.5.2/scripts",
{st_mode=S_IFDIR|S_ISGID|0777, st_size=4096, ...}) = 0
chdir("/usr/src/xenomai-2.5.2/scripts") = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nasm_ipipe_h=unknown\nif test -r $"..., 8176) = 4781
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/usr/src/linux-2.6.33/arch/ppc/include/asm/ipipe.h",
0xbfdb4a8c) = -1 ENOENT (No such file or directory)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -4365, [11554], SEEK_CUR)  = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb7df76f8) = 9766
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x807e320, [], 0}, {0x807e320, [], 0}, 8) = 0
close(4)                                = 0
read(3, ""..., 128)                     = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x807ef30, [], 0}, {SIG_DFL}, 8) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 9766
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xbfdb44f8, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x807ef30, [], 0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nadeos_version=`grep '^#define.*I"..., 8176) = 4365
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -4249, [11670], SEEK_CUR)  = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb7df76f8) = 9769
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x807e320, [], 0}, {0x807e320, [], 0}, 8) = 0
close(4)                                = 0
read(3,


-- 
Luc

