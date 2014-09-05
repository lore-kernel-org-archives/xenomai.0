From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 5 Sep 2014 15:14:47 -0400
Message-ID: <20140905191447.GO17690@csclub.uwaterloo.ca>
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <540A0A92.2000405@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540A0A92.2000405@xenomai.org>
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
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

On Fri, Sep 05, 2014 at 09:10:10PM +0200, Gilles Chanteperdrix wrote:
> On 09/05/2014 08:43 PM, Lennart Sorensen wrote:
> > I tried using --enable-debug with configure and it claims it did it,
> > but according to gdb, the resulting libraries do not have debug symbols.
> > 
> > I see -g added to the gcc line all over the place, except when libtool
> > does the final linking where for some reason it has disappeared (while
> > all other options appear to have made it through).
> > 
> > This is on powerpc.

I should have said 'this is armhf'.  Too many systems in use.

> > Any ideas?
> > 
> run the "file" utility on the library to see whether or not it has
> debugging information.

file says 'dynamically linked, not stripped'.

gdb says 'no debug symbols' for the xenomai libraries, but it does see
them for libc and others.

-- 
Len Sorensen

