Message-ID: <497F440A.9040700@domain.hid>
Date: Tue, 27 Jan 2009 18:27:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <497F3E29.6050303@domain.hid> <497F40F3.3010801@domain.hid>
In-Reply-To: <497F40F3.3010801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] xnpipe: Fix minor number management
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> This is an attempt to fix the bugs found in the minor number management:
>> - changing the bitmap requires atomic operations
>> - clrbits/setbits work against xnarch_atomic_t, and that is only 32 bit
>>   wide on x86-64
> 
> I think we should rather fix xnarch_atomic_t to be the size of a long on
> x86-64, than having to cope with xnarch_atomic_t of various sizes in the
> code (there are probably other places where we depend on the size of
> xnarch_atomic_t).

IIRC, not all Linux atomic ops exits for atomic64_t, so we would have to
provide our own versions. Moreover, there might be a deeper reason for
Linux staying at 32 bit atomics on x86-64. Performance? Just speculating
now, but I wouldn't touch this for Xenomai without an urgent need.

> 
> As for the find_first_bit, why not simply taking the nklock
> xnpipe_minor_free ? This is a first masking section, so this should not
> matter a lot.

Yeah, probably the better approach - back to non-atomic ops:

--------->

Instead of trying to perform the minor release lockless (and failing due
to 32-bit atomic ops on x86-64), let's go back to nklock-protected
bitmap handling.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/pipe.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
index d7409da..d201f5d 100644
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -78,9 +78,8 @@ static inline int xnpipe_minor_alloc(int minor)
 static inline void xnpipe_minor_free(int minor)
 {
 	/* May be called with nklock free. */
-	clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
-		1UL << (minor % BITS_PER_LONG));
-	xnarch_memory_barrier();
+	__clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
+		  1UL << (minor % BITS_PER_LONG));
 }
 
 static inline void xnpipe_enqueue_wait(struct xnpipe_state *state, int mask)
@@ -414,7 +413,9 @@ cleanup:
 	} else {
 		xnlock_put_irqrestore(&nklock, s);
 		state->ops.release(state->xstate);
+		xnlock_get_irqsave(&nklock, s);
 		xnpipe_minor_free(minor);
+		xnlock_put_irqrestore(&nklock, s);
 	}
 
 	if (need_sched)
@@ -622,8 +623,8 @@ int xnpipe_flush(int minor, int mode)
 			clrbits((__state)->status, XNPIPE_KERN_LCLOSE);	\
 			xnlock_put_irqrestore(&nklock, (__s));		\
 			(__state)->ops.release((__state)->xstate);	\
-			xnpipe_minor_free(xnminor_from_state(__state));	\
 			xnlock_get_irqsave(&nklock, (__s));		\
+			xnpipe_minor_free(xnminor_from_state(__state));	\
 		}							\
 	} while(0)
 

