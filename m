From: "Steve M. Robbins" <steve@sumost.ca>
Date: Wed, 29 Oct 2014 11:11:22 -0500
Message-ID: <94331816.zv1NYeHro4@riemann>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

I will apologize in advance that this question concerns Xenomai 2.5.6.  I do 
realize it is an old version, but that is what our vendor provides so that is 
what I am using.

A while back I was asking about replacing a linux FIFO-based queue used to 
send messages from a real time task to a linux process.  The recommendation 
[1] was that the Message Pipe Service would serve nicely.  I recently 
implemented it and the messages are flowing, but I have questions about some 
observed behaviours.

Our real time task runs at 250 Hz and produces a small number of messages 
(usually about 2, but up to 10) each iteration.  Each message is about 120 
bytes.  I use rt_pipe_write() with P_NORMAL.  On the linux side, the process 
does a loop with select() and read().  

Initially, messages are flowing, but after some time, rt_pipe_write() begins to 
return -ENOMEM intermittently but more and more often as time passes.  The 
first thing I tried was changing the poolsize of rt_pipe_create() from 0 to 
1000*sizeof(message_structure).  The problem remained.

Next, I put in code to count the number of calls to rt_pipe_write() and the 
number of reads().  There is a growing gap that leads me to believe that the 
reader is not keeping up with the writer.

In the old FIFO-based code, we had a suspicion of the similar problem.  Since 
the linux process is not real time, we expect multiple messages to be waiting.  
To avoid running through the select/read loop once for each message, our old 
FIFO-based code opened the file in nonblocking mode and did a read into a buffer 
that could hold up to 100 messages.  We generally would read 5-7 at a time, 
not 100, so this proved that the reader could keep up when reading in batches.

Using this same technique with the /dev/rtpN end of a Message Pipe never reads 
more than 1 message.  I tried both blocking and non-blocking modes but got the 
same result.  So this is my main question: knowing that there are likely many 
messages in the pipe, how do I read them in a batch?




The description about is simplified.  I'm not sure whether this matters, but 
I'll give some more context.  

In the actual code, we have three queues with messages of different sizes: 
approximately 120, 150, and 1500 bytes.  In each iteration, the real time task 
generates exactly one of the largest message,  generally about 2 of the 
smallest, and generally none of the middle size.  But the small and middle 
sizes can have anywhere from 0 to maybe 10 on any one iteration.  

The linux process has multiple threads.  The main thread uses a select() loop 
that waits for input on the small and medium sized queues as well as a timer 
and a UDP socket.  The loop code handles all those inputs as they occur.  Both 
the small and middle queue use the read-in-batches technique but both only 
read 1 message each pass.

The largest queue is handled by a different thread that also uses a select() 
loop, but the large queue is the only input handled.  The read-in-batch 
technique is not used here.

When I created the pipes with poolsize=0, all three queues would eventually 
begin to return -ENOMEM.  After switching to poolsize=1000*sizeof(message), it 
seems to be only the middle-sized message that fails to allocate.  That's not 
a conclusive observation, but if the other two are failing to allocate it is 
much less often than the middle one which eventally gets stuffed up and always 
fails.  This is quite surprising to me.

I will admit that I did look through the code for the pipe [2,3] but wasn't 
able to discover the answer to my first question.   Any tips gratefully 
appreciated!

Thanks,
-Steve


[1] http://www.xenomai.org/pipermail/xenomai/2014-July/031365.html
[2] 
http://git.xenomai.org/xenomai-2.5.git/tree/ksrc/skins/native/pipe.c?id=v2.5.6
[3] http://git.xenomai.org/xenomai-2.5.git/tree/ksrc/nucleus/pipe.c?id=v2.5.6




