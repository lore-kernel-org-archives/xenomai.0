From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 6 Nov 2015 14:25:57 -0500
Message-ID: <20151106192557.GV21923@csclub.uwaterloo.ca>
References: <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
 <20151105172452.GQ21923@csclub.uwaterloo.ca>
 <20151105175225.GR21923@csclub.uwaterloo.ca>
 <20151105214042.GE31487@hermes.click-hack.org>
 <20151105220851.GU21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105220851.GU21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 05:08:51PM -0500, Lennart Sorensen wrote:
> On Thu, Nov 05, 2015 at 10:40:42PM +0100, Gilles Chanteperdrix wrote:
> > On Thu, Nov 05, 2015 at 12:52:25PM -0500, Lennart Sorensen wrote:
> > > I wish I could figure out why the backtraces aren't working, since they
> > > are such a nice debug feature to have.
> > 
> > You can try disabling unwinding, this should enable frame pointers
> > and maybe make the backtraces more reliable.
> 
> I can try that.  I always thought unwinding was part of making backtraces
> work.  Not sure why I thought so.

So I removed H_DMA from the alloc cal and the alignment problem went away.
Never actually did need the DMA flag in the case anyhow so it shouldn't
have been there in the first place.  Now while poking at it, I did find
that using H_NONCACHED instead causes a NULL pointer crash in the kernel,
which seems like a bug (how can user space making a system call cause
a NULL pointer dereference in the kernel unless there is a bug?).
With 0 for the flags, it just works.

-- 
Len Sorensen

