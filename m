MIME-Version: 1.0
In-Reply-To: <CA+K1mPGChtz-6Hj3_VE_BTg9QL+4V7c-mRO8MjrM18OQ81BCfg@mail.gmail.com>
References: <CA+K1mPGChtz-6Hj3_VE_BTg9QL+4V7c-mRO8MjrM18OQ81BCfg@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 13 Jun 2018 13:35:04 -0400
Message-ID: <CALLqZ8SBvhD0nkxLM0O3WQryCNNnwN2BvYkCJnrkxxP1vxrUEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] How to print to dmesg buffer from an RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

You can try to write to /dev/kmsg, but this is a Linux resource so it
will impact which domain your thread is running on.  AFAIK user space
tasks shouldn't be logging to the kernel log for the most part.  One
solution I've seen is to create a driver (in your case RTDM driver) to
take in log messages and log them to the kernel log.

-Greg

On Wed, Jun 13, 2018 at 1:25 PM, C Smith <csmithquestions@gmail.com> wrote:
> I'd like my Xenomai task to write to both stdout and also to the kernel's
> dmesg buffer.
> It is a periodic task started with rt_task_create().
> When I do rt_vfprintf(stdout, ...)
> it prints to stdout OK, but I also want to send the same string to the
> dmesg buffer, and
> I can't call printk() or rtdm_printk() because this task isn't a kernel
> module.
>
> (I'm using Xenomai 2.6.5 on x86.)
>
> Thanks
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

