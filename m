From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 26 Mar 2015 20:13:31 -0400
Message-ID: <20150327001331.GB29558@csclub.uwaterloo.ca>
References: <CAJqUr7w6OZ+kcYp7mFg9OPD0AKuXXDDdLQBCAHQiuxKcG5A=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqUr7w6OZ+kcYp7mFg9OPD0AKuXXDDdLQBCAHQiuxKcG5A=hA@mail.gmail.com>
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>
Cc: xenomai@xenomai.org

On Thu, Mar 26, 2015 at 03:58:12PM -0700, Don Mahurin wrote:
> Another basic question regarding this porting effort:
> 
> Before any arm64 specific changes or platform specific changes, would
> just merging the i-pipe patch/tree (merging ipipe-3.10 into the vendor
> kernel for instance) be expected to boot, with CONFIG_IPIPE not set?
> Or will that lead to undefined results?

I have yet to ever have a kernel with ipipe patches applied that could
be compiled with CONFIG_IPIPE disabled.  I always have to remove the
ipipe and xenomai patches if I want to test without them.  I imagine
that for some architectures with some kernel versions it had worked,
but it seems in general it doesn't.  It just isn't a priority to test
that configuration I suspect.

-- 
Len Sorensen

