Message-ID: <45FE4FDE.7060604@domain.hid>
Date: Mon, 19 Mar 2007 09:54:54 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<45FD238F.2050009@domain.hid> <45FDA81F.2080004@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com>
In-Reply-To: <E1HTD6v-0004qo-QI@mailer.emlix.com>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Sebastian Smolorz wrote:
> Hi Jan,
> 
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> you know, on the SJA1000 the bus error interrupt can result in high
>>> error interrupt rates and even hang the system on slow processors. Just
>>> unplugging the CAN cable can cause such interrupt flooding. This problem
>>>
>>> popped up again recently and Sebastian proposed:
>>>> Last summer we had a discussion about the BEI issue on the
>>>> socketcan-ML. Two additional handling policies popped up:
>>>> 1. The interface could restart itself after an amount of BEIs, thus
>>>>    taking responsibility from the user application.
>>>> 2. The BEI could be completely disabled if no one is interested in
>>>>    this ype of error frame.
>>> As 2. is also my preferred solution, I have implemented it. The only
>>> downside is that you do not see the error counter increasing when
>>> /proc/rtcan/devices is inspected. We also discussed 1., but
>>> RT-Socket-CAN does not restart the CAN controller by purpose and just
>>> stoppping it requires user intervention.
>> And if there is someone listening, how is the flooding issue on cable
>> unplug etc. solved by option 2?
> 
> Hm, maybe we could implement 1 additionally (but without automatical restart)?
> 
>> What about something like option 3: After the first error occurred that
>> may mark the beginning of a flood, disable that error interrupt until
>> the next stop/start cycle or the user has read the event?
> 
> IIRC, there is no possibility to detect a "normal" bus error (acknowledge) 
> appearing during normal operation from the one occuring when the cable is 
> plugged off. The best indication is a high number of consecutive BEIs.

I agree. But the controller internally counts the errors as well 
reflected by the change of the state to warning or passive. If the 
application is interested in more details, it could listen on error 
messages.

Let's summarize the situation with 2. (on request bus errors) available:

- Bus error interrupts are suppressed unless an application really
   request them.

- If an application listens on error messages, a high interrupt rate
   could cause the socket buffer to overflow resulting in lost messages.
   As far as I have seen, this is not yet a real problem but it gets
   worse when debugging is configured and printk messages are generated:

   /* Overflow of socket's ring buffer! */
   sock->rx_buf_full++;
   RTCAN_RTDM_DBG("%s: socket buffer overflow (fd=%d), message "
                  "discarded\n",
		 rtcan_proto_raw_dev.driver_name, context->fd);

   This can indeed hang the system and I tend just to downscale the
   frequency of the log output by, let's say a factor of 10 or 20 and
   adding to the log:

   "Not all overflows are listed. Please inspect /proc/rtcan/sockets!"

Concerning 1. (stopping the device after n bus errors): I think this 
conflicts somehow with 2. because the application explicitly wants to 
receive them. If it realizes a high rate, it could react appropriately.

For the moment I think 2. and downscaled printk's are already be a big 
improvement and should make most users happy. Let's wait for some real 
world application requiring solution 1.

Wolfgang.

