Message-ID: <50145958.4010204@xenomai.org>
Date: Sat, 28 Jul 2012 23:27:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1343510686.76906.YahooMailNeo@web193904.mail.sg3.yahoo.com>
In-Reply-To: <1343510686.76906.YahooMailNeo@web193904.mail.sg3.yahoo.com>
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

On 07/28/2012 11:24 PM, Uttamkumar Sinojia wrote:

> 
> 
> 
>> wake-up time of more than one task is same, in such case which task
>> will wake-up first can not be predicted. But as per the output (shown
>> below), the task with higher priority  is woken-up first----WHY
>> SO??????
> 
> 
> 
> Sorry, the statement is like this...
> 
> Here as all the task are having same priority. So when expected wake-up time of more than one task is same, in such case which task will wake-up first can not be predicted. But as per the output, the task with higher period is woken-up first----WHY SO?????? 
> 
> Let me tell more...
> Here (as per the code) all task are having same priority(5).
> But configured periodic in such a way that all will wake-up at the same time(say t1).(ret = rt_task_set_periodic(NULL, task_pstart_time, PERIOD_n);)
> PERIOD_n  task1->1ms, task2->2ms, task3->3ms, task4->4ms, task5->5ms.


Also, when you "reply" to a mail, could you use the button "reply" of
your MUA, in order to generate a mail with proper references?

-- 
                                                                Gilles.

