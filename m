Message-ID: <514B7676.1090404@xenomai.org>
Date: Thu, 21 Mar 2013 22:07:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <514B754C.4080800@yahoo.com>
In-Reply-To: <514B754C.4080800@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions regarding context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: xenomai@xenomai.org

On 03/21/2013 10:02 PM, Tom Z wrote:

> when an RT_ALARM expires and executes a handler, shouldn't 
> there be a context switch if an RT_TASK is running? The task mentioned 
> above executes rt_timer_spin for 100ms during each period, and the 
> highest priority among all the 8 tasks, so while it is executing, the 
> RT_ALARM must expire for many times -- but why does it NOT increase the 
> number of the tasks' context switches?


Hi,

Because the number of context switches is the number of task switches.
An alarm in kernel-space is simply triggered on the timer interrupt, so,
it does not need any task switch. An alarm is not a task.

Any news about the issue you described here:
http://www.xenomai.org/pipermail/xenomai/2013-March/028005.html
?

Regards.


-- 
                                                                Gilles.

