From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 11 Jun 2012 10:14:44 -0400
Message-ID: <20120611141444.GU32727@csclub.uwaterloo.ca>
References: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>
Subject: Re: [Xenomai] the Linux kernel and operating system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On Sat, Jun 09, 2012 at 01:43:37PM +0430, ali hagigat wrote:
> What kernel subsystems are effecting the real time functionality of an
> x86 PC system? Is there a complete list of the CONFIG_ variables
> regarding that for 2.6.38.8?

Well in general I would say that using an x86 PC to do real time can't
be done.  Most x86 PCs use SMI, which destroys any hope of actually
getting real time to provide any real response time promises.

Now if you happen to have a PC that doesn't use SMI, or can have it
disabled, then you can get real time.

On things that are not PCs this is pretty much never a problem.

There are some server vendors that provide information on turning off
SMI because they have customers that want to run real time software on
the machine.

-- 
Len Sorensen

