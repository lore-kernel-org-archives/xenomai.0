MIME-Version: 1.0
In-Reply-To: <55AE021A.5050603@xenomai.org>
References: <CA+K1mPFgcxF5UAkMNXzit34sPHNWc+uzPTT45bngA6dd0wAyTw@mail.gmail.com>
 <20150630001953.GA2038@hermes.click-hack.org>
 <CA+K1mPG9OKH9FReQoC8jLRAipJ3F=vSdRMmtrxFaZEJjyfHArg@mail.gmail.com>
 <20150701175446.GL13256@hermes.click-hack.org>
 <CA+K1mPGfz23OEu2vR+85=bxFmRS3kNEaf4e8F9uiyMk4P7hv6g@mail.gmail.com>
 <CA+K1mPH_C5aW60rBsRhqueVZi3K=XqzFFTwLU7+umCT1Q=90xg@mail.gmail.com>
 <55AE021A.5050603@xenomai.org>
Date: Thu, 23 Jul 2015 09:27:41 -0700
Message-ID: <CA+K1mPH-p60GSiR_oaL_poee3tH6_z17mEfMo=z7ExoEsGti4A@mail.gmail.com>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

That code snippet explains it well, and my tests confirm the principle. I
no longer lose bytes when I open() with O_SYNC flag, write(),  and close()
shortly thereafter.I don't think you need to "make the close() call wait
until the rt input is fully consumed".

This man page is clear on the expected behavior and benefits of O_SYNC:
http://man7.org/linux/man-pages/man2/open.2.html

Thanks, Philippe.

On Tue, Jul 21, 2015 at 1:26 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/20/2015 11:31 PM, C Smith wrote:
> > I found a workaround for this, but I believe it illustrates a bug in
> > xenomai 3.0rc5, which is also present in in xenomai 2.6.4.
> >
> > The problem is that if the userspace writer of a pipe closes the pipe
> > immediately after writing, the data does not get into the pipe reliably
> and
> > the real-time reader process usually doesn't get the data. This is true
> > even though the write() returns the expected number of bytes indicating
> > success.
> >
>
> This is intended. We must allow the regular side to force a shutdown on
> the pipe since this is a valid use case, which would not be possible if
> waiting for the rt input to drain was the only option before the kernel
> actually closes the channel.
>
> O_SYNC can be passed to open() to have the writer wait for the rt side
> to start consuming the messages on the other end. In addition, we could
> make the close() call wait until the rt input is fully consumed with
> O_SYNC too, which is not the case so far (we currently sync on write()
> only). This patch has been scrupulously untested.
>
> diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
> index df587ab..5367c4c 100644
> --- a/ksrc/nucleus/pipe.c
> +++ b/ksrc/nucleus/pipe.c
> @@ -697,6 +697,14 @@ static int xnpipe_release(struct inode *inode,
> struct file *file)
>
>         xnlock_get_irqsave(&nklock, s);
>
> +       if ((file->f_flags & O_SYNC) != 0 && !emptyq_p(&state->inq)) {
> +               if (xnpipe_wait(state, XNPIPE_USER_WSYNC, s,
> +                               emptyq_p(&state->inq))) {
> +                       xnlock_put_irqrestore(&nklock, s);
> +                       return -ERESTARTSYS;
> +               }
> +       }
> +
>         xnpipe_dequeue_all(state, XNPIPE_USER_WREAD);
>         xnpipe_dequeue_all(state, XNPIPE_USER_WSYNC);
>
> --
> Philippe.
>
