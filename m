Date: Fri, 31 Oct 2014 09:37:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141031083743.GF6828@sisyphus.hd.free.fr>
References: <5451FFA4.5030805@ma-info.de>
 <20141030091631.GD11210@sisyphus.hd.free.fr>
 <54523FFA.8020707@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54523FFA.8020707@siemens.com>
Subject: Re: [Xenomai] i-Pipi patch 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Oct 30, 2014 at 02:41:14PM +0100, Jan Kiszka wrote:
> On 2014-10-30 10:16, Gilles Chanteperdrix wrote:
> > On Thu, Oct 30, 2014 at 10:06:44AM +0100, Frede Florian wrote:
> >> Hello,
> >>
> >> I tried to patch the Kernel 3.14.22 and there is two new lines in
> >> the file fs/exec.c
> >>
> >> tsk->mm->vmacache_seqnum = 0;
> >> vmacache_flush(tsk);
> >>
> >> I am not sure if the line from the iPipe patch should placed before
> >> or after this lines...
> >>
> >> +    ipipe_mm_switch_unprotect(flags);
> > 
> > We do not have enough information to understand what you
> > are talking about. Show us the conflict as obtained with git merge
> > or with patch --merge to give us more information.
> 
> I've resolved the conflict with the vma caching that was back-ported to
> 3.14.x in ipipe-jki.git [1] (for-upstream/3.14 branch). Kernel works
> fine so far, but I didn't look into the details, if that caching thing
> affects us in the RT domain as well and requires more work.

Having looked rapidly at what this cache stuff is, I do not think it
does, since it affects the find_vma function mainly called when
taking page faults, all this happens in secondary mode, so, should
have no impact on RT domain. That said, there could be some detail
which breaks the I-pipe, of course.

-- 
					    Gilles.

