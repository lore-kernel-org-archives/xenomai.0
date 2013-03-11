Message-ID: <513D83A2.4020004@xenomai.org>
Date: Mon, 11 Mar 2013 08:11:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362975314.45141.YahooMailNeo@web161406.mail.bf1.yahoo.com>
In-Reply-To: <1362975314.45141.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] how to install a "preemption hook"?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/11/2013 05:15 AM, Tom Z wrote:

> Hi,
> 
> I am using native APIs to do some development and have a question
> recently. I have a task A with a medium priority, so during A's
> execution, it could be preempted by higher-priority tasks or
> interrupts. What I want to do is to install a hook so that whenever A
> is preempted, this hook is executed immediately after A is preempted,
> but before the execution of the task that preempts A.
> 
> How can I accomplish this goal? Any ideas would be highly
> appreciated.


In kernel-space, you can use rt_task_add_hook:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__task.html#ga7452f367f9e17bf2fc0b70f717b96dd8

-- 
                                                                Gilles.

