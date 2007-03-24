Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4605149A.5090802@domain.hid>
References: <20070322215707.232970@domain.hid>
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
	<460481F2.5010408@domain.hid>
	<b647ffbd0703240320ta4f54ccg344108ddd1f47958@domain.hid>
	<1174737325.20953.24.camel@domain.hid>  <4605149A.5090802@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Mar 2007 23:49:41 +0100
Message-Id: <1174776581.6467.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Viktor STARK <abraar@domain.hid>
Cc: Viktor STARK <stark.viktor@domain.hid>, Xenomai help <xenomai@xenomai.org>

On Sat, 2007-03-24 at 13:07 +0100, Viktor STARK wrote:
> >   
> That looks like a pretty good solution. I'll be able to test this out on 
> Monday. I'll keep the list posted about my results.

Yeah, well, except that my last post was utter crap actually. I should
really consider having sleep because I don't even remember how my code
works, it seems. Ok, here is a fixed version: to sum up, you need to use
rt_queues to do what you want to do, i.e. exchanging data in primary
mode between real-time tasks. Performance-wise, there is no downside in
using queues instead of pipes anyway, except when rt_pipe_stream() is
actually appropriate for the sending side (i.e. when data is produced
incrementally by small chunks, and the reader has lower priority than
the sender).

What I sketched would not work because rt_pipe_stream/read/write used
from user-space would still feed the real-time endpoint of a pipe, which
could only be read from a non real-time endpoint. IOW, there is no way
to use pipes for RT to RT communication, because data sent using
rt_pipe_write() is only readable by read(), and data wrote by write() is
only readable from rt_pipe_read(). The rt_pipe API is available from
user-space in order to feed regular Linux tasks with real-time data
produced from a user-space context, that's all.

Sorry for the noise. Yes Dmitry, I'm going to take a nap right now, in
order to fix this annoying -ENOBRAIN error that surges from time to
time. Gasp...

-- 
Philippe.



