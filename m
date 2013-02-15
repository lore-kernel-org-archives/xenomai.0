Message-ID: <511DF744.7090402@xenomai.org>
Date: Fri, 15 Feb 2013 09:52:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAA+HEuk86rVdKy1DDWmzRGjpvNkDpVsAmG+H-R4mg1Bu2RLy+A@mail.gmail.com>
	<511BEACC.5030705@xenomai.org>
	<CAA+HEukK5Abf5V1DSu0UN+hpDBXJokdZ9aqTP6HR9wepCn6dRg@mail.gmail.com>
	<511D3366.6020504@xenomai.org>
	<CAA+HEu=As3DV+adh9SzHaGj7aVDPttGxHMvf_Wpib53zOA2Ppw@mail.gmail.com>
In-Reply-To: <CAA+HEu=As3DV+adh9SzHaGj7aVDPttGxHMvf_Wpib53zOA2Ppw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfault error 4 when running latency test (and all
 userspace tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kris Ellis <drfrankencopter@gmail.com>
Cc: xenomai@xenomai.org

On 02/14/2013 08:32 PM, Kris Ellis wrote:
> Thanks, I'll look into your buldroot generator.
>

Well, actually this was a wrong advice, at least with respect to using 
buildroot: that generator does not use BR2, only the one I'm using 
locally does. But I had to hack the Xenomai support in BR2's 2010.02 
release, which you do have built-in now in the latest one.

> I have not tried using gdb yet, so I have no backtrace that I can provide.
>

This would help.

> As far as the --enable-x86-sep flag is concerned, is there a place in
> buildroot to turn this on, or do I have to go and manually modify the
> xenomai.mk file?
>

You need to fix up XENOMAI_CONF_OPT manually. I suspect that you might 
have a kernel compiled for a CPU which does not provide SEP, with the 
userland code configured by default with --enable-x86-sep.

So I would try check this first, prior to pulling more hairs:

First, log in your target box, and check whether /proc/cpuinfo mentions 
"sep" as an available feature for your processor. If not, then either:

- fix your i386 CPU configuration for the kernel and rebuild it, 
assuming your CPU does have sep actually (this is the most likely 
option), leaving userland as it is.

- Fix up XENOMAI_CONF_OPT to add --disable-x86-sep and rebuild userland, 
leaving the kernel config as it is.

To speed up things, I would suggest to try out these tests with no BR2 
in the picture for now, using a plain configure+build sequence for Xenomai.

-- 
Philippe.

