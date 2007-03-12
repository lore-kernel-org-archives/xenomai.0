Message-ID: <560b19a70703121100x2a4a751dt4fc87b0176c3d587@domain.hid>
Date: Mon, 12 Mar 2007 18:00:56 +0000
From: "Ze Manel" <zemanel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Adeos-main] Kernel 2.6.20.2
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

I'm now trying to compile the kernel with the corresponding adeos patch:
"adeos-ipipe-2.6.20-i386-1.7-03.patch"

I did "patch -p1 <adeos-ipipe-2.6.20-i386-1.7-03.patch" and all went
well with no errors.
After that I did "make menuconfig" and just saved the .config. the
problem is that I'm quite sure I should have changed something in the
config file BUT I DON'T KNOW WHAT, since I can't find the information
for that...
Where is the documentation?

when I try to compile the kernel, there is a problem in the link of
something, it doesn't find some symbols:

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/mach-generic/built-in.o(.text+0x4f): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x50d): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0x7eb): In function
`send_IPI_allbutself':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0xaf2): In function
`clustered_apic_check':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0xbc3): In function `target_cpus':
: undefined reference to `smp_processor_id_hw'
arch/i386/mach-generic/built-in.o(.text+0xc6b): more undefined
references to `smp_processor_id_hw' follow
make: *** [.tmp_vmlinux1] Error 1


Can you help me?
Thanks.
Is the RTAI path equal to the adeos one? RTAI has quite better
documentation, I only don't know if the patch is completly equal or
diferent.

