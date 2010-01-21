From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A3CE4D0@domain.hid>
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
	<4B4B64AF.3040704@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>
	<4B4C5EDA.5000703@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A341B1B@ILMA1.IL.NDS.COM>
	<4B4F2F05.1040407@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A3CE4CA@ILMA1.IL.NDS.COM>
	<4B5881AB.4080102@domain.hid> <4B5883B8.3090406@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A3CE4D0@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jan 2010 18:11:27 +0100
Message-ID: <1264093887.2350.98.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly - "select"
 issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2010-01-21 at 18:45 +0200, Landau, Bracha wrote:
> Each thread represents a different physical resource. The message queue feeding into the thread contains messages that may be serviced by any one of the resources.
> 
> 1) Why would there be spurious wakeups?
> 2) I did the mq_open as nonblocking.
> 3) It did "work", but all the messages were serviced by a sing

What you might look for, is the round-robin scheduling policy to divide
your timeline in multiple slots your different threads could run in. The
only upside of this would be to prevent any given thread to keep the CPU
busy for too long for processing a single message, at the expense of not
always processing the messages in strict FIFO ordering.

But if you want to stick to the FIFO policy to implement a thread pool,
for polling a single fd with threads that rarely block to handle a
message, I don't understand your design more than Gilles does, I'm
afraid.

> 
> 
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, January 21, 2010 6:41 PM
> To: Landau, Bracha
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] xenomai user app working very slowly - "select" issue
> 
> Gilles Chanteperdrix wrote:
> > Landau, Bracha wrote:
> >> You say "There is not much point using several thread to select on the same file descriptor. The point of select is rather the reverse: being able to wait for several file descriptors with only one thread"
> >> I rely on this in my design. Are you saying that Xenomai does not support having a few threads wait on the same file descriptor?
> >
> > No, I say this is braindamaged design, because you will get lots of
> > spurious wakeups. But it should work.
> 
> And to get it working, you have to be sure to put all the file
> descriptors in non-blocking mode, and be ready for the read/recv
> operation to fail with errno set to -EWOULDBLOCK, because if two threads
> wake up because select signaled that the same file descriptor is ready,
> one thread will win the race, and read will succeed, the other will not.
> If the file descriptor is not in non-blocking mode, the second read will
> block its caller.
> 
> --
>                                             Gilles.
> 
> This message is confidential and intended only for the addressee. If you have received this message in error, please immediately notify the postmaster@domain.hid and delete it from your system as well as any copies. The content of e-mails as well as traffic data may be monitored by NDS for employment and security purposes.
> To protect the environment please do not print this e-mail unless necessary.
> 
> An NDS Group Limited company. www.nds.com
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



