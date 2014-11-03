Message-ID: <54573A6D.1030201@xenomai.org>
Date: Mon, 03 Nov 2014 09:18:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann> <20141031200007.GC378@sumost.ca>
 <5454ADDF.4040604@xenomai.org> <6071747.2uXMl1ZSO0@riemann>
In-Reply-To: <6071747.2uXMl1ZSO0@riemann>
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

On 11/02/2014 01:53 AM, Steve M. Robbins wrote:
> On November 1, 2014 10:54:39 AM Philippe Gerum wrote:

>> Perhaps the rt side sends a large burst of data once in a while causing
>> the overflow? In this case, you could not detect the issue looming from
>> the nrt side until it happens, since the rt side has higher priority
>> (i.e. rt would cause ENOMEM even before nrt had a chance to resume
>> execution).
> 
> OK, I understand the theory.  However, I don't believe that is my case.  The 
> message queue is transporting fault information and through user actions I can 
> set it up to send 2 messages per cycle and using the FIFO code, the nrt side 
> is indeed reading 2 messages.  Using message queues, I can see that there are 
> multiple messages outstanding but it reads only one.
> 

Ok, so if no message gets lost, if you can see FIONREAD increase until
ENOMEM is raised, and if throttling the rt side only delays the issue
without solving it, the only explanation would be that a notification of
input availability is lost by the poll handler backing select() in the
rt-pipe driver. That would cause the messages to pile up on the rt side,
with too few deliveries to nrt.

Only for the purpose of checking this, could you try read()ing the large
message queue directly, then in a second attempt, enabling SIGIO on the
rtp fildes to get the messages asynchronously, instead of sensing them
via select()? The idea would be to check whether getting rid of select()
improves the situation.

NOTE: I'm assuming that the rt side only uses rt_pipe_write(), and never
rt_pipe_stream() which does packet coalescence by design.

-- 
Philippe.

