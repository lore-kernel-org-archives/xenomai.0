Message-ID: <48D7E184.5000200@domain.hid>
Date: Mon, 22 Sep 2008 20:18:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48D6A80F.1080206@domain.hid> <48D75663.8000402@domain.hid>
	<48D7BA7F.6030801@domain.hid>
In-Reply-To: <48D7BA7F.6030801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Handle SIGILL when kernel compiled
	without	Xenomai.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> on some (all ?) platforms, we get a SIGILL when trying to emit the first 
>>> Xenomai syscall, instead of the -ENOSYS return value. This patches 
>>> handles the SIGILL by printing an error message and exiting.
>>>
>> This is an issue for archs that encode the syscall number into the trap opcode
>> like ARM using the OABI, others will get -ENOSYS as expected, so this should
>> move to the arch-specific code.
> 
> Actually, I get a SIGILL on ARM compiled with EABI as well. Moving this
> code to the arch dependent code looks hard, since we need to setup the
> jump buffer in the very function which issues the syscall (Ok, we could
> use a macro). But what would you think of a SIGILL handler which does
> not longjmp (like Jan suggested, simply print an error message and exit,
> even if xeno_bind_skin_opt was called) ?
> 

So, here is another version.

Index: include/asm-generic/bits/bind.h
===================================================================
--- include/asm-generic/bits/bind.h	(revision 4175)
+++ include/asm-generic/bits/bind.h	(working copy)
@@ -99,15 +99,32 @@ static void unmap_sem_heap(unsigned long
 }
 #endif /* CONFIG_XENO_FASTSEM */
 
+void __attribute__((weak)) xeno_sigill_handler(int sig)
+{
+	fprintf(stderr, "Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.\n"
+		"(modprobe xeno_nucleus?)\n");
+	exit(1);
+}
+
 static inline int
 xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
 {
+	sighandler_t old_sigill_handler;
 	struct sigaction sa;
 	xnfeatinfo_t finfo;
 	int muxid;
 
+	old_sigill_handler = signal(SIGILL, xeno_sigill_handler);
+	if (old_sigill_handler == SIG_ERR) {
+		perror("signal(SIGILL)");
+		exit(1);
+	}
+
 	muxid = XENOMAI_SYSBIND(skin_magic,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
+
+	signal(SIGILL, old_sigill_handler);
+
 	switch (muxid) {
 	case -EINVAL:
 
@@ -180,11 +197,21 @@ xeno_bind_skin(unsigned skin_magic, cons
 static inline int
 xeno_bind_skin_opt(unsigned skin_magic, const char *skin, const char *module)
 {
+	sighandler_t old_sigill_handler;
 	xnfeatinfo_t finfo;
 	int muxid;
 
+	old_sigill_handler = signal(SIGILL, xeno_sigill_handler);
+	if (old_sigill_handler == SIG_ERR) {
+		perror("signal(SIGILL)");
+		exit(1);
+	}
+
 	muxid = XENOMAI_SYSBIND(skin_magic,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
+
+	signal(SIGILL, old_sigill_handler);
+
 	switch (muxid) {
 	case -EINVAL:
 

-- 
					    Gilles.

