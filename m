Date: Sat, 4 Apr 2015 15:56:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150404135615.GC18543@hermes.click-hack.org>
References: <CAJqUr7yKoXNCpEZ0_oo=U9koMyido2G1kxF5HPupvrvBkadjtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqUr7yKoXNCpEZ0_oo=U9koMyido2G1kxF5HPupvrvBkadjtQ@mail.gmail.com>
Subject: Re: [Xenomai] tsc on armv8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>
Cc: xenomai@xenomai.org

On Fri, Apr 03, 2015 at 01:45:41PM -0700, Don Mahurin wrote:
> Hi,
> 
> A few questions about tsc as it relates to armv8.
> 
> 1. armv8 has a 64 bit system counter register CNTPCT_EL0 (system counter
> frequency get/set with CNTFRQ_EL0). May this be used as a replacement for
> the arm tsc emulation. If so, should we use another architecture to model
> the implementation?
> (the count value is "at least 56 bits wide" according to spec and zero
> padded to 64 bits. is the counter still sufficient?)

I believe cortex A15 has the same counter, and this is what I-pipe
uses. About the tsc architecture on ARM, it was made to allow the
different counters available on different arm processors while
keeping a unique kernel/user ABI. If the counter you are talking
about is guaranteed to be available on all armv8 based processors
and you are sure nobody will ever want a better counter (from what I
could test on cortex a15, this counter has a rather low resolution,
around 1us), then you can avoid the arm tsc architecture altogether.

> 
> 
> 2. Is a tsc implementation strictly required to test basic i-pipe
> functionality. I understand that a configuration without
> CONFIG_IPIPE_ARM_KUSER_TSC is not currently supported on arm

if !IPIPE_ARM_KUSER_TSC was not supported, this symbol would not be
needed. !IPIPE_ARM_KUSER_TSC is supported, if you do not set this
symbol, you have to provide the tsc emulation function. All this is
explained in the ARM porting guide.


> (which we are basing the arm64 port upon), but what is the minimum
> tsc functionality that needs to be implemented for basic i-pipe
> functionality. (Can some functions be stubbed initially?)

Xenomai timers management needs a high resolution counter. The same
high resolution counter needs to be available in user-space,
preferably without a system call, and for proper implementation of
CLOCK_HOST_REALTIME, needs to also be used by Linux.

When you will want to run the "latency" test to test that the
xenomai timer is working correctly, you will need this high
resolution counter.

-- 
					    Gilles.

