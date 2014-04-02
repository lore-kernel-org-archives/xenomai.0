Message-ID: <533BBC0A.7050601@xenomai.org>
Date: Wed, 02 Apr 2014 09:28:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <36553bb2.3800.1451b23ccfc.Coremail.ericvic@163.com>
 <533A99AD.4010404@xenomai.org>
 <4e1f2397.14cae.1451fed778d.Coremail.ericvic@163.com>
In-Reply-To: <4e1f2397.14cae.1451fed778d.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/02/2014 02:53 AM, 嵌入式工程师 wrote:
> I know latency test can not run with e other real-time  activity, but
> my program will run some real-time activties at the same time ,now it
> looks  like because multiple cpu shared memory causes a great
> difference jitter .

That is not your problem. Your problem is that if you run a task with
priority 99 on the same cpu as the latency test, the time this task
prevents the latency test from running is counted by the latency test as
latency, which gives wrong results. This is not latency, this is simply
the scheduler doing its job: letting a task running until it suspends
before letting the latency task running. That is because the two tasks
have the same priority.

-- 
                                                                Gilles.

