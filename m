Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4500789C.9070804@domain.hid>
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 15:59:27 +0200
Message-Id: <1157723967.4992.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2006-09-07 at 14:53 -0500, Jeff Webb wrote:
> Thanks for your input, Jan.
> 
> Jan Kiszka wrote:
> > Jeff Webb wrote:
> >> It appears that the maximum pipe size that can be created using
> >> rt_pipe_create() is 16 MB.  Is this correct?  If so, what is the cause
> >> of this limitation, and are there any work-arounds?  I am using a 128 MB
> >> FIFO in my rtlinux simulation.  Any ideas on how I can port this?
> > 
> > Maybe it's a 2.4-related issue (my 2.4 setup is broken, can't test). On
> > a 2.6.17 kernel I face no problems allocating far larger rt_pipes.
> 
> I have discovered the source of the inconsistency:
> 
>   xenomai-2.1-rc4: include/nucleus/heap.h:
>     #define XNHEAP_MAXEXTSZ   (1 << 24) /* i.e. 16Mb */
> 
>   xenomai-2.2.1: include/nucleus/heap.h:
>     #define XNHEAP_MAXEXTSZ   (1 << 31) /* i.e. 2Gb */
> 
>   Changelog:  
>     2006-07-15  Philippe Gerum  <rpm@xenomai.org>
>         * include/nucleus/heap.h (XNHEAP_MAXEXTSZ): Raise maximum extent size to 2Gb.
> 
> I can now create a 128 MB rt-pipe on my xenomai-2.2.1 / kernel 2.6 dual-core machine, if I boot with vmalloc=256M and add "uppermem 524288" to my grub config.  I have not built an updated 2.4 kernel to test on my Fedora Core I machine yet, but I will do this soon.
> 
> > RTAI FIFO allocate their buffers from the real-time system heap, and
> > that on is 128 KB by default (see kernel config).
> 
> Ah, I see.
> 
> I know this is not the ideal solution, but could the system heap be made something big, like 256 MB?  That might solve my problem, for the short term.  Of course, if there is a memory leak in the FIFO creation/deletion, I will have BIG problems... ;)
>  
> > Allocation in Xenomai pipes works differently...
> 
> Is there some reason the RTAI FIFO emulation is not handled the same way?  I believe the real RTL and RTAI FIFOs are handled like the Xenomai pipes are done now -- using kmalloc or vmalloc:
> 
>   https://www.rtai.org/documentation/magma/html/api/group__fifos__ipc.html#ga8
> 
> I know my FIFOs are on the huge side, but I know I'm not the only one using more than 128KB total for all their FIFOs...
> 
> > The potential leak you found needs to be examined. Could you post a
> > simple test that demonstrate it?
> 
> I'm attaching a sample kernel module that creates a 100KB FIFO on module insertion, and destroys it on module removal.  I can only run this one time.  The write fails on subsequent runs because the memory cannot be allocated.  Is there something I am not cleaning up properly?
> 

This patch on top of 2.2.2 should fix the leakage. This said, I'm going
to rework the fifo emulation a bit to get closer to the RTAI behaviour.

--- ksrc/nucleus/pipe.c	(revision 1562)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -306,6 +306,12 @@
 
 	__clrbits(state->status, XNPIPE_KERN_CONN);
 
+	if (state->output_handler != NULL) {
+		while ((holder = getq(&state->outq)) != NULL)
+			state->output_handler(minor, link2mh(holder),
+					      -EPIPE, state->cookie);
+	}
+
 	if (testbits(state->status, XNPIPE_USER_CONN)) {
 		while ((holder = getq(&state->inq)) != NULL) {
 			if (state->input_handler != NULL)
@@ -315,12 +321,6 @@
 				xnfree(link2mh(holder));
 		}
 
-		if (state->output_handler != NULL) {
-			while ((holder = getq(&state->outq)) != NULL)
-				state->output_handler(minor, link2mh(holder),
-						      -EPIPE, state->cookie);
-		}
-
 		if (xnsynch_destroy(&state->synchbase) == XNSYNCH_RESCHED)
 			xnpod_schedule();
 
@@ -369,11 +369,6 @@
 		return -EBADF;
 	}
 
-	if (!testbits(state->status, XNPIPE_USER_CONN)) {
-		xnlock_put_irqrestore(&nklock, s);
-		return -EPIPE;
-	}
-
 	inith(xnpipe_m_link(mh));
 	xnpipe_m_size(mh) = size - sizeof(*mh);
 	state->ionrd += xnpipe_m_size(mh);
@@ -383,6 +378,11 @@
 	else
 		appendq(&state->outq, xnpipe_m_link(mh));
 
+	if (!testbits(state->status, XNPIPE_USER_CONN)) {
+		xnlock_put_irqrestore(&nklock, s);
+		return (ssize_t) size;
+	}
+
 	if (testbits(state->status, XNPIPE_USER_WREAD)) {
 		/* Wake up the userland thread waiting for input
 		   from the kernel side. */
-- 
Philippe.



