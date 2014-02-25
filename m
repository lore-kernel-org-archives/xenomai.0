Message-ID: <530CD8B9.2010303@xenomai.org>
Date: Tue, 25 Feb 2014 18:54:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Road to 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Hi,

This is the remaining work toward 3.0 from my perspective. Please 
comment, amend, extend or shatter as needed.

- RTDM
	* decide and freeze API changes.
	* the native implementation may need some care and testing, we never 
had any feedback for this code.
	* fixup of in-tree drivers for API changes

- Analogy
	* comedi drivers still in the staging tree for mainline vs porting the 
Analogy framework over the mercury core.

- Alchemy needs more test cases, although all core features are covered 
by at least one test already - except messages pipes. This latter 
interface is now a plain wrapper on top of rtipc/xddp though.

- Documentation
	* the inline documentation for the Cobalt kernel was amended gradually 
as development took place, but we still have a general review and 
cleanup duties ahead for this material.
	* Copperplate is not documented yet. Only API designers would need this 
though.
	* User guide for 3.x.
	* Review, fixup of the new migration and installation guides.
	* website updates for 3.x. We may want to fork the documentation area 
in two distinct zones, for 2.x and 3.x, otherwise I suspect that many 
people will get utterly confused.

- /proc/xenomai refactoring for Cobalt. With most APIs now implemented 
in userland and the introduction of the new fuse-based registry, 
/proc/xenomai/registry does not contain much these days. In fact, only 
the RTIPC drivers can still create links there.

It boils down to this question: will the POSIX core introduce new 
registry files, or will RTDM-based code remain the only in-kernel 
registry user?

- I pulled out the examples area during the early development days, it 
is time to push some demo code back in, preferably that would work over 
both Cobalt and Mercury cores indifferently.

- nios2 and sh4 over Cobalt are lagging behind, basically because we 
would need a 3.10+ reference kernel for implementing the proper pipeline 
bits 3.x requires, which we don't have. I'll be looking for such kernel 
for supporting nios2 at some point. I'm unsure for sh4: no hardware at 
hand, and most importantly, nobody seemed to care about running Xenomai 
over this architecture.

- running the Copperplate layer over uClibc instead of glibc. Last time 
I tried (a couple of years ago), several nightmare-class issues popped 
up. The question is: do we still need this, is it worth the effort, or 
can we reasonably make glibc a pre-requisite for running non-POSIX APIs 
in dual kernel (i.e. Cobalt) mode? Blackfin and nios2 were the primary 
users of Xenomai's uClibc compatibility in 2.x.

- any change that would be pending to the pipeline core API. If you have 
any brewing or to be suggested, now is a good time to speak up.

- The vrtx and uITRON APIs have not been rewritten over the copperplate 
layer yet. Given that we received no valuable feedback over the years 
for these skins, I don't see the point in implementing this today.

- Finally, I have a series of 130+ specific implementation 
changes/issues for the -forge tree pending in my todo list. Nothing 
really bad or difficult, only a truckload of details.

I'm refraining from indicating any priority for these tasks, since this 
should be part of the discussion. A distinction between what's available 
for the first candidate release and the final one may make sense.

-- 
Philippe.

