From: Wim  <wim@hidof.com>
Date: Thu, 27 Dec 2012 19:06:42 +0000 (UTC)
Message-ID: <loom.20121227T200150-371@post.gmane.org>
References: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
	=?utf-8?q?Kernel_compilation_error_due_to_Adeos_patch_e?=
	=?utf-8?b?cnJvciBpbgknaW9fYXBpYy5jJw==?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 
> Vanilla Kernel: 3.2.21
> Adeos Patch: ipipe-core-3.2.21-x86-1.patch
> gcc --version: 4.7.0
> Xenomai Version: 2.6.1
> 
> Patch applies itself cleanly.
> 
> Compilation error during initial kernel 'make':
> arch/x86/kernel/apic/io_apic.c: In function
> ‘irq_remap_modify_chip_defaults’:
> arch/x86/kernel/apic/io_apic.c:2763:1: error: expected expression before
> ‘}’ token
> 
> Problem:
> Commas instead of semi-colons at the end of lines inside CONFIG_IPIPE 'if'
> directives in 'io_apic.c'.



Thanks Steve, this really helped!  

I can confirm that this problem still exists with yesterday's  
stable Xenomai release 2.6.2, ipipe-core-3.2.21-x86-2.patch, a vanilla 3.2.21 
kernel, ang gcc 4.6.3 on Ubuntu 12.04.


