From: Steven Seeger <steven.seeger@nasa.gov>
Date: Tue, 3 Apr 2018 14:34:23 -0400
Message-ID: <2544472.VAFtTCK4Fx@wirbelwind>
In-Reply-To: <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
 <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Tuesday, April 3, 2018 2:31:38 PM EDT Lennart Sorensen wrote:
> On Tue, Apr 03, 2018 at 09:57:52AM -0400, Steven Seeger wrote:
> > I'm a little curious about the fact that the address this occurred at is
> > 0xc0003858, which suggests it's kernel code. As Philippe asked, what
> > version of the ipipe are you using? Also, what is your exact CPU? The
> > e300c2 does not have an FPU, so this would be quite a configuration
> > problem.
> 
> Did I miss e300c2 being mentioned?  If so, that would be a problem.

He did not mention the e300c2 but I just wanted to clarify. From a private 
email, it sounds like Sagi is working on a legacy product from before his time 
at the company that has periodically had this problem and required their 
customers to reboot it.

This brings back many "fond" memories of Gilles helping me chase down a 
similar bug on the Geode about ten years ago.

Sagi is using some extremely old stuff, so if he has the capability to put a 
fix in and recompile he might as well update the kernel if possible.

Steven




