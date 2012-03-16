Message-ID: <4F63867D.7060204@domain.hid>
Date: Fri, 16 Mar 2012 19:29:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1331579565.394426122@domain.hid>
	<4F5E51E2.1020802@domain.hid>
	<1331829045.814121867@domain.hid>
In-Reply-To: <1331829045.814121867@domain.hid>
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

On 03/15/2012 05:30 PM, Doug Brunner wrote:
> Thanks Philippe. I hadn't even known about the existence of the RTIPC driver, and I definitely like the idea.
>
> I've been experimenting with it a bit today, and found that it seems to be allowed for more than two sockets to connect to the same port. I modified iddp-sendrecv.c to have two client processes, both of which now connect to the same port as the server, then did the same thing with iddp-label.c (two clients both connect()ing to the same label).
>
> This would cause havoc with the communications that go on between my processes--they need a one-to-one channel. I could implement semaphores to enforce this, but it would be nice to avoid that complication. Is there a way to make it happen using just the socket interface?

The RTIPC protocols are fundamentally datagram-based, so allowing N:1 
data paths is wanted. If the issue is about picking a different port 
each time you bind a server socket in the AF_RTIPC domain, then I would 
suggest to set sipc_port to -1 when binding the server-side socket: a 
free port will be picked automatically. You could then use getsockname() 
to retrieve the actual port #, and pass it to the clients.

>
>      Doug Brunner
>
> -----Original Message-----
> From: "Philippe Gerum"<rpm@xenomai.org>
> Sent: Monday, March 12, 2012 12:43pm
> To: "Doug Brunner"<dbrunner@domain.hid>
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
>
> On 03/12/2012 08:12 PM, Doug Brunner wrote:
>> I'd like to be able to use native skin communications services (most importantly real time pipes) from a thread created with the POSIX skin. Is this safe?
>
> Yes, that's fine. You could also use the XDDP protocol (cross-domain
> datagram) implemented by the RTIPC Xenomai driver for exactly the same
> purpose, with a socket-based interface as a bonus.
>
>>
>> I'm doing this because I'm building a C++ library that can use either real-time communications services, when used with a real-time application, or regular Linux pipe I/O, when used with a Linux application; these services are called by tasks that need to exist in both cases. I'd like to make the tasks always POSIX threads to eliminate the need for a bunch of wrappers and preprocessor ugliness that I put there to support either skin, depending on which version of the library is being built.
>>
>> Thanks,
>>       Doug Brunner
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>


-- 
Philippe.

