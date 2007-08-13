Message-ID: <46C03F62.30009@domain.hid>
Date: Mon, 13 Aug 2007 13:24:18 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>	<46C01909.5020308@domain.hid>
	<e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
In-Reply-To: <e39c9190708130254x421a54b8le92acbf974a6fa58@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RTDM 82527 Xenomai driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

juanba romance wrote:
[...]
> After review your current user interface i can not understand how a RF 
> cycle flows through the user application
> holding as much as possible the latency at the receiver side. Maybe it's 
> my own misunderstanding.

Your just send a "remote transmission request" message and receive the 
response as a normal message.

> The point is one node requests an information to another one issuing a 
> RF, the CAN specification says that the RF receptor will handshake the 
> cycle issuing the corresponding DF, and right here is when/where i am 
> fuzzy. We use this capability using real time as much as possible only 
> relying on the CANbus network load, i mean we perform the RF handshake 
> using the RF receptor mailbox auto-reply capability, feedbacking the 
> user software only when the DF handshake is decoded at the network, this 
> event will trigger the user actions i.e. the message data update with 
> the new local variables state. This feature is requested through  the 
> configuration stage, this kind of information is labeled as "quick.ack" 
> responses , cause are not related with software at all. The RF requester 
> has the guarantee  that the information is sampled with any jitter 
> software coupled. The typical approach found in other stacks is labelled 
> as " slow.ack", it avoids to response the RF-request up to reach any 
> software area (kernel/user spaces) that explicitly issue the data-frame 
> as usual, this is how can-festival currently works.

Can you point me to the code in CAN-Festival supporting directly that 
feature of the i82527?

RTR message handling of the i82527 is very special and I do not know any 
other (non-compatible) CAN controller doing it in a similar way. The 
feature you like so much makes it actually a nightmare to support the 
i82527 in a generic framework (like RT-Socket-CAN or Socket-CAN), 
especially receiving RTR messages by justs using send and receive. 
Anyhow, supporting the RTR auto-reply capability in (RT-)Socket-CAN is 
feasible and would be a "nice to have". It could be supported by a 
generic RTR update object. Would be nice, if you bring-up the idea on 
the Socket-CAN mailing list to share it between other CAN experts with 
the goal to define an CAN-API extension.

Wolfgang.

