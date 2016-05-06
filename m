From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 6 May 2016 11:17:20 -0400
Message-ID: <20160506151720.GH3264@csclub.uwaterloo.ca>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, May 06, 2016 at 03:04:03PM +0000, Umair Ali wrote:
> Hello gilles,
> 
> Thanks for the patience and the reply. I am sorry for asking such questions. I am newbie so need some guidance. I have searched for linux device drivers on the internet and I found the book (https://lwn.net/Kernel/LDD3/) . Can you recommend me which chapter will be very helpful for me. I want to read a big file of size 600MB in kernel space and need to read it periodically by timers. I think the answers lies in the using functions rtdm_malloc, rtdm_safe_copy_from _user. I know the good way to is open the file in the userspace and send the address to kernel space. Any example will help me a lot. 

Well my understanding is that you do NOT ever read files from kernel
space.  You let user space do that and pass the data.

This doesn't mean it can't be done, just that the kernel maintainers
seem quite insistent that you don't do file access from kernel space.

Certainly doing file access sounds like something you would not want to
try and do from the realtime side of things.  You probably can't.

-- 
Len Sorensen

