MIME-Version: 1.0
In-Reply-To: <60201cc7-e4fd-cfaa-d714-ef26d65172c8@xenomai.org>
References: <CAKJ14NckF3bxk=o5k6U7krGyYLKA0bVRNmsNiT4qki==UAR6Pg@mail.gmail.com>
 <60201cc7-e4fd-cfaa-d714-ef26d65172c8@xenomai.org>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Tue, 31 Jan 2017 12:06:07 +0000
Message-ID: <CAKJ14NftBo=S4r3iPnN_dTSjg-MmES4Adi_nGDjoMAJK964iDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] POSIX socket() call switches to secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Jan 31, 2017 at 9:27 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/30/2017 01:27 PM, Andreas Glatz wrote:
>> Hi
>>
>> During optimisation I found out that I have a POSIX socket() call for
>> opening a TCP connection that tends to switch to secondary mode, which
>> I expected to stay in primary mode. However, then I found a post [1],
>> which says that it is in fact considered normal behaviour:
>
> A TCP socket can only be created by the regular Linux kernel, never by
> the Xenomai co-kernel. For this reason, you cannot expect it to keep the
> caller in primary mode anyway.
>
>>
>> "rt_dev_socket may cause a switch to secondary mode, yes, this is
>> perfectly normal, only sending and receiving data is guaranteed to not
>> cause a switch to secondary mode."
>>
>> I also saw that this post was from 2014.... I am wondering now if this
>> is still considered normal behaviour for the current version of
>> socket() (POSIX skin of Xenomai 2.4.6 on arm linux 3.0.35)?
>>
>
> 2.4.6 dates back to Nov 2008, by current, I assume you mean 3.x.
> Speaking about the latter, switching to secondary mode is a general rule
> applicable to any system call that creates a new resource in the Xenomai
> system, at the notable exception of anonymous semaphores, mutexes and
> convars which trigger no mode transition regardless of the calling domain.
>
> The rationale for the common behavior is based on the requirement to
> obtain resources from the Linux kernel to fulfill the operation on the
> Xenomai side. The process of allocating/creating the following resources
> typically involves a switch to secondary mode:
>
> - named semaphores
> - message queues
> - connections to RTDM named device
> - creation and possibly binding to RTDM sockets (depends on the
> implementation of the socket protocol)
> - timerfd
> - threads

Thanks for clarification. I'm actually porting a piece of software to
Xenomai that was written for another OS, where the developers assumed
it was OK to put initialization commands for a network connection
directly in the main processing loop. On Xenomai the main processing
loop should always stay in primary mode, hence my questions.

So I think my solution here is to create some sort of connection
broker that (re)establishes the network connection to the peer in
another thread that can mode switch, and have the main thread just
read/write on an established network connection. As you suggested this
would also be future proof in case things ever move to Xenomai 3.x on
our side...

Kind regards,

Andreas

