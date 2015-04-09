Date: Thu, 9 Apr 2015 17:05:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150409150506.GE20752@hermes.click-hack.org>
References: <CAKKWdtcq_Cj7keL4rkpsLwUX1zHg7Cu0CQUwEYAG=o5ZUbPCJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKWdtcq_Cj7keL4rkpsLwUX1zHg7Cu0CQUwEYAG=o5ZUbPCJQ@mail.gmail.com>
Subject: Re: [Xenomai] clocktest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Apr 07, 2015 at 04:43:18PM +0430, ali hagigat wrote:
> What are the meanings of the following items for clocktest utility:
> ToD offset
> ToD drift
> wraps
> max delta

See clocktest manual page (available on the web site, or in the
documentation the version of xenomai you use installed, which you do
not mention as usual).

> 
> Besides I have some wraps and delta for the following system, are they
> OK? while there was no wraps or delta for a x86 desktop
> computer+xenomai-2.6.4:

warp is not the same as wrap, I interpret it as meaning a sudden
change in the value. This may happen due to scheduling conditions,
since running the gettimeofday call involves running in secondary
mode, clocktest runs under the control of linux scheduler and as
such may not expect any guarantee. 

The delta is due to the fact that xenomai initializes its "wallclock
time", before the system set it correctly, this happens whether
running on wandboard or on a desktop pc if xenomai is builtin as
opposed to running as a module. Whether it is OK depend on your
use-case.

if you are interested by wraps, you will have to wait for 2038 ;-)
or use the "tsc" test to see whether the underlying counter wraps
(which would be abnormal).

-- 
					    Gilles.

