From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 20 Jan 2016 16:42:04 -0500
Message-ID: <20160120214204.GV25177@csclub.uwaterloo.ca>
References: <CABShy45=exDb7kmYXMZHUoEtwgeF_Qw7kXNb2Oh-Eq01fo4kPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABShy45=exDb7kmYXMZHUoEtwgeF_Qw7kXNb2Oh-Eq01fo4kPw@mail.gmail.com>
Subject: Re: [Xenomai] Hi friend if we are not having beaglebone black
 hardware then how can i check xenomai rtos rtdm driver for beaglebone black
 any simulator or emulator is available to test virtually xenomai rtos rtdm
 driver if any solution for that then please tell me it is very important
 for my project ; thank you
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

On Sun, Jan 17, 2016 at 04:24:18PM +0530, BHISHMAPALSINH THAKOR wrote:
> Hi friend  if we are not having beaglebone black  hardware then how can i
> check xenomai rtos rtdm driver for beaglebone black any simulator or
> emulator is available to test virtually xenomai rtos rtdm driver if any
> solution for that then please tell me it is very important for my project ;

I highly doubt there exists a simulator for the beaglebone black, unless
texas instruments happens to have one in their IDE if you pay for the
higher end version.  No idea.

Linaro's branch of qemu can apparently emulate some of the beagleboard
and beagleboard-xm, but not everything, which is close to a beagleboard
but not the same.  It uses an OMAP3530 while the beaglebone is an AM335x.
The OMAP doesn't have PRUs and a number of other features of the AM chip,
not that I think QEMU would emulate any of them anyhow.

-- 
Len Sorensen

