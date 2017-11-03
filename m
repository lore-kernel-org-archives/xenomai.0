Date: Fri, 3 Nov 2017 13:59:50 -0400
Message-ID: <20171103175950.lixjbhqp4op4jm6j@csclub.uwaterloo.ca>
References: <CAOocw5vJ_nz41_vqqV0e=+BgE+6u-6hYhXVpCFPuzqCh4QPp9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOocw5vJ_nz41_vqqV0e=+BgE+6u-6hYhXVpCFPuzqCh4QPp9Q@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Running COBALT on Ubuntu 14/16
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Danrae Pray <danrae.pray@metecs.com>
Cc: xenomai@xenomai.org

On Fri, Nov 03, 2017 at 12:24:36PM -0500, Danrae Pray wrote:
> I am trying to understand how the COBALT kernel is designed and how it can
> be installed side-by-side various linux distro kernels (Gentoo, Ubuntu,
> etc).
> 
> During the COBALT kernel build process on Ubuntu, for example, we actually
> pull a kernel version (based on your Ubuntu version) and build it:
> 
> https://stackoverflow.com/questions/41949678/installation-steps-for-xenomai-3-on-ubuntu-16-04
> https://xenomai.org//installing-xenomai-3-x/#Configuring_and_compiling_the_Cobalt_kernel
> 
> So, I guess my questions are:
> 
> 1) At the end of the COBALT build / installation procedure as well as
> installing the Xenomai libs/tools, can I actually use Xenomai in the
> dual-kernel config on Ubuntu on my desktop PC for testing application
> logic?  i.e. I don't need to actually boot my machine using the newly built
> image or something...

You have to be running that kernel.

> 2) Why are we building a linux kernel during the COBALT build process?  Is
> COBALT actually a modified linux kernel itself?

Yes it is.  The kernel is patched with ipipe and xenomai extensions to
provide the required features.

-- 
Len Sorensen

