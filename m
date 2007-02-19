Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17882.5512.521970.784116@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
	<45D5746C.1090003@domain.hid> <45D8DF58.2090804@domain.hid>
	<17880.57781.152126.164326@domain.hid>
	<1171842613.13484.17.camel@domain.hid>
	<17880.60750.537420.707178@domain.hid>
	<45D95218.6000602@domain.hid>
	<45D9989E.4070103@domain.hid> <17882.5512.521970.784116@domain.hid>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 23:43:18 +0100
Message-Id: <1171924998.18310.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2007-02-19 at 22:24 +0100, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > May this hunk explain the behaviour?
>  > 
>  > http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.7-02.patch?a=i386;v=SVN-2.3.x#7755
>  > 
>  > munlockall is realised via mlockall, so OR'ing here would never take
>  > away any flag.
> 
> My intent was to avoid that the VM_PINNED flag be cleared by mlockall.
> So, I guess the correct pattern is:
> 
> current->mm->def_flags = current->mm->def_flags & ~VM_LOCKED | def_flags;
> 

In such a case, I would suggest the following, so that we don't copy
unwanted regular flags unexpectedly:

--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -162,10 +162,10 @@ asmlinkage long sys_munlock(unsigned long start, size_t len)
 static int do_mlockall(int flags)
 {
 	struct vm_area_struct * vma, * prev = NULL;
-	unsigned int def_flags = 0;
+	unsigned int def_flags = current->mm->def_flags & VM_PINNED;
 
 	if (flags & MCL_FUTURE)
-		def_flags = VM_LOCKED;
+		def_flags |= VM_LOCKED;
 	current->mm->def_flags = def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;

-- 
Philippe.



