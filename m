From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1298328650.2075.50.camel@domain.hid>
References: <AANLkTikH_NciDFN402p-bvPW__K2du9bZRgcS7AUfz+t@domain.hid>
	<1298318410.2075.5.camel@domain.hid>  <4D62CA75.1050706@domain.hid>
	<1298321553.2075.43.camel@domain.hid>  <4D62D746.4060308@domain.hid>
	<1298328650.2075.50.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Feb 2011 23:53:13 +0100
Message-ID: <1298328793.2075.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_pipe_stream: not getting EPIPE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: varname <varname@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-02-21 at 23:50 +0100, Philippe Gerum wrote:
> On Mon, 2011-02-21 at 22:21 +0100, varname wrote:
> > Philippe Gerum wrote:
> > > On Mon, 2011-02-21 at 21:26 +0100, varname wrote:
> > >> Philippe Gerum wrote:
> > >>> On Mon, 2011-02-21 at 18:54 +0100, varname wrote:
> > >>>> trying to write a simple producer / consumer using message pipes in
> > >>>> the native API, this phrase from the documentation (found here [1])
> > >>>> confuses me:
> > >>>>
> > >>>> "-EPIPE is returned if the associated special device is not yet open."
> > >>>>
> > >>>> It's not so much the sentence itself, but more the fact that I'm not
> > >>>> getting that return value from rt_pipe_stream() when streaming bytes
> > >>>> to a RT_PIPE that hasn't had its "special device" opened in secondary
> > >>>> domain.
> > >>>>
> > >>>> I've attached a modified trivial-periodic.c that demonstrates what I'm
> > >>>> seeing. Afaik there is nothing open(2)-ing the /dev/rtp9 in the
> > >>>> secondary domain. All writes succeed, up to about write 31 (*1024),
> > >>>> after which all writes return 0.
> > >>>>
> > >>>> [..]
> > >>>> wrote: 1024, res: 1024
> > >>>> wrote: 1024, res: 948
> > >>>> wrote: 1024, res: 0
> > >>>> wrote: 1024, res: 0
> > >>>> [..]
> > >>>>
> > >>>> Is the documentation incorrect, or am I misunderstanding something?
> > >>> The doc is wrong (former implementation, 2.1.x series), the pipe
> > >>> services do buffer real-time output until the special device is
> > >>> eventually opened starting with Xenomai 2.2.x. Since you are using
> > >>> rt_pipe_stream(), the output is directed to an internal buffer until
> > >>> there is no more space there, which causes the final 0-byte returns.
> > >>>
> > >>> So everything looks ok, except the doc.
> > >> ok, so there is actually no way to detect whether or not the special 
> > >> device has been opened?
> > > 
> > > Nope.
> > > 
> > >>  As I understood from earlier mails on the list, 
> > >> writes to a full pipe buffer just fail, correct?
> > >>
> > > 
> > > From the -rt side, yes. From the nrt domain via /dev/rtp*, it blocks
> > > until the output buffer drains, unless O_NONBLOCK was set on the fildes
> > > (-EWOULDBLOCK).
> > > 
> > >> Is there any way to flush a message pipe from a userspace task (as 
> > >> opposed to a kernelspace one, where rt_pipe_flush is available)?
> > >>
> > > 
> > > There is no official interface for this, but you can get this working
> > > with:
> > > 
> > > #include <nucleus/pipe.h>
> > > 
> > > ioctl(fd, XNPIPEIOC_OFLUSH), flushes the output queue (rt -> nrt)
> > > 
> > > ioctl(fd, XNPIPEIOC_IFLUSH), flushes the input queue (nrt -> rt)
> > 
> > Ok. I hate to keep asking like this, but seeing as this is an ioctl with 
> > a file descriptor parameter: this is not done from the primary domain 
> > right? Perhaps my description was a bit ambiguous, but I with 
> > 'userspace' I meant a userspace Xenomai task in the primary domain. I 
> > guess the rt_task could open(2) the Linux device and perform the ioctl, 
> > but would be nice to not have to.
> > 
> 
> Yes, that hack would entail a switch to non-rt mode in that case.
> 
> rt_pipe_flush() is missing from ksrc/skins/native/syscall.c. Maybe you
> could get some inspiration from the way __rt_pipe_delete() is
> implemented there, for retrieving the pipe descriptor pointer from the
> syscall args, and have your new __rt_pipe_flush() request mimic what
> xnpipe_ioctl() does for the above commands.

Or simply call rt_pipe_flush() from ksrc/native/pipe.c with the pipe
descriptor and mode, once decoded from the syscall actually.

> 
> > 
> > > FYI: the RT_PIPE interface is deprecated and will go away in the 3.x
> > > series (the upcoming 2.6.x series still has it though). It is officially
> > > replaced by the RTIPC/XDDP protocol (same purpose, but via the
> > > RTDM/socket interface):
> > > http://www.xenomai.org/documentation/xenomai-head/html/api/group__rtipc.html#ggba01db17f4a2bfbc3db60dc172972a2528a488c3e7fc47dee4d5757f215f62e9
> > > I'm not saying you should drop RT_PIPE for RTIPC immediately in 2.5.x, I
> > > would wait for 2.6.x for this move. But you may want to keep this in
> > > mind if long-term portability is a goal.
> > 
> > Thanks. I remember reading something about that in the kernel config. 
> > I'll keep it in mind for when 2.6 is released. In this particular 
> > project the transport's details are abstracted away, so adding one based 
> > on RTIPC/XDDP shoulnd't be too hard.
> > 
> > 
> > thanks again
> > 
> 

-- 
Philippe.



