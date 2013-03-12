Message-ID: <513F5C23.2090603@yahoo.com>
Date: Tue, 12 Mar 2013 11:47:31 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] problems while patching Debian kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I encountered the follow errors while trying to patch Debian 6.0.7 
(linux-2.6.32) with the Xenomai patch installed through Software Center 
in Debian:

dpkg: warning: obsolete option '--print-installation-architecture', 
please use '--print-architecture' instead.
START applying xenomai patch (Xenomai realtime kernel patches)
Testing whether "Xenomai realtime kernel patches" patch for 2.6.32 
applies (dry run):
1 out of 4 hunks FAILED -- saving rejects to file 
arch/x86/kernel/process_64.c.rej
1 out of 6 hunks FAILED -- saving rejects to file arch/x86/mm/fault.c.rej
1 out of 15 hunks FAILED -- saving rejects to file kernel/sched.c.rej
1 out of 1 hunk FAILED -- saving rejects to file kernel/signal.c.rej
"Xenomai realtime kernel patches" patch for 2.6.32 does not apply cleanly

Below are the the steps I took:
1. Debian 6.0.7 is installed in a virtual machine (as I want to try it 
first before installing it on a native hardware)
2. I installed the Xenomai patches and linux kernel source 2.6.32 
through Software Center
3. I ran "/usr/src/kernel-patches/i386/apply/xenomai" as told by 
"/usr/share/doc/linux-patch-xenomai/README.Debian"

I found the following details, but not sure if they are related,
The Linux kernel source is under "/usr/src/linux-source-2.6.32", and the 
file "version.Debian" shows "2.6.32 48squeeze1", but 
"/usr/src/kernel-patches/i386/apply/xenomai" has the following lines:
KVERSIONS=(2.6.31.8 2.6.32 2.6.34 2.6.32.15)
PATCHFILES=("/usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.31.8-x86-2.4-09.patch.gz" 
"/usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.32-x86-2.7-01.patch.gz" 
"/usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.34-x86-2.7-02.patch.gz" 
"/usr/src/kernel-patches/diffs/xenomai/adeos-ipipe-2.6.32.15-x86-2.7-01.patch.gz") 


Does that mean "2.6.32 48squeeze1" is not supported by this patch? If 
this is not the cause, then what caused the above problems? How can I 
solve them?


With many thanks,

Tom


