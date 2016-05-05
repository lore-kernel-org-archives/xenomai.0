From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 May 2016 14:38:18 -0400
Message-ID: <20160505183818.GB3264@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Possible missing symbol export in powerpc ipipe 4.1?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In 3.10 and 3.14 ipipe patches for powerpc, there was an
EXPORT_SYMBOL_GPL(do_munmap);
in arc/powerpc/kernel/ipipe.c

In 3.18 and 4.1 for powerpc that is gone, but x86 and arm still have it.

Sure xenomai-3 doesn't use it, but xenomai 2.6 does and it seems to be
the only thing preventing compiling xenomai-2.6 on 4.1 kernel (arm built
and ran fine for me so far, while powerpc is missing just that one
symbol).

Any reason it was removed from powerpc but not arm and x86?  Any reason
not to put it back for powerpc?

-- 
Len Sorensen

