Date: Tue, 27 Jul 2010 14:59:24 -0400
From: Edward Hoffman <quantalgo@domain.hid>
Message-id: <1280257164.5534.37.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Subject: [Xenomai-help] Problem Building Xenomai Linux Kernel
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

I have a problem building Xenomai.
        
        Hardware:
        Dual Quad Xeon
        
        Host Operating System
        Ubuntu amd-64 10.04  kernel 2.6.32-24-generic
        
        Downloads:
        linux-2.6.34.1
        xenomai-2.5.3
        
        Kernel Preparation:
        root@domain.hid#
        scripts/prepare-kernel.sh
        --arch=x86
        --adeos=/usr/src/xenomai-2.5.3/ksrc/arch/x86/patches/adeos-ipipe-2.6.34-x86-2.7.02.patch --linux=/usr/src/linux-2.6.34.1
        
        I get the following error:
        
         VDSOSYM arch/x86/vdso/vdso32-syms.lds
          LD      arch/x86/vdso/built-in.o
          LD      arch/x86/built-in.o
          CC      kernel/xenomai/nucleus/pod.o
        In file included
        from /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod.h:4,
                         from kernel/xenomai/nucleus/pod.c:47:
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h: In
        function 'xnarch_switch_to':
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:98:
        error: implicit declaration of function 'per_cpu_var'
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:98:
        error: lvalue required in asm statement
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:98:
        error: invalid lvalue in asm output 6
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:98:
        error: memory input 14 is not directly addressable
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h: In
        function 'xnarch_thread_trampoline':
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:113:
        error: lvalue required in asm statement
        /usr/src/linux-2.6.34.1/arch/x86/include/asm/xenomai/bits/pod_64.h:113:
        error: invalid lvalue in asm output 0
        make[3]: *** [kernel/xenomai/nucleus/pod.o] Error 1
        make[2]: *** [kernel/xenomai/nucleus] Error 2
        make[1]: *** [kernel/xenomai] Error 2
        make: *** [kernel] Error 2
        
        Analysis:
        Apparently, the following function definitions referred to in
        pod_64.h:
        
        xnarch_switch_threads
        xnarch_thread head
        
        have been commented out in switch_64.h.
        
        Can I uncomment these out and proceed or have I missed in the
        process.
        
        RSVP.
        
        
        Thanks.
        
        Ed
        
        
        


