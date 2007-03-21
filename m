Message-ID: <4601A451.7090408@domain.hid>
Date: Wed, 21 Mar 2007 22:32:01 +0100
From: Robin Walser <robinwalser45@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Socket Buffer overflow
References: <460191E0.7020606@domain.hid> <4601993C.5010701@domain.hid>
In-Reply-To: <4601993C.5010701@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


> Are you using RT-Socket-CAN? Could you please provide more detailed 
> information like what is the returned error code and are there kernel 
> log messages (visible with $ dmsg)?
>
> Wolfgang.
My programm based on frag-ip: 
http://www.rts.uni-hannover.de/rtnet/lxr/source//examples/xenomai/native/frag-ip.c
I use RTnet. The returned error code is always -115 and I have no kernel 
log messages.
I think, I'm only need a buffer status report. Is this available?

Robin


