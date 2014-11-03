Message-ID: <5457AD81.7090200@xenomai.org>
Date: Mon, 03 Nov 2014 17:29:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann> <20141031200007.GC378@sumost.ca>
 <5454ADDF.4040604@xenomai.org> <6071747.2uXMl1ZSO0@riemann>
 <54573A6D.1030201@xenomai.org> <20141103155947.GA15262@sumost.ca>
In-Reply-To: <20141103155947.GA15262@sumost.ca>
Content-Type: text/plain; charset=windows-1252
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
To: "Steve M. Robbins" <steve@sumost.ca>
Cc: Xenomai@xenomai.org

On 11/03/2014 04:59 PM, Steve M. Robbins wrote:
> On Mon, Nov 03, 2014 at 09:18:53AM +0100, Philippe Gerum wrote:
>> On 11/02/2014 01:53 AM, Steve M. Robbins wrote:
>>> On November 1, 2014 10:54:39 AM Philippe Gerum wrote:
>>
>>>> Perhaps the rt side sends a large burst of data once in a while causing
>>>> the overflow? In this case, you could not detect the issue looming from
>>>> the nrt side until it happens, since the rt side has higher priority
>>>> (i.e. rt would cause ENOMEM even before nrt had a chance to resume
>>>> execution).
>>>
>>> OK, I understand the theory.  However, I don't believe that is my case.  The 
>>> message queue is transporting fault information and through user actions I can 
>>> set it up to send 2 messages per cycle and using the FIFO code, the nrt side 
>>> is indeed reading 2 messages.  Using message queues, I can see that there are 
>>> multiple messages outstanding but it reads only one.
>>>
>>
>> Ok, so if no message gets lost, if you can see FIONREAD increase until
>> ENOMEM is raised, and if throttling the rt side only delays the issue
>> without solving it, the only explanation would be that a notification of
>> input availability is lost by the poll handler backing select() in the
>> rt-pipe driver. That would cause the messages to pile up on the rt side,
>> with too few deliveries to nrt.
> 
> I want to emphasize that FIONREAD is being done on the nrt side, after
> the select() and just prior to the actual read() call.  Thus the nrt
> side is seeing N > 1 messages available on the file descriptor, but
> read() only reads 1, even though the fd is nonblocking and the read
> buffer is sized for 100 messages.

Just to make sure we are on the same page, as Dietmar mentioned in an
earlier mail, read() as implemented by the rt-pipe driver only returns
_one_ message at a time, although > 1 could be pending. One has to
iterate over a read() loop using a non-blocking fd on the /dev/rtp
device to get them all. I'm likely beating a dead horse here this said.

  So it seems to me there is somehow
> a disconnect between the "available bytes" as seen by read() versus
> FIONREAD.  I admit to being naive about the kernel but that seems
> like something that should not be possible.
> 
> 
> Given that, I don't understand what you're saying about notification
> of input availability being lost.  It may be true that the select()
> doesn't fire as often as it should, but the nrt side does wake up
> prior to the queue being completely full and still will only read 1
> message.  Are you saying that missing a notification would affect the
> "available bytes" seen by read() on the nrt side?  But still the
> FIONREAD would tell us the truth?

FIONREAD value and select() events are not synchronized, FIONREAD is
maintained in the rt-send and nrt-read handlers. FIONREAD always tells
the truth. On the other hand, if for some reason a wake up event is
missed, select() would be wrong. I don't have any evidence that such bug
happens looking at the code, but would something go wrong there, then it
might explain the behaviour you observed.

-- 
Philippe.

