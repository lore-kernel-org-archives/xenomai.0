Message-ID: <560b19a70703120342k7615bb1cm3d6ef3b2dac1674a@domain.hid>
Date: Mon, 12 Mar 2007 10:42:11 +0000
From: "Ze Manel" <zemanel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32299_21420871.1173696131743"
Subject: [Adeos-main] Linux-2.6.20
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_32299_21420871.1173696131743
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello. I'm trying to compile linux 2.6.20 kernel with adeos patch "
adeos-ipipe-2.6.20-i386-1.7-03.patch"
but I get this error:

LD      .tmp_vmlinux1
arch/i386/mach-generic/built-in.o(.text+0x2c): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x3f2): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x5d8): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x83d): In function
`clustered_apic_check':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x8df): In function `target_cpus':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x95e): more undefined references to
`smp_processor_id_hw' follow
make: *** [.tmp_vmlinux1] Error 1

there seems to be a problem when he links this.. did anyone get the same
problem? what am I doing wrong?
Thanks.

------=_Part_32299_21420871.1173696131743
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello. I&#39;m trying to compile linux 2.6.20 kernel with adeos patch &quot;adeos-ipipe-2.6.20-i386-1.7-03.patch&quot; <br>but I get this error:<br><br>LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tmp_vmlinux1<br>arch/i386/mach-generic/built-in.o(.text+0x2c): In function `send_IPI_allbutself&#39;:
<br>: undefined reference to `smp_processor_id_hw&#39;<br>arch/i386/mach-generic/built-in.o(.text+0x3f2): In function `send_IPI_allbutself&#39;:<br>: undefined reference to `smp_processor_id_hw&#39;<br>arch/i386/mach-generic/built-
in.o(.text+0x5d8): In function `send_IPI_allbutself&#39;:<br>: undefined reference to `smp_processor_id_hw&#39;<br>arch/i386/mach-generic/built-in.o(.text+0x83d): In function `clustered_apic_check&#39;:<br>: undefined reference to `smp_processor_id_hw&#39;
<br>arch/i386/mach-generic/built-in.o(.text+0x8df): In function `target_cpus&#39;:<br>: undefined reference to `smp_processor_id_hw&#39;<br>arch/i386/mach-generic/built-in.o(.text+0x95e): more undefined references to `smp_processor_id_hw&#39; follow
<br>make: *** [.tmp_vmlinux1] Error 1<br><br>there seems to be a problem when he links this.. did anyone get the same problem? what am I doing wrong? <br>Thanks.<br><br>

------=_Part_32299_21420871.1173696131743--

