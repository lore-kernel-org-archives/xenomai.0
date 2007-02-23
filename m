From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702220127.28527.paul_c@domain.hid>
References: <200702212030.41554.paul_c@domain.hid>
	<1172104922.3551.122.camel@domain.hid>
	<200702220127.28527.paul_c@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 16:43:26 +0100
Message-Id: <1172245406.26738.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] x86_64 ipipe on 2.6.19
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
To: Paul <paul_c@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai@xenomai.org

On Thu, 2007-02-22 at 01:27 +0000, Paul wrote:
> On Thursday 22 February 2007 00:42, Philippe Gerum wrote:
> > On Wed, 2007-02-21 at 20:30 +0000, Paul wrote:
> > > Hi Philippe
> > >
> > >  After compiling the current git sources for x86_64 on 2.6.19 and failing
> > > miserably to boot under qemu, I finally tried on a live box - An AMD64
> > > X2.
> >
> > I can also boot it under qemu (0.8.2) here, actually this is how I wrote
> > the basic Adeos support before switching to real hw. Could you send me
> > some boot log and .config? Maybe a bug is sleeping that triggers with
> > your configuration and that doesn't with mine.
> 
> Should point out that booting a stock virgin 2.6.19 kernel also fails under 
> qemu, so I'm not pointing fingers at the ipipe patch..

This said, the I-pipe patch suffers from a silly bug causing infinite
recursion when CONFIG_SMP + CONFIG_PREEMPT + CONFIG_DEBUG_PREEMPT are
all enabled. The patch below fixes it:

--- a/include/asm-x86_64/ipipe.h
+++ b/include/asm-x86_64/ipipe.h
@@ -93,7 +93,7 @@

 /* The logical processor id is read from the PDA, so this is always
  * safe, regardless of the underlying stack. */
-#define ipipe_processor_id()  smp_processor_id()
+#define ipipe_processor_id()  raw_smp_processor_id()

 #else  /* !CONFIG_SMP */

-- 
Philippe.



