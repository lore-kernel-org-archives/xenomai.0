Message-ID: <4F79CADD.9020704@domain.hid>
Date: Mon, 02 Apr 2012 17:50:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1331579565.394426122@domain.hid>
	<4F5E51E2.1020802@domain.hid>
	<1331829045.814121867@domain.hid>
	<4F63867D.7060204@domain.hid>
	<1332778457.241521523@domain.hid>
	<4F71EA1B.4080001@domain.hid>
	<1332884156.408323832@domain.hid>
In-Reply-To: <1332884156.408323832@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Doug Brunner <dbrunner@domain.hid>
Cc: xenomai@xenomai.org

On 03/27/2012 11:35 PM, Doug Brunner wrote:
> The usage pattern would be a bit like BSD ptys--the server maintains a few ports, say named "server0" through "server15" and clients that need a port try "server0", if it's busy then try "server1", etc..

An option to mimic this partially might be to define a fixed port number 
clients would use to ask the server for a free port to connect to later 
on? The server would let the RTIPC layer pick a free port when binding, 
then return it to the client via a converse message to the fixed port.

>
> I suppose the problem here is really that the application running over these sockets is stateful, the configuration of the nodes (processes) that are communicating is not known until run time, and nodes may appear and disappear as the server runs, so the transport needs to be connection-oriented rather than message-oriented. The semaphore is still a bit of a kludge, since it doesn't notify a thread blocked on recv() that the remote has hung up, but it works well enough in conjunction with a message that says "I'm a client that's newly connected to this server" to reset the state associated with the connection. I suppose I could implement a sort of TCP handshake on top of the IDDP socket layer and use that to provide true connection-oriented behavior.

Yep, RTIPC won't help that much by default in that area, it only 
exhibits connectionless semantics.

>
> Good to know about in-order delivery; a quick glance at the source code seemed to suggest that, but I wasn't sure.
>
>      Doug Brunner
>
> -----Original Message-----
> From: "Philippe Gerum"<rpm@xenomai.org>
> Sent: Tuesday, March 27, 2012 9:26am
> To: "Doug Brunner"<dbrunner@domain.hid>
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
>
> On 03/26/2012 06:14 PM, Doug Brunner wrote:
>> Thanks for the information--the issue is not about picking a free port on the server side, but rather about communicating the information on which ports are "free" to the clients (server has connected its end, but no other client is using the port). The semaphore mechanism isn't that much of a problem, though; I've been able to build a satisfactory implementation.
>
> Mm, still scratching my head to understand the issue. Both the client
> and server side accept -1 as the port spec, telling the kernel to draw a
> free port. I understand the issue is not on the server side, so is it on
> the client side?
>
> Could you sketch the usage pattern?
>
>>
>> One other question: although I know in-order delivery isn't necessarily a feature of datagram based protocols, would I get that with an IDDP socket connection between just two processes, and/or an XDDP connection to a /dev/rtpN?
>
> Yes, in-order delivery is guaranteed with all RTIPC protocols. This is
> written in stone.
>
>>
>>       Doug Brunner
>>
>> -----Original Message-----
>> From: "Philippe Gerum"<rpm@xenomai.org>
>> Sent: Friday, March 16, 2012 11:29am
>> To: "Doug Brunner"<dbrunner@domain.hid>
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
>>
>> On 03/15/2012 05:30 PM, Doug Brunner wrote:
>>> Thanks Philippe. I hadn't even known about the existence of the RTIPC driver, and I definitely like the idea.
>>>
>>> I've been experimenting with it a bit today, and found that it seems to be allowed for more than two sockets to connect to the same port. I modified iddp-sendrecv.c to have two client processes, both of which now connect to the same port as the server, then did the same thing with iddp-label.c (two clients both connect()ing to the same label).
>>>
>>> This would cause havoc with the communications that go on between my processes--they need a one-to-one channel. I could implement semaphores to enforce this, but it would be nice to avoid that complication. Is there a way to make it happen using just the socket interface?
>>
>> The RTIPC protocols are fundamentally datagram-based, so allowing N:1
>> data paths is wanted. If the issue is about picking a different port
>> each time you bind a server socket in the AF_RTIPC domain, then I would
>> suggest to set sipc_port to -1 when binding the server-side socket: a
>> free port will be picked automatically. You could then use getsockname()
>> to retrieve the actual port #, and pass it to the clients.
>>
>
>


-- 
Philippe.

