Date: Tue, 29 Sep 2015 20:03:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929180345.GB18188@hermes.click-hack.org>
References: <20150909113151.0fed6fd7@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150909113151.0fed6fd7@md1em3qc>
Subject: Re: [Xenomai] 4.x merge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Wed, Sep 09, 2015 at 11:31:51AM +0200, Henning Schild wrote:
> Hi,
> 
> i am about to merge ipipe into a more recent kernel and would like to
> discuss the approach with you guys. As far as i have seen and been told
> i should merge and not rebase.
> 
> My current plan:
> 1 choose release (4.1 since its LTS)
> 2 merge it into ipipe
> 3 resolve obvious conflicts
> 4 commit broken merge
> 5 repair common bits and x86
> 6 publish my tree for others to repair other archs
> 
> Steps 2,3 and 4 might become iterations stepping over 3.19 and 4.0. The
> merges will not work but the smaller steps will result in less
> conflicts at a time.
> 
> What do you guys think of the approach? Are my version choices sane or
> are there any reasons to consider other releases as well?

I did not answer because I am not sure my opinion really matters. I
am only maintaining one architecture, and have not even worked on it
for a long time. And have already expressed this opinion several
times. But since you are asking for it:

- merging with mainline to maintain the modifications made by the
I-pipe tree is a bad solution: 
. first because it is more time consuming than what we did before,
that is reapplying the I-pipe patch and fixing the conflicts:
. second because the I-pipe changes get lost in the middle of the
upstream commits, so the idea that by doing this we could keep the
history of changes in the I-pipe tree does not work;
. third because when you do the merge, you can not easily ignore the
conflicts for the other architecture than the one you are currently
working on.

- merging by iterating over releases is even more time consuming: it
is far from exceptional to see the same piece of code changed by
several consecutive releases, with your method you get one conflict
by iteration, if you skip all the releases with one big iteration,
that means fixing only one conflict.

- I believe the right solution is to maintain the changes made by
the I-pipe tree as a stack of commits applied on top of the upstream
kernel, maintained with git. That means using git rebase to switch
from one release to the next, and amend each commit to fix the
conflicts. This way, every patch becomes a meaningful change to the
upstream kernel, we keep the history of changes, and they all appear
on top of the upstream commits, making them easy to identify in the
git logs. Splitting architecture specific patches allows every
architecture maintainer to focus on his architecture, and not have
to care about the other architecture commits. Note that I have
maintained the FCSE patch (split in something like 7 or 8 commits)
for several kernel releases, and I noticed no particular difficulty
doing so.


-- 
					    Gilles.
https://click-hack.org

