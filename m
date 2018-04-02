MIME-Version: 1.0
In-Reply-To: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 2 Apr 2018 10:54:45 -0400
Message-ID: <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rodrigo.amaducci@uam.es
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I believe you want to look at xddp for communication between RT and
non RT threads:

http://xenomai.org/documentation/xenomai-3/html/xeno3prm/xddp-echo_8c-example.html

I don't have much experience with using message queues for RT to
non-RT communications but I believe using a message queue with a RT
and non-RT thread is expected to cause mode switches.

-Greg

On Mon, Apr 2, 2018 at 10:26 AM,  <rodrigo.amaducci@uam.es> wrote:
> Hello,
>
> I'm currently working on a program that, basically, reads some data from a
> DAQ device periodically, performs some calculations over it and writes the
> result back to the DAQ. All these operations are performed by a real-time
> thread (using POSIX skin), while a second non real-time thread stores some
> information in a file. Both threads communicate through a message queue
> and are created using POSIX-skin pthread_create.
>
> In summary, the real-time thread uses the following functions:
> - POSIX-skin clock_nanosleep to make the thread periodic
> - Analogy a4l_sync_read and a4l_sync_write to interact with the DAQ device
> - POSIX-skin mq_timedsend to write in the message queue
>
> And the writer non real-time thread uses:
> - POSIX-skin mq_receive to read from the message queue
>
> Problem is that both threads are constantly switching between primary and
> secondary contexts, as the value MSW at /proc/xenomai/sched/stat shows,
> so my questions are the following:
>
> - Does any of the functions used in the real-time thread perform a switch
> to secondary mode?
>
> - Since POSIX-skin mq_receive switches to primary context in the writer
> thread, can regular POSIX message queues be used in both threads without
> affecting real-time?
>
> - Is there any other possible source of context switching that I'm not
> considering (allocating memory in one thread that is freed in the other,
> maybe)?
>
> Thanks in advance,
>
> Rodrigo
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

