From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Jun 2015 15:40:21 -0400
Message-ID: <20150610194021.GF17436@csclub.uwaterloo.ca>
References: <20150610191131.GD17436@csclub.uwaterloo.ca>
 <20150610191937.GE17436@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150610191937.GE17436@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Odd posix thread bug in xenomai 2.6.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wed, Jun 10, 2015 at 03:19:37PM -0400, Lennart Sorensen wrote:
> On Wed, Jun 10, 2015 at 03:11:31PM -0400, Lennart Sorensen wrote:
> > I have encountered a kernel crash in the xeno_posix.  I end up with a
> > k_tid of 0x0000000c which is of course not valid.
> > 
> > So far I have tracked it down to here:
> > 
> >         /* We need an anonymous registry entry to obtain a handle for fast
> >            mutex locking. */
> >         ret = xnthread_register(&thread->threadbase, "");
> >         if (ret) {
> >                 thread_destroy(thread);
> >                 return ret;
> >         }
> > 
> > So if xnthread_register fails, it returns -12, but since the callers
> > to pthread_create all expect (as documented) for the return value of
> > pthread_create to be 0 or positive, getting -12 is bad since that is
> > then inverted by the caller to make it negative and returned and is then
> > treated as a valid k_tid which it isn't.
> > 
> > I think -12 means ENOMEM, so clearly I have another config error (or bug)
> > to fix to solve that.  But still pthread_create should probably be doing
> > 'return -ret' in this case.  I suspect I did something stupid to even
> > hit this case, so quite likely it just hasn't been hit before and hence
> > not noticed.
> > 
> > This is the only place in pthread_create that could return a negative
> > value too.
> 
> And I had in fact got the memory settings in xenomai wrong in my new
> kernel build.  I expect once I fix those, I won't get ENOMEM anymore,
> and hence won't hit this bug anymore.  Off to test that.

And the test passed.  So fixing the sign of the return code fixes the bug,
and fixing the heap size solves the cause of even triggering the bug.

Would you like a proper patch submission, or will someone just fix
that line?

-- 
Len Sorensen

