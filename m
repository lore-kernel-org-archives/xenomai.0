Message-ID: <52DD5803.5030104@xenomai.org>
Date: Mon, 20 Jan 2014 18:08:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <201401141315.38870.leo@alaxarxa.net>
 <201401201718.28484.leo@alaxarxa.net> <52DD4F00.4020703@xenomai.org>
 <201401201739.28209.leo@alaxarxa.net>
In-Reply-To: <201401201739.28209.leo@alaxarxa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xddp port questions
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

On 01/20/2014 05:39 PM, Leopold Palomo-Avellaneda wrote:
> A Dilluns, 20 de gener de 2014, Philippe Gerum va escriure:
>> On 01/20/2014 05:18 PM, Leopold Palomo-Avellaneda wrote:
>>> A Dimarts, 14 de gener de 2014, Philippe Gerum va escriure:
>>>> On 01/14/2014 01:15 PM, Leopold Palomo-Avellaneda wrote:
>>>>> Hi,
>>>>>
>>>>> in the example xddp-label a two realtime task are connected with a non-
>>>>> realtime time. They share the same port where one rt task receive from
> the
>>>>> non-rt task and the other send to rt-task.
>>>>>
>>>>> The regular thread read and write in the same devname
>>>>> (/proc/xenomai/registry/rtipc/xddp/XDDP_PORT_LABEL). One rt thread
> listen
>>> from
>>>>> that port.
>>>>>
>>>>> I don't understand how is possible that both (non-rt and rt threads)
>>> listen
>>>>> from the same port and could not have collisions  if two threads (non-rt
>>> and
>>>>> rt) try to write in the same port.
>>>>>
>>>>> Could not be better to separate it?
>>>>>
>>>>
>>>> No, that would defeat the purpose of the illustration.
>>>>
>>>> XDDP is a wrapper over Xenomai's message pipe support, offering a
>>>> socket-based interface to applications. Each XDDP port is mapped to a
>>>> given /dev/rtp device minor, but the communication endpoints between RT
>>>> and NRT are different internally.
>>>>
>>>> [XDDP-port] <---> xnpipe #<port>
>>>>                         ^
>>>>                         |
>>>>                         |  * input queue:  /dev/rtp -> xnpipe
>>>>                         |  * output queue: xnpipe -> /dev/rtp
>>>>                         |
>>>>                         v
>>>>                   /dev/rtp<port>
>>>>
>>>> So, when NRT reads from /dev/rtp<port>, it does not actually listen to
>>>> the same endpoint/queue than RT, because message pipes are
>>>> bi-directional. Likewise, NRT and RT never write to the same queue,
>>>> since the purpose of message pipes is to cross the RT/NRT domain
> boundary.
>>>
>>> Ok,
>>>
>>> in the example the same thread open a device for write and read from the
> same
>>> device. From your answer about the endpoints, I understand that when the
> NRT
>>> open for read, read from the RT world, and when the NRT writes to the RT
>>> world.
>>>
>>> So, could I have a NRT function (thread) that open the device to just read
>>> from the RT world and _another_ that send to the RT world?
>>>
>>> Because I have to one the same device, and I don't know that I could do it
> at
>>> the same time.
>>>
>>
>> You can both send-receive data to/from the same socket descriptor
>> RT-wise, and read-write from/to the same /dev/rtp* descriptor NRT-wise.
>> Message pipes are bi-directional by design, on both ends. In the XDDP
>> case, traffic is routed as follows:
>>
>> - RT-writes -> NRT-reads
>> - RT-reads <- NRT-writes
>>
>> So, fd = open("/dev/rtpX", ...) => read(fd, and write(fd, are allowed
>>       s = socket(AF_RTIPC, ...) => sendmsg(s,  and recv(s, are allowed.
>>
> Sorry if I have not been clear or I don't understand you. For design I would
> like to make a thread that:
>
> fd = open("/dev/rtpX", ...) => read(fd, ...
>
> to read
>
> and another thread to
>
> fd = open("/dev/rtpX", ...) => write(fd, ...
>
> so I open TWO times the /dev/rtpX, one for read and another for write, because
> I would like to use it in two different parts, and I don't know if it's
> allowed.

No, this won't work. open() is implicitly exclusive for those devices.

-- 
Philippe.

