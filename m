Message-ID: <4A301290.4000706@domain.hid>
Date: Wed, 10 Jun 2009 22:07:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6a782b880906101241r50217294j937e03acb3303a86@domain.hid>
In-Reply-To: <6a782b880906101241r50217294j937e03acb3303a86@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Extending RT_TASK | Container_of | Linux Kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thiago Lima <thiagolims@domain.hid>
Cc: xenomai@xenomai.org

Thiago Lima wrote:
> I have created a structure that contains a RT_TASK:
> 
> typedef struct {
>     RT_TASK task;
>     char id;
>     int c;
>     int t;
>     int d;
>     int b;
>     int prio;
> } thread_qos;
> 
> 
> I create a thread_qos and start its RT_TASK in Xenomai User Mode.
> Besides, i have a linux kernel function that is called whenever a real
> time task starts (i did this by applying a patch to xenomai kernel).

The start hook are made for that, no patch needed. See xnpod_add_hook
documentation.

> In this function, i get the current xnthread_t and use container_of to
> get RT_TASK. But, when i use container_of (#define thread2threadqos(ln) 
> container_of(ln, thread_qos, task) to get thread_qos i cant get values
> informed in user mode.
> 
> Do you realize what this could be ? If i create a thread_qos in kernel,
> my macro is working perfectly.

Kernel-space and user-space are two separated areas which do not share
memory. In kernel-space, an RT_TASK is the full TCB of the task, in
user-space, an RT_TASK is a simple handler which the native skin system
calls can use to find the TCB.

Maybe you did that because of what I was suggesting, then I am sorry, it
was not a good suggestion. Tell us what you are trying to do so that we
can help you.

-- 
					    Gilles.

