Message-ID: <50FB0138.2090400@xenomai.org>
Date: Sat, 19 Jan 2013 21:25:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50FAFF77.8020803@zultron.com>
In-Reply-To: <50FAFF77.8020803@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 32-bit regression tests:  CLOCK_REALTIME wonkiness
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/19/2013 09:17 PM, John Morris wrote:

> Hi list,
> 
> These are the final tests on 32-bit before the initial RedHat packages
> can be released for wider testing.
> 
> On this host, a Dell Celeron with ICH5 chipset, the CLOCK_REALTIME
> numbers look funny.  All other tests run correctly.
> 
> ++ /usr/lib/xenomai/clocktest -T 30
> == Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  0.0            0.000          0            0.0
> ^[[1A  0           -1074721.3           39.245          0            0.0
> ^[[1A  0           -1074711.5           39.172          0            0.0
> ^[[1A  0           -1074701.8           39.096          0            0.0
> ^[[1A  0           -1074691.9           39.184          0            0.0
> 
> This is Gilles's i-pipe dev tree and xenomai master pulled yesterday,

> kernel 3.5.7.


Nothing really wrong here, the ToD offset is due to the fact that the
realtime clock was changed between the time Xenomai read it to set its
own realt-ime clock, and the time clocktest is run, and the drift is due
to the tsc frequency adjustments made by Linux after Xenomai is started.

-- 
                                                                Gilles.

