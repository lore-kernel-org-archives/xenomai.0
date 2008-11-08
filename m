Message-ID: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>
Date: Sat, 8 Nov 2008 18:03:59 +0200
From: "Cristian Axenie" <cristian.axenie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_37726_19581649.1226160239702"
Subject: [Xenomai-help] SegFault on all demo apps!!
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

------=_Part_37726_19581649.1226160239702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!
I've installed Xenomai for a 2.6.24 linux kernel, for a PPC development
board. My intentions are to use a NI DAQ card for a distributed control
application using RTAI skin + Comedi. So I experience some trouble after
installing Xenomai and even running specific latency , switchtest...etc or
even cmd_read, cmd_write apps because I get a Segmentation Fault each time.
So during my kernel booting i get :

I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
I-pipe: Domain IShield registered.
Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting RTAI emulator.

So  I think it's ok, but I,ve copied my generated xenomai dir (including :
bin include lib sbin share) and dev directory in my filesystem located on a
SATA hard-drive conected to my board. Am I missing something in the
installation steps ? Here are the main staps used for the installation :

/home/haustiq/development/xenomai-comedi-trunk/scripts/prepare-kernel.sh
--arch=powerpc \

--adeos=/home/haustiq/development/xenomai-comedi-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch
\
  --linux=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24

cd /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24

mkdir staging_dir build_root

make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root menuconfig

  make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root uImage modules

  cd build_root

  /home/haustiq/development/xenomai-comedi-trunk/configure
--prefix=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir
--build=i686-pc-linux-gnu --host=ppc-unknown-linux-gnu CC=ppc_6xx-gcc
CXX=ppc_6xx-g++ LD=ppc_6xx-ld

  make ARCH=powerpc CROSS_COMPILE=ppc_6xx-
DESTDIR=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir
install

In staging_dir I have my genrated xenomai and dev folders copied in my FS .

So when runnig for example strace ./latency on my target I get :

/usr/xenomai/bin # strace ./latency
execve("./latency", ["./latency"], [/* 8 vars */]) = 0
brk(0)                                  = 0x10045000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/tls/ppc603/libnative.so.3", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/xenomai/lib/tls/ppc603", 0xbff80268) = -1 ENOENT (No such file
or directory)
open("/usr/xenomai/lib/tls/libnative.so.3", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/xenomai/lib/tls", 0xbff80268) = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/ppc603/libnative.so.3", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/xenomai/lib/ppc603", 0xbff80268) = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/libnative.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\000"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=60116, ...}) = 0
mmap(0xffa7000, 298328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xffa7000
mprotect(0xffb0000, 258048, PROT_NONE)  = 0
mmap(0xffef000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xffef000
close(3)                                = 0
open("/usr/xenomai/lib/librtdm.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\30"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=18181, ...}) = 0
mmap(0xff54000, 272960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xff54000
mprotect(0xff57000, 258048, PROT_NONE)  = 0
mmap(0xff96000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xff96000
close(3)                                = 0
open("/usr/xenomai/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/tls/ppc603/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/lib/tls/ppc603", 0xbff80228)   = -1 ENOENT (No such file or
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/tls", 0xbff80228)          = -1 ENOENT (No such file or
directory)
open("/lib/ppc603/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/ppc603", 0xbff80228)       = -1 ENOENT (No such file or
directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0M\330"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=130162, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4801f000
mmap(0xfeec000, 358004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xfeec000
mprotect(0xff00000, 262144, PROT_NONE)  = 0
mmap(0xff40000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xff40000
mmap(0xff42000, 5748, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff42000
close(3)                                = 0
open("/usr/xenomai/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\337"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=735452, ...}) = 0
mmap(0xfe25000, 747536, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xfe25000
mprotect(0xfec8000, 61440, PROT_NONE)   = 0
mmap(0xfed7000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa2000) = 0xfed7000
close(3)                                = 0
open("/usr/xenomai/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\361"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1537981, ...}) = 0
mmap(0xfcc0000, 1394728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xfcc0000
mprotect(0xfdfd000, 65536, PROT_NONE)   = 0
mmap(0xfe0d000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13d000) = 0xfe0d000
mmap(0xfe12000, 10280, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfe12000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x48020000
mprotect(0xfe0d000, 8192, PROT_READ)    = 0
mprotect(0xfed7000, 4096, PROT_READ)    = 0
mprotect(0xff40000, 4096, PROT_READ)    = 0
mprotect(0x4802e000, 4096, PROT_READ)   = 0
set_tid_address(0x48020068)             = 910
get_robust_list(0x48020070, 0xc, 0xbff80e6c) = 0
rt_sigaction(SIGRTMIN, {0xfef09f8, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xfef08f8, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 910 detached


and for a COMEDI example

/usr/xenomai/bin # strace ./cmd_write
execve("./cmd_write", ["./cmd_write"], [/* 8 vars */]) = 0
brk(0)                                  = 0x10046000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/tls/ppc603/libcomedi.so.0", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/xenomai/lib/tls/ppc603", 0xbf838268) = -1 ENOENT (No such file
or directory)
open("/usr/xenomai/lib/tls/libcomedi.so.0", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/xenomai/lib/tls", 0xbf838268) = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/ppc603/libcomedi.so.0", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/xenomai/lib/ppc603", 0xbf838268) = -1 ENOENT (No such file or
directory)
open("/usr/xenomai/lib/libcomedi.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=25622, ...}) = 0
mmap(0xffac000, 276948, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xffac000
mprotect(0xffb0000, 258048, PROT_NONE)  = 0
mmap(0xffef000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0xffef000
close(3)                                = 0
open("/usr/xenomai/lib/libnative.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\000"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=60116, ...}) = 0
mmap(0xff53000, 298328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xff53000
mprotect(0xff5c000, 258048, PROT_NONE)  = 0
mmap(0xff9b000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xff9b000
close(3)                                = 0
open("/usr/xenomai/lib/librtdm.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\30"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=18181, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4801f000
mmap(0xff00000, 272960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xff00000
mprotect(0xff03000, 258048, PROT_NONE)  = 0
mmap(0xff42000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xff42000
close(3)                                = 0
open("/usr/xenomai/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/tls/ppc603/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/tls/ppc603", 0xbf838208)   = -1 ENOENT (No such file or
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or
directory)
stat64("/lib/tls", 0xbf838208)          = -1 ENOENT (No such file or
directory)
open("/lib/ppc603/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/ppc603", 0xbf838208)       = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\361"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1537981, ...}) = 0
mmap(0xfd9b000, 1394728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xfd9b000
mprotect(0xfed8000, 65536, PROT_NONE)   = 0
mmap(0xfee8000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13d000) = 0xfee8000
mmap(0xfeed000, 10280, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfeed000
close(3)                                = 0
open("/usr/xenomai/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0M\330"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=130162, ...}) = 0
mmap(0xfd33000, 358004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xfd33000
mprotect(0xfd47000, 262144, PROT_NONE)  = 0
mmap(0xfd87000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xfd87000
mmap(0xfd89000, 5748, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfd89000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x48020000
mprotect(0xfd87000, 4096, PROT_READ)    = 0
mprotect(0xfee8000, 8192, PROT_READ)    = 0
mprotect(0x4802e000, 4096, PROT_READ)   = 0
set_tid_address(0x48020008)             = 913
get_robust_list(0x48020010, 0xc, 0xbf838e6c) = 0
rt_sigaction(SIGRTMIN, {0xfd379f8, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xfd378f8, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 913 detached


WHAT AM I MISSING, I SEE PLENTY OF No such file or directory !! WHERE SHOULD
I FOUND THOSE MISSING FILES, SIMLINKS....


THANKS IN ADVANCE !

BEST ,
Cristian

------=_Part_37726_19581649.1226160239702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello! <br>I&#39;ve installed Xenomai for a 2.6.24 linux kernel, for a PPC development board. My intentions are to use a NI DAQ card for a distributed control application using RTAI skin + Comedi. So I experience some trouble after installing Xenomai and even running specific latency , switchtest...etc or even cmd_read, cmd_write apps because I get a Segmentation Fault each time.<br>
So during my kernel booting i get :<br><br>I-pipe: Domain Xenomai registered.<br>Xenomai: hal/powerpc started.<br>I-pipe: Domain IShield registered.<br>Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.<br>
Xenomai: starting native API services.<br>Xenomai: starting POSIX services.<br>Xenomai: starting RTDM services.<br>Xenomai: starting RTAI emulator.<br><br>So&nbsp; I think it&#39;s ok, but I,ve copied my generated xenomai dir (including : bin include lib sbin share) and dev directory in my filesystem located on a SATA hard-drive conected to my board. Am I missing something in the installation steps ? Here are the main staps used for the installation :<br>
<br>/home/haustiq/development/xenomai-comedi-trunk/scripts/prepare-kernel.sh --arch=powerpc \<br>&nbsp; --adeos=/home/haustiq/development/xenomai-comedi-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch \<br>
&nbsp; --linux=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24<br><br>cd /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24<br><br>mkdir staging_dir build_root<br><br>make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root menuconfig<br>
&nbsp; <br>&nbsp; make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root uImage modules <br>&nbsp; <br>&nbsp; cd build_root<br>&nbsp; <br>&nbsp; /home/haustiq/development/xenomai-comedi-trunk/configure --prefix=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir&nbsp; --build=i686-pc-linux-gnu --host=ppc-unknown-linux-gnu CC=ppc_6xx-gcc CXX=ppc_6xx-g++ LD=ppc_6xx-ld<br>
&nbsp; <br>&nbsp; make ARCH=powerpc CROSS_COMPILE=ppc_6xx- DESTDIR=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir install<br><br>In staging_dir I have my genrated xenomai and dev folders copied in my FS .<br>
<br>So when runnig for example strace ./latency on my target I get :<br><br>/usr/xenomai/bin # strace ./latency<br>execve(&quot;./latency&quot;, [&quot;./latency&quot;], [/* 8 vars */]) = 0<br>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x10045000<br>
access(&quot;/etc/ld.so.preload&quot;, R_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/tls/ppc603/libnative.so.3&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/usr/xenomai/lib/tls/ppc603&quot;, 0xbff80268) = -1 ENOENT (No such file or directory)<br>
open(&quot;/usr/xenomai/lib/tls/libnative.so.3&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/usr/xenomai/lib/tls&quot;, 0xbff80268) = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/ppc603/libnative.so.3&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
stat64(&quot;/usr/xenomai/lib/ppc603&quot;, 0xbff80268) = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/libnative.so.3&quot;, O_RDONLY) = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\000&quot;..., 512) = 512<br>
fstat64(3, {st_mode=S_IFREG|0755, st_size=60116, ...}) = 0<br>mmap(0xffa7000, 298328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xffa7000<br>mprotect(0xffb0000, 258048, PROT_NONE)&nbsp; = 0<br>mmap(0xffef000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xffef000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/librtdm.so.1&quot;, O_RDONLY) = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\30&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=18181, ...}) = 0<br>
mmap(0xff54000, 272960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xff54000<br>mprotect(0xff57000, 258048, PROT_NONE)&nbsp; = 0<br>mmap(0xff96000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xff96000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libpthread.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>open(&quot;/etc/ld.so.cache&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/tls/ppc603/libpthread.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/lib/tls/ppc603&quot;, 0xbff80228)&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/lib/tls/libpthread.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
stat64(&quot;/lib/tls&quot;, 0xbff80228)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/lib/ppc603/libpthread.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/lib/ppc603&quot;, 0xbff80228)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/libpthread.so.0&quot;, O_RDONLY)&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0M\330&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=130162, ...}) = 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4801f000<br>
mmap(0xfeec000, 358004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfeec000<br>mprotect(0xff00000, 262144, PROT_NONE)&nbsp; = 0<br>mmap(0xff40000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xff40000<br>
mmap(0xff42000, 5748, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff42000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libm.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/libm.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\337&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=735452, ...}) = 0<br>mmap(0xfe25000, 747536, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfe25000<br>
mprotect(0xfec8000, 61440, PROT_NONE)&nbsp;&nbsp; = 0<br>mmap(0xfed7000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa2000) = 0xfed7000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\361&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=1537981, ...}) = 0<br>mmap(0xfcc0000, 1394728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfcc0000<br>
mprotect(0xfdfd000, 65536, PROT_NONE)&nbsp;&nbsp; = 0<br>mmap(0xfe0d000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13d000) = 0xfe0d000<br>mmap(0xfe12000, 10280, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfe12000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x48020000<br>mprotect(0xfe0d000, 8192, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>mprotect(0xfed7000, 4096, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>
mprotect(0xff40000, 4096, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>mprotect(0x4802e000, 4096, PROT_READ)&nbsp;&nbsp; = 0<br>set_tid_address(0x48020068)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 910<br>get_robust_list(0x48020070, 0xc, 0xbff80e6c) = 0<br>rt_sigaction(SIGRTMIN, {0xfef09f8, [], SA_SIGINFO}, NULL, 8) = 0<br>
rt_sigaction(SIGRT_1, {0xfef08f8, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0<br>rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0<br>getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0<br>--- SIGSEGV (Segmentation fault) @ 0 (0) ---<br>
+++ killed by SIGSEGV +++<br>Process 910 detached<br><br><br>and for a COMEDI example <br><br>/usr/xenomai/bin # strace ./cmd_write<br>execve(&quot;./cmd_write&quot;, [&quot;./cmd_write&quot;], [/* 8 vars */]) = 0<br>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x10046000<br>
access(&quot;/etc/ld.so.preload&quot;, R_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/tls/ppc603/libcomedi.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/usr/xenomai/lib/tls/ppc603&quot;, 0xbf838268) = -1 ENOENT (No such file or directory)<br>
open(&quot;/usr/xenomai/lib/tls/libcomedi.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/usr/xenomai/lib/tls&quot;, 0xbf838268) = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/ppc603/libcomedi.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
stat64(&quot;/usr/xenomai/lib/ppc603&quot;, 0xbf838268) = -1 ENOENT (No such file or directory)<br>open(&quot;/usr/xenomai/lib/libcomedi.so.0&quot;, O_RDONLY) = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34&quot;..., 512) = 512<br>
fstat64(3, {st_mode=S_IFREG|0755, st_size=25622, ...}) = 0<br>mmap(0xffac000, 276948, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xffac000<br>mprotect(0xffb0000, 258048, PROT_NONE)&nbsp; = 0<br>mmap(0xffef000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0xffef000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libnative.so.3&quot;, O_RDONLY) = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\000&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=60116, ...}) = 0<br>
mmap(0xff53000, 298328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xff53000<br>mprotect(0xff5c000, 258048, PROT_NONE)&nbsp; = 0<br>mmap(0xff9b000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0xff9b000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/librtdm.so.1&quot;, O_RDONLY) = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\30&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=18181, ...}) = 0<br>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4801f000<br>mmap(0xff00000, 272960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xff00000<br>mprotect(0xff03000, 258048, PROT_NONE)&nbsp; = 0<br>
mmap(0xff42000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xff42000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
open(&quot;/etc/ld.so.cache&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/lib/tls/ppc603/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>stat64(&quot;/lib/tls/ppc603&quot;, 0xbf838208)&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/tls/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>stat64(&quot;/lib/tls&quot;, 0xbf838208)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/lib/ppc603/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
stat64(&quot;/lib/ppc603&quot;, 0xbf838208)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or directory)<br>open(&quot;/lib/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\361&quot;..., 512) = 512<br>
fstat64(3, {st_mode=S_IFREG|0755, st_size=1537981, ...}) = 0<br>mmap(0xfd9b000, 1394728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfd9b000<br>mprotect(0xfed8000, 65536, PROT_NONE)&nbsp;&nbsp; = 0<br>mmap(0xfee8000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13d000) = 0xfee8000<br>
mmap(0xfeed000, 10280, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfeed000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/usr/xenomai/lib/libpthread.so.0&quot;, O_RDONLY) = -1 ENOENT (No such file or directory)<br>
open(&quot;/lib/libpthread.so.0&quot;, O_RDONLY)&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0M\330&quot;..., 512) = 512<br>fstat64(3, {st_mode=S_IFREG|0755, st_size=130162, ...}) = 0<br>mmap(0xfd33000, 358004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfd33000<br>
mprotect(0xfd47000, 262144, PROT_NONE)&nbsp; = 0<br>mmap(0xfd87000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xfd87000<br>mmap(0xfd89000, 5748, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfd89000<br>
close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x48020000<br>mprotect(0xfd87000, 4096, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>mprotect(0xfee8000, 8192, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>
mprotect(0x4802e000, 4096, PROT_READ)&nbsp;&nbsp; = 0<br>set_tid_address(0x48020008)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 913<br>get_robust_list(0x48020010, 0xc, 0xbf838e6c) = 0<br>rt_sigaction(SIGRTMIN, {0xfd379f8, [], SA_SIGINFO}, NULL, 8) = 0<br>rt_sigaction(SIGRT_1, {0xfd378f8, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0<br>
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0<br>getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0<br>--- SIGSEGV (Segmentation fault) @ 0 (0) ---<br>+++ killed by SIGSEGV +++<br>Process 913 detached<br>
<br><br>WHAT AM I MISSING, I SEE PLENTY OF No such file or directory !! WHERE SHOULD I FOUND THOSE MISSING FILES, SIMLINKS....<br><br><br>THANKS IN ADVANCE !<br><br>BEST , <br>Cristian<br><br><br><br><br>

------=_Part_37726_19581649.1226160239702--

