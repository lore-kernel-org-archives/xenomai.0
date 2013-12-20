Message-ID: <52B458F3.70708@xenomai.org>
Date: Fri, 20 Dec 2013 15:49:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52B231AD.2010604@alaxarxa.net> <52B4184A.2090900@xenomai.org>
 <201312201343.01875.leo@alaxarxa.net>
In-Reply-To: <201312201343.01875.leo@alaxarxa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xddp protocol: question of one example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 12/20/2013 01:42 PM, Leopold Palomo-Avellaneda wrote:
> A Divendres, 20 de desembre de 2013, Philippe Gerum va escriure:
>> On 12/19/2013 12:37 AM, Leopold Palomo-Avellaneda wrote:
>>> Hi,
>>>
>>> I'm developing an application that need (as always) interchange data
> between a realtime part and non-realtime.
>>>
>>> Looking on the documentation and surfing on the web I have found
> interesting for my app the examples of xddp protocol. Some time ago, there was
> an interesting mail about it [1].
>>>
>>> There, the original author ask one thing that I would like to be sure that
> I understood. On the examples, the realtime thread uses the function
> recvfrom() to receive data from the non-rt thread.
>>>
>>> In the mail, the original author asked about make recvfrom
>>> call non-blocking in xddp context, and *Philippe Gerum* answered that
>>> MSG_DONTWAIT should be set in flags.
>>>
>>> So, my question is that using that flag, some code like this:
>>>
>>>
>>> /* Read back packets echoed by the regular thread */
>>> ret = recvfrom(s, buf, sizeof(buf), 0, NULL, 0);
>>> if(ret <= 0)
>>>       fail("recvfrom");
>>>
>>> recvfrom will not be blocked, but it will return 0?
>>>
>>> May I understood that if there's data on the sockect recvfrom will
>>> return something and if no, it would not be blocked and return something?
>>>
>>
>> Standard behavior when no data present: immediate return with ret = -1,
>> errno = EWOULDBLOCK/EAGAIN.
>
> Ok,
>
> if you are writing some data (some bytes) in the socket, can I trust that
> recvfrom will return -1 until ALL data is transferred?
>

Yes, guaranteed for all nrt -> rt transfers. This also applies the other 
way, unless MSG_MORE is given to sendmsg() with streaming mode enabled 
for the socket, and the message spans multiple output buffers (see 
setsockopt(XDDP_BUFSZ) for enabling streaming mode).

-- 
Philippe.

