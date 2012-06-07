Message-ID: <4FD0679F.3020904@xenomai.org>
Date: Thu, 07 Jun 2012 10:34:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com>	<4FBB4951.5070803@xenomai.org>	<4FBC0383.3020608@bbn.com>	<4FBC0582.2060707@xenomai.org>	<4FBF4E69.1010200@bbn.com>	<4FBF78FE.3020300@xenomai.org>
	<CAMak2D8rWO6zbJhawMr43vg4=qhJ0fUBT3z-1bUYn=shcUFfAA@mail.gmail.com>
In-Reply-To: <CAMak2D8rWO6zbJhawMr43vg4=qhJ0fUBT3z-1bUYn=shcUFfAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eric Eric <ericrebates@gmail.com>
Cc: xenomai@xenomai.org

On 06/07/2012 09:44 AM, Eric Eric wrote:
> Hi Gilles, I believe the problems I was having several months ago with
> erratic timing on the Beagleboard when running dohell may be related
> to this.  I'm wondering if there are still plans to formally wrap the
> patch into the official Xenomai tree?

The erratic timing you are talking about were variations in the
microsecond range. What this patch avoids are latencies in the
millisecond range involving GPIO interrupts. So, definitely no, this
patch will not change anything with your situation.

But anyway, I do not believe what you described was really a problem.
Yes, some things have more influence on latencies than other. This is
inherent to the dual kernel solution. And anyway, as I told you at the
time, if you want to know what cause the worst case latency of a latency
run, run latency -f with the I-pipe tracer enabled. If you post us a
latency trace, we may help you find if anything is wrong.

-- 
					    Gilles.

