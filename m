Message-ID: <5454ADDF.4040604@xenomai.org>
Date: Sat, 01 Nov 2014 10:54:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann> <54512440.3000806@xenomai.org>
 <20141031200007.GC378@sumost.ca>
In-Reply-To: <20141031200007.GC378@sumost.ca>
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
To: "Steve M. Robbins" <steve@sumost.ca>, Xenomai@xenomai.org

On 10/31/2014 09:00 PM, Steve M. Robbins wrote:
> On Wed, Oct 29, 2014 at 06:30:40PM +0100, Philippe Gerum wrote:
>> On 10/29/2014 05:11 PM, Steve M. Robbins wrote:
>>
>>> In the old FIFO-based code, we had a suspicion of the similar problem.  Since 
>>> the linux process is not real time, we expect multiple messages to be waiting.  
>>> To avoid running through the select/read loop once for each message, our old 
>>> FIFO-based code opened the file in nonblocking mode and did a read into a buffer 
>>> that could hold up to 100 messages.  We generally would read 5-7 at a time, 
>>> not 100, so this proved that the reader could keep up when reading in batches.
>>>
>>> Using this same technique with the /dev/rtpN end of a Message Pipe never reads 
>>> more than 1 message.  I tried both blocking and non-blocking modes but got the 
>>> same result.  So this is my main question: knowing that there are likely many 
>>> messages in the pipe, how do I read them in a batch?
>>>
>>
>> Reading with O_NONBLOCK set on /dev/rtp should do the trick.
> 
> Great!  I changed back to O_NONBLOCK (and verified on the running file
> using /proc/pid/fdstats).  And I'm using a private pool for the pipe.
> 
> 
>> If it does
>> not, this could mean that your rt side is filling up the pool too fast
>> compared to the scheduling opportunities for the nrt side. The latter
>> won't run until the rt activity becomes quiescent long enough.
>>
>> You can track how many bytes are readable on the nrt side by using
>> ioctl(.., FIONREAD, &some_int), to make sure this value does increase
>> over time until ENOMEM is received. Otherwise there must be a leak of
>> consumed message buffers.
> 
> Good suggestion.  I am now tracking the number of messages available
> using the ioctl() just prior to read.  In the most recent run, there
> was an average of 83 messages available, but read() only obtained one.
> That suggests to me that the nrt side is being scheduled often enough.
> 

FIONREAD returns the number of bytes pending read, not the count of
individual messages, so this would denote an average of 83 bytes pending
read.

> 
> I can also see via /proc/xenomai/heap (thanks for the tip!) that the
> heap does fill up, so ENOMEM is valid.  When the message rate slows
> down, the nrt side is able to catch up and the heap size comes back
> down (and ENOMEM goes away).
> 
> The previous kernel FIFO-based code actually uses the same code on the
> nrt side so I have a bit of confidence in that.  With the FIFO code, I
> can see from the ioctl() and read() that it does read all available
> bytes.  I'm really puzzled why the rt_pipe is behaving differently.
> 

The fact that the message pool fills up again once the data is consumed
on the nrt side seems to rule out a memory leak.

Perhaps the rt side sends a large burst of data once in a while causing
the overflow? In this case, you could not detect the issue looming from
the nrt side until it happens, since the rt side has higher priority
(i.e. rt would cause ENOMEM even before nrt had a chance to resume
execution).

This is a major difference with a regular FIFO, where the sender would
block upon congestion, until the reader consumes enough data for the
write op to complete. With rt-pipes, we don't allow the rt side to wait
for the nrt side by design, so the only possible outcome upon write
congestion from rt to nrt is ENOMEM, basically.

-- 
Philippe.

