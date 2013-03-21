Message-ID: <514B7D81.8040103@yahoo.com>
Date: Thu, 21 Mar 2013 16:37:05 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
References: <514B754C.4080800@yahoo.com> <514B7676.1090404@xenomai.org>
In-Reply-To: <514B7676.1090404@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for your prompt reply. You are amazing:)

> Any news about the issue you described here:
> http://www.xenomai.org/pipermail/xenomai/2013-March/028005.html
> ?
You are correct. The link order is wrong. I figured out a working order 
by trial&error, as follows:
CFLAGS=$(shell xeno-config --skin=native --cflags)
LDFLAGS=$(shell xeno-config --skin=native --ldflags)
gcc $(CFLAGS) main.c $(LDFLAGS) -o main

Sincerely,
Tom

On 3/21/2013 4:07 PM, Gilles Chanteperdrix wrote:
> On 03/21/2013 10:02 PM, Tom Z wrote:
>
>> when an RT_ALARM expires and executes a handler, shouldn't
>> there be a context switch if an RT_TASK is running? The task mentioned
>> above executes rt_timer_spin for 100ms during each period, and the
>> highest priority among all the 8 tasks, so while it is executing, the
>> RT_ALARM must expire for many times -- but why does it NOT increase the
>> number of the tasks' context switches?
>
> Hi,
>
> Because the number of context switches is the number of task switches.
> An alarm in kernel-space is simply triggered on the timer interrupt, so,
> it does not need any task switch. An alarm is not a task.
>
> Any news about the issue you described here:
> http://www.xenomai.org/pipermail/xenomai/2013-March/028005.html
> ?
>
> Regards.
>
>


