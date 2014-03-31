From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 14:24:04 -0400
Message-ID: <20140331182404.GP17765@csclub.uwaterloo.ca>
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5339B015.3080008@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 08:12:37PM +0200, Gilles Chanteperdrix wrote:
> On what platform do you get this? If on cortex A8, and the
> user-space is compiled in thumb2 mode, note that an erratum
> workaround is needed, flushing the BTB at each context switch to
> avoid problem when ARM code is replaced by THUMB code at the same
> (virtual) address when switching context.

Cortex-A15 (Omap5 system).  User space is thumb2 (Debian Wheezy armhf
based).

> My advice would be to wait, Philippe is currently merging the I-pipe
> git with 3.14 (you can actually find the 3.12 merge in my git tree,
> under the branch raw/for-ipipe-3.12.0, it has been lightly tested
> though, as I wait for 3.14 to be ready to test more thoroughly).

Unfortunately the drivers are not fully merged upstream yet, so I am
using the 3.12 branch from ti's git tree.  I was able to boot 3.14 but
without ethernet and usb and a few other things.

Comparing the ipipe changes for 3.14 would be useful though.

I only saw 3.11 raw in the tree when I was doing that part on thursday.
Is this new?  Or did I look in the wrong git tree?  No, I did a pull,
and it is there now.  I guess I was a day or two early. :)

> If you can not wait, then you can enable CONFIG_DEBUG_USER, and pass
> user_debug=29 on the kernel command line, to have a complete a dump
> upon fault (and notably in the case of SIGILL). You can also extend
> this dump by using a hack done in the FCSE patch to print the
> equivalent of a dump of /proc/self/maps with markers indicating
> where the PC, SP, and fault address are when a fault occurs.

That sounds worth trying.

-- 
Len Sorensen

