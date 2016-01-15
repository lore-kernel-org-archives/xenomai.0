From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 15 Jan 2016 11:22:53 -0500
Message-ID: <20160115162253.GS25177@csclub.uwaterloo.ca>
References: <CABShy45=tZFAjtNNMsZTk3w88MKJ329s-BiMeEHef9QXppTjTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABShy45=tZFAjtNNMsZTk3w88MKJ329s-BiMeEHef9QXppTjTA@mail.gmail.com>
Subject: Re: [Xenomai] Why xenomai rtos is not well supported for
 microcontroller based board like lpc 2148 and stm32f3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: BHISHMAPALSINH THAKOR <bjthakor.337@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Jan 15, 2016 at 04:43:34AM +0530, BHISHMAPALSINH THAKOR wrote:
> Why xenomai rtos is not well supported for microcontroller based board like
> lpc 2148 and stm32f3

Xenomai is real time extentions for linux.  If you have a tiny
microcontroller that does not run normal linux, then xenomai almost
certainly can't help you.  Xenomai is not a complete OS by itself.

Apparently the large stm32 chips can run uclinux and certainly some
people have run xenomai with uclinux, so if you have a large stm32,
it might be an option, although not sure if it is supported or would
need to be ported to the ARM Cortex-M4.

-- 
Len Sorensen

