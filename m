From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 5 Sep 2014 14:43:46 -0400
Message-ID: <20140905184346.GN17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] How to get debug symbols in xenomai libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I tried using --enable-debug with configure and it claims it did it,
but according to gdb, the resulting libraries do not have debug symbols.

I see -g added to the gcc line all over the place, except when libtool
does the final linking where for some reason it has disappeared (while
all other options appear to have made it through).

This is on powerpc.

Any ideas?

-- 
Len Sorensen

