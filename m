Date: Wed, 4 Apr 2018 10:45:48 -0400
Message-ID: <20180404144548.uz5zts6chla6hhob@csclub.uwaterloo.ca>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
 <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
 <e6b33545f46048ada70f0e10863bf3b4@advaoptical.com>
 <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
 <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Apr 04, 2018 at 12:57:31PM +0000, Sagi Maimon wrote:
> HI,
> I did it only from Linux side.
> I can try doing it from xenomai side too.
> Please explain how would it help to investigate the problem?

As far as I recall the kernel alignment fixup is only allowed from linux
mode since it uses linux kernel code.  The realtime side as far as I
recall can't use it.  So if my memory is correct, any code running
in the xenomai realtime part must do everything right and not trigger
those exceptions.

What CPU is this?  What does /proc/cpuinfo say it is?

-- 
Len Sorensen

