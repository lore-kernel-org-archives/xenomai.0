Subject: Re: [PATCH 5/6] drivers/can: fix updating of tx_count statistics
References: <20211124234648.7428-1-dariobin@libero.it>
 <20211124234648.7428-4-dariobin@libero.it>
 <23c7f9a2-6a27-fc52-5502-154cdc1f2cf6@siemens.com>
 <12883241.564980.1638028223215@mail1.libero.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <649492bd-0d53-3b1a-c84a-d5525b6a99f6@siemens.com>
Date: Mon, 29 Nov 2021 08:50:34 +0100
MIME-Version: 1.0
In-Reply-To: <12883241.564980.1638028223215@mail1.libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>

On 27.11.21 16:50, Dario Binacchi wrote:
> Hi Jan,
> 
>> Il 25/11/2021 11:28 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:
>>
>>  
>> On 25.11.21 00:46, Dario Binacchi wrote:
>>> As in the Linux kernel, the counter is updated only after the message
>>> has been really transmitted.
>>>
>>> Signed-off-by: Dario Binacchi <dariobin@libero.it>
>>> ---
>>>
>>>  kernel/drivers/can/mscan/rtcan_mscan.c     | 1 +
>>>  kernel/drivers/can/rtcan_flexcan.c         | 1 +
>>>  kernel/drivers/can/rtcan_raw.c             | 1 -
>>>  kernel/drivers/can/rtcan_virt.c            | 1 +
>>>  kernel/drivers/can/sja1000/rtcan_sja1000.c | 1 +
>>>  5 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/drivers/can/mscan/rtcan_mscan.c b/kernel/drivers/can/mscan/rtcan_mscan.c
>>> index 387e27cc0..da573aba6 100644
>>> --- a/kernel/drivers/can/mscan/rtcan_mscan.c
>>> +++ b/kernel/drivers/can/mscan/rtcan_mscan.c
>>> @@ -217,6 +217,7 @@ static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
>>>  		out_8(&regs->cantier, 0);
>>>  		/* Wake up a sender */
>>>  		rtdm_sem_up(&dev->tx_sem);
>>> +		dev->tx_count++;
>>>  
>>>  		if (rtcan_loopback_pending(dev)) {
>>>  
>>> diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
>>> index 7569d16f7..3348e8ce0 100644
>>> --- a/kernel/drivers/can/rtcan_flexcan.c
>>> +++ b/kernel/drivers/can/rtcan_flexcan.c
>>> @@ -897,6 +897,7 @@ static int flexcan_irq(rtdm_irq_t *irq_handle)
>>>  			      &priv->tx_mb->can_ctrl);
>>>  		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
>>>  		rtdm_sem_up(&dev->tx_sem);
>>> +		dev->tx_count++;
>>>  		if (rtcan_loopback_pending(dev))
>>>  			rtcan_loopback(dev);
>>>  		handled = RTDM_IRQ_HANDLED;
>>> diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
>>> index b17c1709d..dffc6e837 100644
>>> --- a/kernel/drivers/can/rtcan_raw.c
>>> +++ b/kernel/drivers/can/rtcan_raw.c
>>> @@ -844,7 +844,6 @@ static ssize_t __rtcan_raw_sendmsg(struct rtcan_device *dev, struct rtcan_socket
>>>  	goto send_out2;
>>>      }
>>>  
>>> -    dev->tx_count++;
>>>      ret = dev->hard_start_xmit(dev, frame);
>>
>> Can we solve this generically, without having to touch every driver?
> 
> IMHO I think not.
> 
>>
>> Should the counter only be updated when hard_start_xmit returns 0?
> 
> We are not sure if the message was transmitted. It may still be in the 
> transmission FIFO.
> The hard_start_xmit() of the C_CAN/D_CAN driver, returns 0 if it succeeded 
> in inserting the message into the transmit FIFO.
> 

Where does mainline CAN do the accounting?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

