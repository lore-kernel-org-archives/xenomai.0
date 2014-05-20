Message-ID: <537B015E.5070107@xenomai.org>
Date: Tue, 20 May 2014 09:16:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <537A5F9B.4040308@xenomai.org>
In-Reply-To: <537A5F9B.4040308@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 05/19/2014 09:46 PM, Gilles Chanteperdrix wrote:
> 
> Hi,
> 
> when running the latency test modified to use timerfds on forge, I
> noticed that we have a clock vs timer drift issue (on forge, not on 2.6,
> and only since recent changes).
> 
> What the latency test does is create a periodic timer, and when waking
> up at each tick, compare the actual wake-up time, with the expected
> wake-up time. The problem is that, on the timer side, the computation is
> more precise, because it is the sum of short durations computed with
> xnarch_llmulshft, whereas on the clock side, we pass larger and larger
> values to xnarch_llmulshft, so at some point, the error due to the
> approximation begins to be within the range of observable differences (a
> few micro-seconds after hours of tests). I have verified that replacing
> xnarch_llmulshft with xnarch_nodiv_llimd avoids the issue. And I believe
> mainline does not have the same issue because they always pass small
> durations to the multiplication + shift operation.

The question being: what do we do to avoid this issue?


-- 
                                                                Gilles.

