Message-ID: <46C0368A.2080207@domain.hid>
Date: Mon, 13 Aug 2007 12:46:34 +0200
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
> On 8/13/07, *Jan Kiszka* <jan.kiszka@domain.hid <mailto:jan.kiszka@domain.hid>> 
> wrote:
> 
>     juanba romance wrote:
[...]
      That was discussed before in the context of Socket-CAN. My feeling is
>     that it /could/ be useful in case you have to issue longer streams of
>     CAN frames at high rates, and specifically if your CAN hardware can
>     handle these streams autonomously. Is the 82527 able to do so?
> 
>     In any case, this would complicate the existing stack and driver and
>     would first require careful evaluation of the achievable improvement
>     (lower latency, lower system load?). 
> 
> The i82527 has 15 mailboxes with fixed priority, the lowest one is 
> hardwared to the RX operation. So theoretically  you can pipeline up to 
> 14 TX messages. When the stuff is full, we are labeled it as a  
> "pileup"  because the hardware handler has to wait up to get some free 
> one, this operation is performed in our case through the either the 
> mailbox-alarm mechanism or the ISR transmission side . I have mention 

To be more precise, you have to wait that the object with the lowest 
priority, #14 has sent it's message, otherwise messages will be sent 
out-of-order.

> the "low latency" term, cause i have decoupled the loopback-tx feedback 
> from the ISR to a kernel RT thread/task so the ISR only cleans/stops the 
> mailbox software/hardware resources. The user call is only blocked the 
> time required to push the message bunch into the transmission ring. The 
> physical user transmission is performed in open-loop if no error/alarm 
> is sampled..   

Note that in RT-Socket-CAN messages are not queued in software nor in 
hardware for the sake of real-time. Just one message object will be used 
for sending. I also doubt, that there is a notable performance benefit 
from sophisticated TX queuing.

Wolfgang.



