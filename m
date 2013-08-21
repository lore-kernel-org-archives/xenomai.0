Message-ID: <52147DF2.8060407@xenomai.org>
Date: Wed, 21 Aug 2013 10:44:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52147CD7.70400@siemens.com>
In-Reply-To: <52147CD7.70400@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] x86 port to kernel 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 08/21/2013 10:39 AM, Jan Kiszka wrote:
> Hi all,
> 
> in the process of updating our kernel support to current (and long-term)
> stable 3.10, I've pushed the I-pipe master tree to that version. The
> tree is available at
> 
> git://git.xenomai.org/ipipe-jki.git next-x86
> 
> Though the focus is on x86, this became a full merge, ie. I also tried
> to resolve ARM and PowerPC conflicts (other archs had none). But I'm
> sure I broke some things (or things were already broken after the 3.9
> merge - there were suspicious unresolved conflicts). So these arch need
> a careful check! Specifically watch out for merges that resolved
> conflicts in their trees.
> 

I would prefer to have the conflict markers in the git tree, so that we
know where the conflicts occur. Having to browse history to find all the
merge conflicts seems more complicated than greping for '>>>'. Of
course, it means that when all the conflicts are resolved, the kernel
should be rebased to remove the commits with the merge conflicts, so as
to keep a bisectable kernel.

-- 
                                                                Gilles.

