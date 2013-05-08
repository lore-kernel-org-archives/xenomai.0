Message-ID: <518A5F0C.50403@xenomai.org>
Date: Wed, 08 May 2013 16:19:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
In-Reply-To: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/08/2013 03:53 PM, alex alex wrote:

> xenomai = 2.6.2.1
> linux kernel = 3.5.7
> arch = x86
> 
> Hello everyone,
> 
> I'm working on a program that uses both a TCP with linux socket and a
> real-time communication module based on rtnet using rtdm.
> My requirement is to use the select function with this 2 types of
> communication.
> To make this works, I created a wrap on select that is calling a function ("
> wrap_select") to create two threads in detached mode: the first for linux
> descriptors and the second for rtdm descriptors.
> After the creation of threads, the "wrap_select" function that waits
> for a semaphore.
> This semaphore is posted by the thread which select is released.
> Then the function "wrap_select" destroy the two functions with
> pthread_cancel.


This defeats the purpose of having a select service which works in
primary mode: your select service switches to secondary mode by calling
pthread_create. Instead of doing this, I would advise using a message
queue, and select from it from the xenomai thread. Besides, creating
threads every time is a bit bad for latencies.

> 
> This mechanisme works fine but after a certain number of calls, creating
> thread with pthread_create fails with the following error: errno = EAGAIN,
> Insufficient memory exists in the system heap to create a new thread,
> Increase.
> It seems there was a limit to the thread creation...
> 
> 1 - Have you any idea about how to work around this problem?


You do not want to work around the problem, you want to fix it. There
is probably some bit missing somewhere to get the thread control block
destroyed when a detached thread dies.

> 
> 2 - A solution would be to create two threads to handle rtdm select and
> linux without destroying them each time.
> But in this case I have to report to the select which thread is still blocking
> its release and I dont know how I can do that.
> 
> 3- Maybe there is a better solution or maybe this problem has already been
> encountered and solved by one of you?


Yes, I have already done that, and tried and describe it in the
following text:

http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#I.2FO_multiplexing_with_select

The posix binding for Xenomai real-time pipes has been created in the
mean-time: it is the xddp sockets.

-- 
                                                                Gilles.

