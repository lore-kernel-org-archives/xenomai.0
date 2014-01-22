Message-ID: <52DFA12F.3000304@xenomai.org>
Date: Wed, 22 Jan 2014 11:45:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc7uTkGTX30oso0ciV4JisdTXSNL6YbWbmsnoD6C_r_Uw@mail.gmail.com>
In-Reply-To: <CAKKWdtc7uTkGTX30oso0ciV4JisdTXSNL6YbWbmsnoD6C_r_Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Computer froze by a loop
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

On 01/22/2014 10:04 AM, ali hagigat wrote:
> Watchdog is enabled and if i put "while(1);" command at the begining
> of task2, or any where in task1, after 4 seconds all the tasks are
> killed. But in the example I have attached ( please look at the place
> of "while(1);") computer froze! Not <ctrl-C> nor Linux scheduling
> works!
> 
> I have two questions:
> 
> 1) Why computer freezes in the cae? It seems a bug

The Xenomai watchdog only handles task which are looping in primary
mode, handling task running in secondary mode is left to the Linux
scheduler. Normally, you should see a message about RT throttling, and
you should be able to interrupt the task with Ctrl-C, unless you
disabled rt throttling by writing to /proc/sys/kernel/sched_rt_*

> 2) When I put "while(1);" instruction in task1, then task1 is killed
> by SIGXCPU and the CPU time exceeded, why task2 and the parent task
> are all killed? I mean only one task should be killed not all of them!

That is the default way of handling SIGXCPU. If you want a different
behaviour, simply register a signal handler for SIGXCPU. Note that doing
nothing in SIGXCPU signal handler will defeat the watchdog, as the
killed task will continue to run, in secondary mode however.

-- 
                                                                Gilles.

