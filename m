MIME-Version: 1.0
In-Reply-To: <CALLqZ8R_2t+JUGubiPWW1qmS1hysJm5fHdxGrqJ1=NfXmMpbJA@mail.gmail.com>
References: <CA+K1mPGChtz-6Hj3_VE_BTg9QL+4V7c-mRO8MjrM18OQ81BCfg@mail.gmail.com>
 <CALLqZ8SBvhD0nkxLM0O3WQryCNNnwN2BvYkCJnrkxxP1vxrUEQ@mail.gmail.com>
 <CA+K1mPFmyt0-rBYPiZ4e9QCuBgXrdjD5Y2P2UcRWZFbeKmob8Q@mail.gmail.com>
 <CALLqZ8R_2t+JUGubiPWW1qmS1hysJm5fHdxGrqJ1=NfXmMpbJA@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 14 Jun 2018 16:49:23 -0700
Message-ID: <CA+K1mPGS6UoPNKD3QMt4P8EKwN8DdaKG1hzGF6qB2A17xc=oMg@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

XDDP sockets seemed like overkill, so to work around this: I'm creating a
new message queue (RT_QUEUE) for the string transfer from the userspace RT
process to a kernelspace module (which was already running anyway). The
Xenomai API seems to say that use of this message queue will not cause my
userspace RT app to switch to secondary mode. I'll let you know if it
doesn't work.

<Thanks to those who advised to do it this way.>

-C Smith

On Wed, Jun 13, 2018 at 12:00 PM, Greg Gallagher <greg@embeddedgreg.com>
wrote:

> If you are looking at creating your own RTDM driver you just need a
> basic driver that has open, read, write, close.  There would be no IPC
> needed.  If you'd rather send the logs to a non-RT thread and have
> that open /dev/kmsg then you can use xddp to do the IPC calls
>
> On Wed, Jun 13, 2018 at 2:57 PM, C Smith <csmithquestions@gmail.com>
> wrote:
> >
> >
> > On Wed, Jun 13, 2018 at 10:35 AM, Greg Gallagher <greg@embeddedgreg.com>
> > wrote:
> >>
> >> You can try to write to /dev/kmsg, but this is a Linux resource so it
> >> will impact which domain your thread is running on.
> >
> >
> > Yeah, I can't allow this task to switch to secondary mode, it is a
> > time-critical RT task.
> >
> >> AFAIK user space
> >> tasks shouldn't be logging to the kernel log for the most part.
> >
> > Well, in the past this same task used to run as a RT module in
> kernelspace,
> > so architecturally I still need that dmesg log,
> > (log files on disk are vulnerable to media problems etc).
> >
> >> One
> >> solution I've seen is to create a driver (in your case RTDM driver) to
> >> take in log messages and log them to the kernel log.
> >
> > What IPC method can I use between my RT task and the RTDM logging driver
> in
> > order to avoid a switch to secondary mode?
> > Must I use IDDP sockets ?
>
>
