From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 10 Aug 2015 11:53:39 -0400
Message-ID: <20150810155339.GF29198@csclub.uwaterloo.ca>
References: <20150810142907.GE29198@csclub.uwaterloo.ca>
 <55C8C423.4080202@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C8C423.4080202@xenomai.org>
Subject: Re: [Xenomai] Bad pointer in __ipipe_pin_range_globally
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Aug 10, 2015 at 05:32:51PM +0200, Philippe Gerum wrote:
> On 08/10/2015 04:29 PM, Lennart Sorensen wrote:
> > Seeing occational crashes in the function __ipipe_pin_range_globally,
> > and wondering what that might be caused by.
> > 
> > Kernel is 3.14.47 on AM5726 CPU (Dual cortex-A15), with the 3 level page
> > table LPAE support enabled.  Xenomai 2.6.4.  Ipipe patch
> > ipipe-core-3.14.39-arm-10.
> > 
> > I see a few things in the ipipe git tree that are since
> > ipipe-core-3.14.39-arm-10 is before some more recent 3.14.x merges
> > were done, so perhaps I will give the git tree updates a try to see if
> > that helps.
> > 
> > Does anyone have any idea what this might be:
> > 
> 
> This is a SMP-specific issue recently seen on imx6q and imx7d. PTE
> pinning would need a stronger synchronization with the vm code to solve
> this random corruption.
> 
> However, it turns out that we don't need PTE pinning on armv6k and
> armv7+ CPUs, since the cost of taking an address translation trap for
> fixing up a minor fault there is negligible compared to tracking the
> PGDs, and does not entail a switch to secondary mode for the caller
> anymore. As a bonus, disabling PTE pinning removes overhead when the
> kernel creates dynamic mappings.
> 
> PTE pinning is sane and required on earlier arm architectures running
> uniprocessor systems though, where the penalty for handing a translation
> trap is noticeable.
> 
> To sum up, for that TI SoC, you should pick the commits disabling PTE
> pinning from 3.10, 3.14 or 3.18.

Hmm, do you have a commit number for that.  I don't seem to see it in
ipipe-3.14 branch as far as I can tell.  Or maybe I am looking on the
wrong tree.

-- 
Len Sorensen

