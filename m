From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 6 May 2016 13:48:08 -0400
Message-ID: <20160506174808.GI3264@csclub.uwaterloo.ca>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
 <20160506151720.GH3264@csclub.uwaterloo.ca>
 <2396B4D2166B62479FBBE370D4A7C1F30A733234@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A733234@mb2010-3.intra.tut.fi>
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

On Fri, May 06, 2016 at 03:25:36PM +0000, Umair Ali wrote:
> Thanks Len Sorensen
> 
> > Well my understanding is that you do NOT ever read files from kernel space.  You let user space do that and pass the data.
> 
> >This doesn't mean it can't be done, just that the kernel maintainers seem quite insistent that you don't do file access from kernel space.
> 
> What I am doing is as follows
> - Open the file and mapped the file using mmap() in the user space in real time.
> -  a kernel module is running in the back ground with timer initialized
> -  run the application in user space and pass the mmap pointer along with the size of file to the kernel module by using the read() function to read the device.
> - In the read_rt thread of module the pointer of the mapped file is assigned to the global  char pointer and timer is started.
> - The timed function is using the global char pointer to access file but fails when the read_rt ends
> - Meanwhile the user space app is also ended after passing the pointer and file size.
> 
> Is there any way I can copy the data of mmap from userspace to a buffer in kernel or any virtual address so I can use the data over and over even though the user app is ended. Because timer is running in the back end and need to read the file again and again.

Well doing mmap only means you can pretend the file is in memory.
It does not mean all of it or even any of it is at any time, unless you
use MAP_LOCKED and mlock.

And if the file is mmap'd why would you need to reread it?  What is
changing the file and why is it not using mmap too so that you see
changes instantly?

-- 
Len Sorensen

