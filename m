From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 16:23:42 -0500
Message-ID: <20141210212342.GO24110@csclub.uwaterloo.ca>
References: <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca>
 <5488A985.2070006@xenomai.org>
 <20141210201140.GL24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210201140.GL24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 03:11:40PM -0500, Lennart Sorensen wrote:
> On Wed, Dec 10, 2014 at 09:13:57PM +0100, Philippe Gerum wrote:
> > The point is about being able to discuss issues without starting useless
> > rants or flame wars.
> 
> I was not trying to.  I think I was getting frustrated chasing around
> git trees wondering why I could not figure out where the change came from.
> 
> > The I-pipe interface was moved to GPL_ONLY to clearly state that such
> > code intimately depends on the kernel innards, has to know about them to
> > function, and therefore any client code has to be GPL-compatible to
> > comply with the kernel license.
> 
> Well I think most of the interfaces were already GPL only even in 2.6.36
> from what I can tell, so nothing new there.
> 
> > The only question that matters is: does __ipipe_root_status belong to
> > the visible I-pipe API exposed to clients? The answer from the copyright
> > holder of this particular code is "no".
> 
> Oh good, because I was having trouble seeing how it was part of the
> ipipe interface.
> 
> > Ah, maybe it was a mistake then, something that was overlooked, just
> > because I-pipe maintainers don't routinely have to rebuild non-GPL
> > software on top the I-pipe? Yes, most likely it was.
> 
> I would not expect that to be a normal procedure.  Would be a pain to do.
> 
> > Could the code be changed to fix this, then? Yes, it sounds reasonable,
> > and would not change the original intent of moving the API symbols to
> > GPL_ONLY.
> > 
> > The issue is non-ambiguous, the solution is straightforward. Let's
> > relax, there is work ahead.
> 
> Should I do a test build with it changed to at least confirm if that is
> the only issue?

So a test build with just this:

--- linux-3.12.33.rr1.orig/kernel/ipipe/core.c  2014-12-10 15:16:41.045125486 -0500
+++ linux-3.12.33.rr1/kernel/ipipe/core.c       2014-12-10 15:16:43.189141150 -0500
@@ -93,7 +93,7 @@
  */
 extern unsigned long __ipipe_root_status
 __attribute__((alias(__stringify(ipipe_percpu))));
-EXPORT_SYMBOL_GPL(__ipipe_root_status);
+EXPORT_SYMBOL(__ipipe_root_status);
 
 #endif /* !CONFIG_SMP */

in fact makes the module compile again.

So changing the one symbol back to what it was pre 3.2 would certainly
help a lot.

-- 
Len Sorensen

