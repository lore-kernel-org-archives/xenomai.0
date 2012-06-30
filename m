Message-ID: <4FEF31AC.2000403@xenomai.org>
Date: Sat, 30 Jun 2012 19:04:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>	<4FEED882.9070307@xenomai.org>
	<4FEF2EB1.3050600@logilin.fr>
In-Reply-To: <4FEF2EB1.3050600@logilin.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christophe Blaess <mailist@logilin.fr>
Cc: xenomai@xenomai.org

On 06/30/2012 06:52 PM, Christophe Blaess wrote:
> On 30/06/2012 12:44, Gilles Chanteperdrix wrote:
>>
>>> /proc/xenomai/latency is an estimation of the minimum scheduling latency
>>> on your system. In order to know what to put there you should do:
>>>
>>> echo 0 > /proc/xenomai/latency
>>>
>>> Run latency under load for several hour
> 
> Is it necessary to run the test under heavy load?
> We're looking for the minimal latency, not the worst.
> 
> I thought that in this case a normal, even light load would be sufficient.

It is not obvious which path is the shortest. For instance, having to
wake up from a "wait for interrupt" state to handle the timer interrupt
may induce a certain latency, and so may not be the shortest path. So,
running the test for a long time, and with a lot of different activities
is an empiric way to try many paths so that extreme paths have more
chances to be closest to the extrema paths.

And anyway, you usually want to know the worst case latency for your
system as well.

-- 
                                                                Gilles.

