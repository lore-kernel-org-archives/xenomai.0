MIME-Version: 1.0
In-Reply-To: <CA+K1mPGfz23OEu2vR+85=bxFmRS3kNEaf4e8F9uiyMk4P7hv6g@mail.gmail.com>
References: <CA+K1mPFgcxF5UAkMNXzit34sPHNWc+uzPTT45bngA6dd0wAyTw@mail.gmail.com>
 <20150630001953.GA2038@hermes.click-hack.org>
 <CA+K1mPG9OKH9FReQoC8jLRAipJ3F=vSdRMmtrxFaZEJjyfHArg@mail.gmail.com>
 <20150701175446.GL13256@hermes.click-hack.org>
 <CA+K1mPGfz23OEu2vR+85=bxFmRS3kNEaf4e8F9uiyMk4P7hv6g@mail.gmail.com>
Date: Mon, 20 Jul 2015 14:31:08 -0700
Message-ID: <CA+K1mPH_C5aW60rBsRhqueVZi3K=XqzFFTwLU7+umCT1Q=90xg@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Unable to Read from Pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I found a workaround for this, but I believe it illustrates a bug in
xenomai 3.0rc5, which is also present in in xenomai 2.6.4.

The problem is that if the userspace writer of a pipe closes the pipe
immediately after writing, the data does not get into the pipe reliably and
the real-time reader process usually doesn't get the data. This is true
even though the write() returns the expected number of bytes indicating
success.

The workaround is to add a usleep in the writer process and wait until the
data "gets into" the pipe before closing the pipe. The critical time period
in my tests seems to be about .5 seconds, if less than that there is often
data loss.

Here is my new userspace pipe-write.c :

     fd = open("/dev/rtp0", O_WRONLY);
    printf("open returned file descriptor: %d\n", fd);

    wr = write(fd, "Debug", sizeof("Debug"));
    printf("Write call retuned: %d\n", wr);

    usleep(500000);   //This sleep makes the write reliable
//    usleep(125000);   //This one is very unreliable

    if (fd > 0)
       close(fd);

This code succeeds but the usleep() is just an open-loop guess as to how
long to wait before close().

Is there any way to verify that bytes have been written to the rt_pipe ?
(Perhaps by checking /proc/xenomai?)

On Thu, Jul 2, 2015 at 4:14 PM, C Smith <csmithquestions@gmail.com> wrote:

> I have installed Xenomai 3.0rc5 and compiled my test applications (with
> minor revisions for the new API).
> I modprobed the xeno_rtipc module for this, and my apps run.  But I am
> getting the exact same error in the periodic task which attempts a
> nonblocking read of a pipe: errno 11 -EWOULDBLOCK, and no bytes are ever
> transferred across the pipe.
>
> It seems unlikely that the Pipe API has been broken across Xenomai 2.6.2,
> 2.6.4 and 3.0rc5.
> So perhaps there is something wrong with my code or the way I compile the
> apps?
>
> The gcc command line for the periodic task is this:
> gcc -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy     -Xlinker
> -rpath -Xlinker /usr/xenomai/lib  pipe-read.c
> -Wl,@/usr/xenomai/lib/cobalt.wrappers
> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
> -lpthread -lrt     -lalchemy -lcopperplate -Wl,--wrap=main
> -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
> -lpthread -lrt    -o pipe-read
>
> I have attached the latest 'write' and 'read' test apps here.
>
> Please help. Thanks,
> -C Smith
>
> On Wed, Jul 1, 2015 at 10:54 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Wed, Jul 01, 2015 at 10:44:53AM -0700, C Smith wrote:
>> > I tried xenomai stable 2.6.4 on a 3.14.17 kernel today. I get the same
>> > result,
>>
>> What about the other tests? Xenomai testing? and XDDP sockets?
>>
>> > the rt task pipe read results in errno 11 -EWOULDBLOCK.  Here is a clue:
>> > a blocking read in the periodic task works OK and reads the bytes from
>> the
>> > pipe - but I can't allow my periodic thread to block.
>> >
>> > The nonblocking pipe API should work in xenomai 2.6.4, right? Perhaps
>> there
>> > is something I'm doing wrong in my code or my compile?
>> > I have attached my test code for you to look at, in case I am doing
>> > something wrong.
>>
>> There is no doubt that it should be working. But maybe it does not,
>> and understanding why would be a waste of time if it has been fixed
>> in Xenomai testing.
>>
>> Please stay on the lit.
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
