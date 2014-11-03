Date: Mon, 3 Nov 2014 09:59:47 -0600
From: "Steve M. Robbins" <steve@sumost.ca>
Message-ID: <20141103155947.GA15262@sumost.ca>
References: <94331816.zv1NYeHro4@riemann> <20141031200007.GC378@sumost.ca>
 <5454ADDF.4040604@xenomai.org> <6071747.2uXMl1ZSO0@riemann>
 <54573A6D.1030201@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54573A6D.1030201@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On Mon, Nov 03, 2014 at 09:18:53AM +0100, Philippe Gerum wrote:
> On 11/02/2014 01:53 AM, Steve M. Robbins wrote:
> > On November 1, 2014 10:54:39 AM Philippe Gerum wrote:
> 
> >> Perhaps the rt side sends a large burst of data once in a while causing
> >> the overflow? In this case, you could not detect the issue looming from
> >> the nrt side until it happens, since the rt side has higher priority
> >> (i.e. rt would cause ENOMEM even before nrt had a chance to resume
> >> execution).
> > 
> > OK, I understand the theory.  However, I don't believe that is my case.  The 
> > message queue is transporting fault information and through user actions I can 
> > set it up to send 2 messages per cycle and using the FIFO code, the nrt side 
> > is indeed reading 2 messages.  Using message queues, I can see that there are 
> > multiple messages outstanding but it reads only one.
> > 
> 
> Ok, so if no message gets lost, if you can see FIONREAD increase until
> ENOMEM is raised, and if throttling the rt side only delays the issue
> without solving it, the only explanation would be that a notification of
> input availability is lost by the poll handler backing select() in the
> rt-pipe driver. That would cause the messages to pile up on the rt side,
> with too few deliveries to nrt.

I want to emphasize that FIONREAD is being done on the nrt side, after
the select() and just prior to the actual read() call.  Thus the nrt
side is seeing N > 1 messages available on the file descriptor, but
read() only reads 1, even though the fd is nonblocking and the read
buffer is sized for 100 messages.  So it seems to me there is somehow
a disconnect between the "available bytes" as seen by read() versus
FIONREAD.  I admit to being naive about the kernel but that seems
like something that should not be possible.


Given that, I don't understand what you're saying about notification
of input availability being lost.  It may be true that the select()
doesn't fire as often as it should, but the nrt side does wake up
prior to the queue being completely full and still will only read 1
message.  Are you saying that missing a notification would affect the
"available bytes" seen by read() on the nrt side?  But still the
FIONREAD would tell us the truth?



> Only for the purpose of checking this, could you try read()ing the large
> message queue directly, then in a second attempt, enabling SIGIO on the
> rtp fildes to get the messages asynchronously, instead of sensing them
> via select()? The idea would be to check whether getting rid of select()
> improves the situation.

I'll check into doing that.



> NOTE: I'm assuming that the rt side only uses rt_pipe_write(), and never
> rt_pipe_stream() which does packet coalescence by design.

Yes, that's correct.  The only calls the rt side makes are: rt_pipe_create()
and rt_pipe_write().

The only calls the nrt side makes is open(), ioctl(FIONREAD), and read().
I am presently opening with O_RDONLY | O_NONBLOCK.  I have also tried
O_RDWR | O_NONBLOCK and saw the same results.

Also: the nrt side is a "mostly pure" linux program that does NOT call
wrapped versions of select(), etc.  It does, however, link with a
vendor library that links with xenomai libs and the vendor library
does somehow make the thread in question appear as a xenomai task.
Apart from a couple of mode switches (presumably when intializing the
vendor lib), it runs exclusively in linux mode.

-Steve
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 173 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141103/84a8c58f/attachment.sig>
