Date: Sat, 18 Jun 2016 22:00:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160618200017.GH18433@hermes.click-hack.org>
References: <20160618130822.GB18433@hermes.click-hack.org>
 <8e8bb173-eda9-bab4-6236-634da1e396cb@xenomai.org>
 <20160618135235.GE18433@hermes.click-hack.org>
 <20160618172041.GF18433@hermes.click-hack.org>
 <20160618182031.GG18433@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160618182031.GG18433@hermes.click-hack.org>
Subject: Re: [Xenomai] ftrace dispatch function broken on 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Jun 18, 2016 at 08:20:31PM +0200, Gilles Chanteperdrix wrote:
> On Sat, Jun 18, 2016 at 07:20:41PM +0200, Gilles Chanteperdrix wrote:
> > On Sat, Jun 18, 2016 at 03:52:35PM +0200, Gilles Chanteperdrix wrote:
> > > On Sat, Jun 18, 2016 at 03:21:40PM +0200, Philippe Gerum wrote:
> > > > On 06/18/2016 03:08 PM, Gilles Chanteperdrix wrote:
> > > > > Hi Philippe,
> > > > > 
> > > > > it seems since I-pipe commit
> > > > > b115c4094d734e19fa7a96be1bf3958b3d244b8b on the ipipe-3.18 branch:
> > > > >     Revert "ipipe: Register function tracer for direct and exclusive invocation"
> > > > >     
> > > > >     This reverts commit e00888b4aae45d9b84698a62079dde14c9be5fd3.
> > > > >     
> > > > >     We now have an I-pipe-compatible dispatching function for ftrace.
> > > > > 
> > > > > The ftrace dispatching function causes the following warning at
> > > > > boot on x86_32 with all warnings/debugs enabled:
> > > > > [    4.730812] I-pipe: head domain Xenomai registered.
> > > > > [    4.737967] I-pipe: Detected illicit call from head domain 'Xenomai'
> > > > > [    4.737967]         into a regular Linux service
> > > > > 
> > > > > Because it calls preempt_disable(), which is not safe to be called
> > > > > form root domain, when runnning over 2.6.x on an architecture such
> > > > > as x86_32 which does not have IPIPE_HAVE_SAFE_THREAD_INFO.
> > > > > 
> > > > > Should we make the ftrace dispatching function really I-pipe
> > > > > compatible by calling ipipe_preempt_disable() in that case instead?
> > > > > or should we make the patch revert conditional to !IPIPE_LEGACY or
> > > > > IPIPE_HAVE_SAFE_THREAD_INFO (but that would make only the I-pipe
> > > > > tracer work in that case).
> > > > > 
> > > > 
> > > > I would go for the change which has the lesser impact on the mainline
> > > > code; that would be option #1.
> > > 
> > > Ok, now I get:
> > > 
> > >    12.958818] I-pipe: Detected stalled head domain, probably caused by a bug.
> > > [   12.958818]         A critical section may have been left unterminated.
> > > 
> > > I guess in the following sequence:
> > > 
> > > #define hard_preempt_disable()				\
> > > 	({						\
> > > 		unsigned long __flags__;		\
> > > 		__flags__ = hard_local_irq_save();	\
> > > 		if (__ipipe_root_p)			\
> > > 			preempt_disable();		\
> > > 		__flags__;				\
> > > 	})
> > > 
> > > preempt_disable() gets called with the head domain stalled, while
> > > current domain is root, and ipipe_root_only() treats this as an
> > > error.
> > 
> > So, I have disabled context checking around the call to
> > preempt_disable(), see the following patch, but the tracer overhead
> > becomes huge.
> 
> We get a lot of recursion, this is the probable cause of the
> overhead.

In summary: I think the shortest solution for now is to just revert
b115c4094d734e19fa7a96be1bf3958b3d244b8b

Using ftrace with I-pipe currently does not work. First there is the
problem of preempt_disable/preempt_enable with legacy, but there is
also the problem of recursion: if ftrace gets called again (for
instance if there is an irq) while in __ftrace_ops_list_func,
recursion is detected and nothing gets recorded. To convince
yourself that it does in fact, happen a lot, you can try the
following patch:

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f8b9472..35f6d0f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4894,9 +4894,16 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *op;
 	int bit;
 
+	if (ftrace_disabled)
+		return;
+
 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
-	if (bit < 0)
+	if (bit < 0) {
+		ftrace_disabled = 1;
+		printk("Recursion at %pF/%pF\n", (void *)ip, (void *)parent_ip);
+		ftrace_disabled = 0;
 		return;
+	}
 
 	/*
 	 * Some of the ops may be dynamically allocated,

To fix this, we would probably need some more bits in
trace_test_and_set_recursion, and some instrumentation of
the I-pipe core to detect the additional contexts (like say, "head 
domain in interrupt").

-- 
					    Gilles.
https://click-hack.org

