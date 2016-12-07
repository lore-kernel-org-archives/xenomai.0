From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
Date: Wed, 7 Dec 2016 15:15:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I noticed very bad memory allocation performance on some of my graphic 
programs (standard linux applications).

If you run any classic program, you won't sea any difference, but it has 
been visible in the following context :

I have an application that allocates thousends of graphic widgets, 
label, input fields  at startup (a data editor) .

Using the standard kernel, the applications starts very quickly. But  
once the ipipe patch is applied to kernel, this application makes lot of 
seconds before appearing.

I am using a 3.18 kernel.

I made a diff on both standards and ipipe kernel configs :
236a237
 > CONFIG_KPROBES_ON_FTRACE=y
372a374,382
 > CONFIG_PARAVIRT=y
 > # CONFIG_PARAVIRT_DEBUG is not set
 > # CONFIG_PARAVIRT_SPINLOCKS is not set
 > # CONFIG_XEN is not set
 > CONFIG_KVM_GUEST=y
 > # CONFIG_KVM_DEBUG_FS is not set
 > # CONFIG_LGUEST_GUEST is not set
 > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
 > CONFIG_PARAVIRT_CLOCK=y
427,435d436
< CONFIG_IPIPE=y
< # CONFIG_IPIPE_LEGACY is not set
< CONFIG_IPIPE_CORE=y
< CONFIG_IPIPE_WANT_CLOCKSOURCE=y
< CONFIG_IPIPE_WANT_PTE_PINNING=y
< CONFIG_IPIPE_CORE_APIREV=2
< CONFIG_IPIPE_TARGET_APIREV=2
< CONFIG_IPIPE_HAVE_HOSTRT=y
< CONFIG_IPIPE_HAVE_VM_NOTIFIER=y
512a514,516
 > CONFIG_TRANSPARENT_HUGEPAGE=y
 > CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
 > # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
6237d6240
< # CONFIG_IPIPE_DEBUG is not set
6356a6360,6361
 > CONFIG_DYNAMIC_FTRACE=y
 > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
6357a6363
 > CONFIG_FTRACE_MCOUNT_RECORD=y


Regards,
S.Ancelot

