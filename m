From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DE4D2F1.20305@domain.hid>
References: <4DE4D2F1.20305@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 May 2011 18:29:57 +0200
Message-ID: <1306859397.2153.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fragile lock usage tracking for auto-relax
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2011-05-31 at 13:37 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> enabling XENO_OPT_DEBUG_NUCLEUS reveals some shortcomings of the
> in-kernel lock usage tracking via xnthread_t::hrescnt. This BUGON in
> xnsynch_release triggers for RT threads:
> 
> 	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
> 
> RT threads do not balance their lock and unlock syscalls, so their
> counter goes wild quite quickly.
> 
> But just limiting the bug check to XNOTHER threads is neither a
> solution. How to deal with the counter on scheduling policy changes?
> 
> So my suggestion is to convert the auto-relax feature into a service,
> user space can request based on a counter that user space maintains
> independently. I.e. we should create another shared word that user space
> increments and decrements on lock acquisitions/releases on its own. The
> nucleus just tests it when deciding about the relax on return to user space.
> 
> But before hacking into that direction, I'd like to hear if it makes
> sense to you.

At first glance, this does not seem to address the root issue. The
bottom line is that we should not have any thread release an owned lock
it does not hold, kthread or not.

In that respect, xnsynch_release() looks fishy because it may be called
over a context which is _not_ the lock owner, but the thread who is
deleting the lock owner, so assuming lastowner == current_thread when
releasing is wrong.

At the very least, the following patch would prevent
xnsynch_release_all_ownerships() to break badly. The same way, the
fastlock stuff does not track the owner properly in the synchro object.
We should fix those issues before going further, they may be related to
the bug described.

Totally, genuinely, 100% untested.

diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 3a53527..0785533 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -424,6 +424,7 @@ xnflags_t xnsynch_acquire(struct xnsynch *synch, xnticks_t timeout,
 						 XN_NO_HANDLE, threadh);
 
 		if (likely(fastlock == XN_NO_HANDLE)) {
+			xnsynch_set_owner(synch, thread);
 			xnthread_inc_rescnt(thread);
 			xnthread_clear_info(thread,
 					    XNRMID | XNTIMEO | XNBREAK);
@@ -718,7 +719,7 @@ struct xnthread *xnsynch_release(struct xnsynch *synch)
 
 	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
-	lastowner = xnpod_current_thread();
+	lastowner = synch->owner ?: xnpod_current_thread();
 	xnthread_dec_rescnt(lastowner);
 	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
 	lastownerh = xnthread_handle(lastowner);

-- 
Philippe.



