Date: Thu, 17 Sep 2015 14:39:55 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150917143955.01a71eb6@md1em3qc>
In-Reply-To: <20150915104854.56a7b13f@md1em3qc>
References: <20150909113151.0fed6fd7@md1em3qc> <55F02DB0.1090801@xenomai.org>
 <20150915104854.56a7b13f@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.x merge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, 15 Sep 2015 10:48:54 +0200
Henning Schild <henning.schild@siemens.com> wrote:

> Hey guys,
> 
> i now have a working 3.19 kernel that passed basic testing on x86. I
> guess it is ready to be tested on other archs, where it might not even
> compile. I did my best to resolve conflicts and hope it is pretty
> close to working.
> 
> I actually decided to merge mainline step by step. When i got merge
> conflicts i aborted big merges and narrowed down the conflicts to
> merging single commits/series. That resulted in about 180 commits,
> mostly merges. 
> 
> I think that big amount of commits is actually useful for others too,
> so i would like to share it somehow. When testing arm or powerpc you
> can bisect in that and when you find a broken merge commit you will
> know exactly which patches from mainline caused the problem.
> 
> Whether we want hundreds of merge commits in the main ipipe-repo in
> the end is something we could discuss. The merge could be condensed
> down to one commit to clean up. But i am generally all for keeping
> history.
> 
> Please let me know where i could best push my changes. As we speak
> here i am already using the same partial-merge technique for 4.0
> until i arrive at 4.1. It seems to be a pretty good way of keeping up
> with mainline.

I did push my current state to github. Check out 
https://github.com/siemens/linux-ipipe
branches ipipe-3.19 and -4.0

The xenomai repos also require patching if you want to use these newer
kernels. I will send the required patches as a reply to this mail.

Henning

