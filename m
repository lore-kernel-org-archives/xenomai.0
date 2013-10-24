Message-ID: <5268DCEA.7000202@basystemes.fr>
Date: Thu, 24 Oct 2013 10:40:10 +0200
From: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  xsave/xrstor compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I tried to upgrade to xenomai 2.6.3 and compilation failed with :

linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h: Assembler messages:
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:305: Error: no 
such instruction: `xrstor (%ebx)'
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:245: Error: no 
such instruction: `xsave (%esi)'
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:305: Error: no 
such instruction: `xrstor (%ecx)'
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:245: Error: no 
such instruction: `xsave (%ecx)'
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:245: Error: no 
such instruction: `xsave (%ecx)'
linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:245: Error: no 
such instruction: `xsave (%ebx)'

I am using kernel 2.6.38.8 with adeos-ipipe-2.6.38.8-x86-2.11-03.patch.
I used binutils-2.18.1 and gcc-4.3.2.
With a more recent toolchain, there is no compilation failure.
Is there a new minimal binutils/gcc version for xenomai 2.6.3 ?

Regards,

Jean-Baptiste



