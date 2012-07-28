Message-ID: <50143ADD.8030702@xenomai.org>
Date: Sat, 28 Jul 2012 21:17:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1343501377.68444.YahooMailNeo@web193906.mail.sg3.yahoo.com>
In-Reply-To: <1343501377.68444.YahooMailNeo@web193906.mail.sg3.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] jitter-test
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

On 07/28/2012 08:49 PM, Uttamkumar Sinojia wrote:> Here as all the task
are having same priority. So when expected

> wake-up time of more than one task is same, in such case which task
> will wake-up first can not be predicted. But as per the output (shown
> below), the task with higher priority  is woken-up first----WHY
> SO??????


Unless you configured xenomai in periodic mode, the wake up time of the
tasks is not the same. Also, I do not understand your sentence:
you say that all tasks have the same priority, but you wonder why the
task with the highest priority wakes up. Errr seems you contradict
yourself, if there is a task with highest priority, then all tasks do
not have the same priority. And vice-versa.

> Here regarding to the task wake-up, i am not getting any relation
> like in previous case which was with respect to the period but the
> any number of time i load the module it is giving same seuence which
> should not happen as all the task are having same priority?????


Xenomai is deterministic, it will behave the same way given the same
events at the same time. Again, Xenomai is not tick based, but has an
aperiodic tic, so, each time you call "rt_task_set_periodic", you create
a periodic event that is not synchronized with the previous one.

-- 
                                                                Gilles.

