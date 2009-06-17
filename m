From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <188636.66895.qm@domain.hid>
References: <188636.66895.qm@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 10:09:57 +0200
Message-Id: <1245226197.1443.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Native API rt_pipe_monitor() call can not be
 called from an RT Task in linux userspace ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-06-16 at 15:23 -0700, Guvenc Gulce wrote: 
> Hello
> 
> I have the following questions regarding the rt_pipe behavior in Xenomai. 
> 
> -> Why is not possible to use rt_pipe_monitor() Native API call from an userspace RT Task ?

Because this API is aimed at providing help to drivers implementing the
kernel space endpoint of a pipe connection; the driver/module may then
make userland benefit from this in a way or another, but it is not the
primary intent.

Additionally, the pipe monitors are based on function calls for
notification, which is a real issue in a dual kernel system, when the
caller is not the linux kernel, but the co-kernel. We would have to
reinstate the userland address space context as fast as possible just
for the time needed to run the handler, and we would have to do so from
a real-time context that could be utterly unsafe from the linux kernel
POV.

There is another option we have been digging for some time to emulate
such kind of callouts using an asynchronous approach under the hood,
that would allow us to support real-time signals crossing address spaces
as well. But this is still on the drawing board.

> 
> -> What is the solution if async notifications in rt-pipe context are needed in userspace RT Tasks ?
> 
> 

If you don't care about real-timeliness of the receiver (i.e. userland
does read() and not rt_pipe_read/receive()), then SIGIO is available,
but maybe this is not what you want if your receiver is actually a RT
task. Otherwise, you will have to resort to a server task reading the
pipe to emulate an asynchronous behavior out of a synchronous construct,
I'm afraid.

As you have probably understood already, building a full real-time to
real-time data path using pipes is not possible; this said, this is not
the purpose of this API anyway, which has been designed for real-time to
non-RT communication.

> 
> 
> -> Is there any plan to implement something similar to linux's epoll system call for the rt-pipes used 
> in userspace RT tasks ?
> 

No plans yet, even if not objection to merge this either.

> Thanks & Regards
> 
> Guvenc
> 
> 
>       
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



