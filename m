References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org>
 <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55DCB74C.50400@xenomai.org>
Date: Tue, 25 Aug 2015 20:43:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>
Cc: xenomai@xenomai.org

On 08/25/2015 08:05 PM, Don Mahurin wrote:
> On Tue, Aug 25, 2015 at 7:08 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     This is likely because -rc7 has added checks to sched-* tests which have
>     time-dependent results, so they may not match the expected value in a
>     qemu-based execution.
> 
> 
> Would it be worthwhile to optionally disable the time-dependent nature
> of the tests, just for use in quick/automated emulator testing?
>  

I believe so. We should probably have smokey accept a --vm option or
something along, to tell it about a virtual execution environment, which
may be freely interpreted by any test code concerned, e.g. to figure out
whether timings might be inaccurate due to a significant slowdown. We
could likely figure this out automatically, but I'd rather leave this
decision to the user. I'll have a look at this asap.

> 
> In general, how should we proceed with arm64 changes?  We can continue
> to make updates in the separate repos.  But is there anything we need to
> do to get a thorough review of the changes by the community and get this
> incorporated into upstream xenomai/ipipe? 
> 

I will open dedicated arm64 branches tomorrow into the project
repositories for both the ipipe and xenomai, that could be merged to the
corresponding mainline branches when ready for prime time. The target
would be Xenomai 3.1, it's too late for bringing this in 3.0-rc.

So the process should be fairly common and straightforward: a pull
request from your end for code present in your repo would trigger the
review, bits getting merged gradually from your repo to the dedicated
arm64 branches, along with other contributions, until we can all declare
these branches ready for mainline.

-- 
Philippe.

