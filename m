Message-ID: <4605C103.9070609@domain.hid>
Date: Sun, 25 Mar 2007 01:23:31 +0100
From: Viktor STARK <abraar@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
References: <20070322215707.232970@domain.hid>	
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>	
	<460481F2.5010408@domain.hid>	
	<b647ffbd0703240320ta4f54ccg344108ddd1f47958@domain.hid>	
	<1174737325.20953.24.camel@domain.hid> <4605149A.5090802@domain.hid>
	<1174776581.6467.15.camel@domain.hid>
In-Reply-To: <1174776581.6467.15.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Viktor STARK <stark.viktor@domain.hid>, Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Sat, 2007-03-24 at 13:07 +0100, Viktor STARK wrote:
>   
>>>   
>>>       
>> That looks like a pretty good solution. I'll be able to test this out on 
>> Monday. I'll keep the list posted about my results.
>>     
>
> Yeah, well, except that my last post was utter crap actually. I should
> really consider having sleep because I don't even remember how my code
> works, it seems. Ok, here is a fixed version: to sum up, you need to use
> rt_queues to do what you want to do, i.e. exchanging data in primary
> mode between real-time tasks. Performance-wise, there is no downside in
> using queues instead of pipes anyway, except when rt_pipe_stream() is
> actually appropriate for the sending side (i.e. when data is produced
> incrementally by small chunks, and the reader has lower priority than
> the sender).
>
>   
I knew it was too good to be true. ;)
> What I sketched would not work because rt_pipe_stream/read/write used
> >from user-space would still feed the real-time endpoint of a pipe, which
> could only be read from a non real-time endpoint. 
Right. I guess feeding the same endpoint all the time won't really make 
both sides communicate.
I knew that there was some reason why I hadn't even tried rt_pipe_* in 
user space. Thanks for reminding me what that reason was. :)
> IOW, there is no way
> to use pipes for RT to RT communication, because data sent using
> rt_pipe_write() is only readable by read(), and data wrote by write() is
> only readable from rt_pipe_read(). The rt_pipe API is available from
> user-space in order to feed regular Linux tasks with real-time data
> produced from a user-space context, that's all.
>
> Sorry for the noise. Yes Dmitry, I'm going to take a nap right now, in
> order to fix this annoying -ENOBRAIN error that surges from time to
> time. Gasp...
>
>   

OK. So off I go with rt_queue_*. I'll keep the list posted.

Thanks again for all the support.

Viktor STARK

