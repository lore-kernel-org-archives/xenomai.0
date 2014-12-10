From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 15:11:40 -0500
Message-ID: <20141210201140.GL24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca>
 <5488A985.2070006@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5488A985.2070006@xenomai.org>
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

On Wed, Dec 10, 2014 at 09:13:57PM +0100, Philippe Gerum wrote:
> The point is about being able to discuss issues without starting useless
> rants or flame wars.

I was not trying to.  I think I was getting frustrated chasing around
git trees wondering why I could not figure out where the change came from.

> The I-pipe interface was moved to GPL_ONLY to clearly state that such
> code intimately depends on the kernel innards, has to know about them to
> function, and therefore any client code has to be GPL-compatible to
> comply with the kernel license.

Well I think most of the interfaces were already GPL only even in 2.6.36
from what I can tell, so nothing new there.

> The only question that matters is: does __ipipe_root_status belong to
> the visible I-pipe API exposed to clients? The answer from the copyright
> holder of this particular code is "no".

Oh good, because I was having trouble seeing how it was part of the
ipipe interface.

> Ah, maybe it was a mistake then, something that was overlooked, just
> because I-pipe maintainers don't routinely have to rebuild non-GPL
> software on top the I-pipe? Yes, most likely it was.

I would not expect that to be a normal procedure.  Would be a pain to do.

> Could the code be changed to fix this, then? Yes, it sounds reasonable,
> and would not change the original intent of moving the API symbols to
> GPL_ONLY.
> 
> The issue is non-ambiguous, the solution is straightforward. Let's
> relax, there is work ahead.

Should I do a test build with it changed to at least confirm if that is
the only issue?

I tried comparing a 3.1 versino of core.c to a 3.5 version and they are
certainly changed a lot.  For the symbol here It went from:

/*
 * Create an alias to the unique root status, so that arch-dep code
 * may get simple and easy access to this percpu variable.  We also
 * create an array of pointers to the percpu domain data; this tends
 * to produce a better code when reaching non-root domains. We make
 * sure that the early boot code would be able to dereference the
 * pointer to the root domain data safely by statically initializing
 * its value (local_irq*() routines depend on this).
 */
#if __GNUC__ >= 4
extern unsigned long __ipipe_root_status
__attribute__((alias(__stringify(ipipe_percpu_darray))));
EXPORT_SYMBOL(__ipipe_root_status);
#else /* __GNUC__ < 4 */
/*
 * Work around a GCC 3.x issue making alias symbols unusable as
 * constant initializers.
 */
unsigned long *const __ipipe_root_status_addr =
        &__raw_get_cpu_var(ipipe_percpu_darray)[IPIPE_ROOT_SLOT].status;
EXPORT_SYMBOL(__ipipe_root_status_addr);
#endif /* __GNUC__ < 4 */

and become:

/*
 * Create an alias to the unique root status, so that arch-dep code
 * may get fast access to this percpu variable including from
 * assembly.  A hard-coded assumption is that root.status appears at
 * offset #0 of the ipipe_percpu struct.
 */
extern unsigned long __ipipe_root_status
__attribute__((alias(__stringify(ipipe_percpu))));
EXPORT_SYMBOL_GPL(__ipipe_root_status);


So certainly cleaner after getting rid of support for old GCC versions
and such.

-- 
Len Sorensen

