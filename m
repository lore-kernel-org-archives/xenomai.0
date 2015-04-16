Date: Thu, 16 Apr 2015 15:23:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150416132316.GD1589@hermes.click-hack.org>
References: <CACreCVJiKuVmA5cnH7sLxK=3-nCJwo=Q-bJFugLgoM8LTDdYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVJiKuVmA5cnH7sLxK=3-nCJwo=Q-bJFugLgoM8LTDdYWQ@mail.gmail.com>
Subject: Re: [Xenomai] CLOCK_HOST_REALTIME failure on Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Apr 16, 2015 at 07:20:09PM +0800, GP Orcullo wrote:
> Hi,
> 
> I'm trying to run Xenomai 3 on my Cubieboard2 but it fails the clocktest:
> 
> # /usr/xenomai/bin/clocktest -C 42
> clock_gettime failed for clock id == Tested clock: 42 (<unknown>)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------42
> 
>   0                  0.0            0.000          0            0.0
>   1                  0.0            0.000          0            0.0
> clock_gettime failed for clock id 42
> 
> The clock test runs fine on Xenomai 2:
> 
> # clocktest -C 42
> == Tested clock: 42 (CLOCK_HOST_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  1.0            0.093          0            0.0
>   1                  0.8            0.000          0            0.0
> ^C

CLOCK_HOST_REALTIME is no longer 42 in Xenomai 3 (which is why
clocktest tells you that the clockid 42 is unknown, it really is).

-- 
					    Gilles.

