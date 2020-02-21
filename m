Subject: Re: rt_task_bind blocking: inter-process ?
References: <4392cb58-f99f-f1d6-b4c7-58c75040cf01@laas.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <90b72835-b6af-9f6c-e1e9-f1745d8a1799@xenomai.org>
Date: Fri, 21 Feb 2020 17:06:14 +0100
MIME-Version: 1.0
In-Reply-To: <4392cb58-f99f-f1d6-b4c7-58c75040cf01@laas.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: LOCHE Daniel <dloche@laas.fr>, xenomai@xenomai.org

On 2/20/20 2:29 PM, LOCHE Daniel via Xenomai wrote:
> Hello everyone,
> 
> I a currently factoring my application to go from a multi-thread one to
> a multi-process one (C++11).
> I am using Xenomai 3.0.5 on Linux Mint 18.04 (on a Intel 8250U
> computer), 90% alchemy library (10% posix).
> (either processes or tasks, let's call all of those "tasks" here after
> for easier understanding)
> 
> *Context : *Basically, during the setup phase of the execution,
> previously I was reading a list of "task" parameters from a file
> and launched consequently the correct amount of rt_task_create() /
> launch() from my main process.
> All my RT_TASK links to the threads were stored in the main thread to
> manage them.
> 
> Now, I have to go through a fork() for every task, followed by a
> rt_task_shadow(). OK.
> But to get in my main process the link to the RT_TASK of every xenomai
> process created, I have to use rt_task_bind().
> Issue is here : whatever arguments I give to rt_task_bind(), it blocks
> as long as the searched task name exists... don't know why.

That won't work. Aside of the issues pointed out by Steve, this
construct is not supported with APIs involving libcopperplate, e.g. the
current implementation won't behave properly when calling
rt_task_shadow() multiple times without replacing the image with exec()
in between.

Hint: the issue is rooted in the threadobj layer of libcopperplate, the
TLS data for threadobj_current is inherited across fork, and no atfork
handler is ever going to clear it in the child process. Which is why
rt_task_shadow() should give you -EBUSY, after any subsequent call past
the first one in your code. Enabling this construct would require to
reset the copperplate state at fork, clearing the TLS stuff among other
things.

> 
> Here is a sample code bellow ... what is wrong exactly ? Is it possible
> to use rt_task_bind with inter-process tasks..? Why the "TM_NONBLOCK"
> does nothing..? Thanks for your help.
>

I'm sure it does. Your test code is missing \n in the format string. I
believe this code receives -EWOULDBLOCK as expected, you just cannot
receive your trace output.

-- 
Philippe.

