Message-ID: <4565CC77.608@domain.hid>
Date: Thu, 23 Nov 2006 17:29:43 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN: multiple sockets on one device
References: <DD39B5C3F4963040ADC9768BE7E430CB015D51BC@is-hdq-exchange.marel.net>
	<4565C1D7.9060509@domain.hid>
In-Reply-To: <4565C1D7.9060509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Daniel Schnell wrote:
>> Hi,
>>  
>> If one opens two sockets to one CAN port and wants to use one socket
>> file descriptor for reading and the other for writing, is it possible to
>> limit the writing socket to _write only_, so it doesn't receive messages
>> ?

Note that the messages are aways received and handled by the ISR. If 
nobody is waiting on messages defined by the filter definitions, they 
will be discarded.

> Option 1: Do not bind the socket, use sendto/sendmsg for transmitting
> (send requires binding).

Yes, this will avoid checking one unnecessary filter definition (a bit 
less overhead). But using just one socket would be fine as well ;-).

> Option 2: Register an impossible filter for the write-only socket. This
> is suboptimal ATM. Actually we should allow registering an empty filter
> list for this purpose. This has been recently discussed on the socketcan
> list, but I'm not aware of any concrete result.

Oliver answered and liked the idea, but there is no agreement yet.

Wolfgang.


