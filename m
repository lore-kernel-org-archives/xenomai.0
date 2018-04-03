Date: Tue, 3 Apr 2018 14:31:38 -0400
Message-ID: <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8214382.neGrAg1Q7R@wirbelwind>
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
To: Steven Seeger <steven.seeger@nasa.gov>
Cc: xenomai@xenomai.org

On Tue, Apr 03, 2018 at 09:57:52AM -0400, Steven Seeger wrote:
> I'm a little curious about the fact that the address this occurred at is 
> 0xc0003858, which suggests it's kernel code. As Philippe asked, what version 
> of the ipipe are you using? Also, what is your exact CPU? The e300c2 does not 
> have an FPU, so this would be quite a configuration problem.

Did I miss e300c2 being mentioned?  If so, that would be a problem.

> Are you using any kernel threads that use the FPU?

I would hope not.  Doing that is painful.

-- 
Len Sorensen

