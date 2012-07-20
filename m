Message-ID: <5009A5EF.70308@xenomai.org>
Date: Fri, 20 Jul 2012 20:39:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1342306481.94440.YahooMailNeo@web193905.mail.sg3.yahoo.com>
In-Reply-To: <1342306481.94440.YahooMailNeo@web193905.mail.sg3.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Jitter-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/15/2012 12:54 AM, Uttamkumar Sinojia wrote:
> 
> 
> Respected sir,
> 
> I have prepared a setup for checking the scheduling jitter
> values(current time - expected wake-up time) among five periodic task
> having same priority.
> 
> I have created 5 periodic real-time tasks with equal priority(say, 5)
> and wake them at the same time. Choosen task periods of 100us, 200us,
> 300us, 400us and 500us , respectively. Here in this case when more
> than one tasks are going to wake-up at same expected time, which
> process will be scheduled should be non-deterministic and i was
> getting it.
> 
> In another case, I have created 5 periodic real-time tasks with equal
> priority(say, 5) and wake them at the same time. Choosen task periods
> of 1ms, 2ms, 3ms, 4ms and 5ms , respectively. In this case i was
> getting the deterministic behavior in scheduling of the task(When
> expected time for more than one task was same, task with larger
> period was woken-up first). So, i was not getting the reason for this
> deterministic behavior.

Please post the test code, tell us which version of xenomai you use, and
post the kernel configuration. And explain with the code what you would
expect and what you get.

-- 
                                                                Gilles.

