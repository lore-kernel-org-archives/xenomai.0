Date: Tue, 1 Jul 2008 15:00:33 +0200
From: Guido Moritz <guido.moritz@domain.hid>
Message-ID: <176721864.20080701150033@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai and TSC
Reply-To: Guido Moritz <guido.moritz@domain.hid>
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

Hi.

I have tried to install Xenomai on a standard PC, but I still have
some problems I couldn't solve up to now.

I installed Xenomai in two different Versions with two different
Linux Kernel versions. I tried Linux 2.6.17.2+Xenomai 2.3.2 and Linux
2.6.25.9+Xenomai 2.4.4. In both cases, I couldn't run the xeno-test
completly, because the "TSC" feature is missing.
By using Google to solve this problem I found some hints using the
./configure --enable-x86-tsc --enable-x86-sep command e.g. But this
also didn't help. I also didn't found any options for TSC in the
.config file for the kernel. My CPU flags (see below) show that both,
SEP and TSC, are available.

Is this a known problem with this kind of CPU? If anybody has a useful
hint how to solve this, I would be appreciate.


processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1045.721
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow up
bogomips        : 2093.70

Kind Regards

Guido Moritz

-------------------------
Dipl. Ing. Guido Moritz
Universitaet Rostock, Fakultaet f. Informatik und Elektrotechnik
Institut f. Angewandte Mikroelektronik und Datentechnik
University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE
Richard-Wagner Str. 31, 18119 Rostock-Warnemuende
Phone:=A0 +49 (0)381 498 - 7269
http://www.imd.uni-rostock.de


