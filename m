Message-ID: <b6ad4ed70708301343t4fd6c9b6j854c993001e34bb6@domain.hid>
Date: Thu, 30 Aug 2007 16:43:06 -0400
From: "John Yamokoski" <yamokosk@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2767_3989093.1188506586808"
Subject: [Xenomai-help] error compiling xenomai 2.4-rc1 and rc2 with linux
	kernel 2.6.22.5
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

------=_Part_2767_3989093.1188506586808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

I ran into compile errors when trying to compile both xenomai 2.4-rc1 and
rc2 with linux 2.6.22.5 and the latest adeos patch. First here are my system
details:

Kernel: 2.6.22.5
Adeos patch: adeos-ipipe-2.6.22-i386-1.10-00.patch
gcc: 4.1.2
distro: Debian 4.1.1-21

Here were the compile errors: (The error was identical for rc1 and rc2)

CC      kernel/xenomai/arch/generic/hal.o
kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_handler':
kernel/xenomai/arch/generic/hal.c:397: error: 'ipipe_declare_cpuid'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:397: error: (Each undeclared identifier is
reported only once
kernel/xenomai/arch/generic/hal.c:397: error: for each function it appears
in.)
kernel/xenomai/arch/generic/hal.c:399: warning: implicit declaration of
function 'ipipe_load_cpuid'
kernel/xenomai/arch/generic/hal.c:411: error: array subscript is not an
integer
kernel/xenomai/arch/generic/hal.c:412: error: array subscript is not an
integer
kernel/xenomai/arch/generic/hal.c:413: error: array subscript is not an
integer
kernel/xenomai/arch/generic/hal.c:416: error: array subscript is not an
integer
kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_schedule':
kernel/xenomai/arch/generic/hal.c:602: error: 'ipipe_declare_cpuid'
undeclared (first use in this function)
kernel/xenomai/arch/generic/hal.c:603: warning: ISO C90 forbids mixed
declarations and code
kernel/xenomai/arch/generic/hal.c:612: error: array subscript is not an
integer
make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
make[4]: *** [kernel/xenomai/arch/generic] Error 2
make[3]: *** [kernel/xenomai/arch] Error 2
make[2]: *** [kernel/xenomai] Error 2
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/home/yamokosk/apps/linux-2.6.22.5-xenomai'
make: *** [debian/stamp-build-kernel] Error 2

------=_Part_2767_3989093.1188506586808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,<br><br>I ran into compile errors when trying to compile both xenomai 2.4-rc1 and rc2 with linux <a href="http://2.6.22.5">2.6.22.5</a> and the latest adeos patch. First here are my system details:<br><br>Kernel: 
<a href="http://2.6.22.5">2.6.22.5</a><br>Adeos patch: adeos-ipipe-2.6.22-i386-1.10-00.patch<br>gcc: 4.1.2<br>distro: Debian 4.1.1-21<br><br>Here were the compile errors: (The error was identical for rc1 and rc2)<br><br>CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/xenomai/arch/generic/hal.o
<br>kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_handler':<br>kernel/xenomai/arch/generic/hal.c:397: error: 'ipipe_declare_cpuid' undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:397: error: (Each undeclared identifier is reported only once
<br>kernel/xenomai/arch/generic/hal.c:397: error: for each function it appears in.)<br>kernel/xenomai/arch/generic/hal.c:399: warning: implicit declaration of function 'ipipe_load_cpuid'<br>kernel/xenomai/arch/generic/hal.c:411: error: array subscript is not an integer
<br>kernel/xenomai/arch/generic/hal.c:412: error: array subscript is not an integer<br>kernel/xenomai/arch/generic/hal.c:413: error: array subscript is not an integer<br>kernel/xenomai/arch/generic/hal.c:416: error: array subscript is not an integer
<br>kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_schedule':<br>kernel/xenomai/arch/generic/hal.c:602: error: 'ipipe_declare_cpuid' undeclared (first use in this function)<br>kernel/xenomai/arch/generic/hal.c:603: warning: ISO C90 forbids mixed declarations and code
<br>kernel/xenomai/arch/generic/hal.c:612: error: array subscript is not an integer<br>make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1<br>make[4]: *** [kernel/xenomai/arch/generic] Error 2<br>make[3]: *** [kernel/xenomai/arch] Error 2
<br>make[2]: *** [kernel/xenomai] Error 2<br>make[1]: *** [kernel] Error 2<br>make[1]: Leaving directory `/home/yamokosk/apps/linux-2.6.22.5-xenomai&#39;<br>make: *** [debian/stamp-build-kernel] Error 2<br><br>

------=_Part_2767_3989093.1188506586808--

