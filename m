From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 22 Sep 2014 14:33:05 -0400
Message-ID: <20140922183305.GB13317@csclub.uwaterloo.ca>
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Hajian <saeid.hajian@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Sep 22, 2014 at 01:57:03PM -0400, Sam Hajian wrote:
> I am using ipipe-3.14 on ARM OMAP5 with dual core Cortex A15. When used
> IPIPE and LPAE turn on in kernel I get kernel exception. This is after
> fixing a compile issue in "arch/arm/mm/fault.c" to include
> "__ipipe_pin_range_globally".
> If not used LPAE all works fine, but I need that for KVM.
> I figured out the initial problems can be resolved if not used
> CONFIG_SLUB_DEBUG in mm/kernel, however I ran into another problem with
> invalid paging request as shown in second log below, which I think is the
> real problem. Any suggestion/help?

Yeah I saw the same thing.

It seems something in the memory setup isn't right when IPIPE is enabled
at the same time as LPAE.  You get a null pointer dererence.

-- 
Len Sroensen

