Message-ID: <53FD8FBA.3070403@xenomai.org>
Date: Wed, 27 Aug 2014 09:58:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.981.1409108395.5713.xenomai@xenomai.org>
 <860f4c66b4b34363a35ca81ac139eaba@CVEX13.valentin-carl.de>
In-Reply-To: <860f4c66b4b34363a35ca81ac139eaba@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SPI tx underflow interrupt not available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/27/2014 09:48 AM, Reitinger, Peter wrote:
> On 08/26/2014 04:24 PM, Reitinger, Peter wrote:
>> Dear Xenomai people,
>> 
>> 
>> I am currently trying to write an SPI slave rtdm driver with fifo
>> and dma support. I would like to receive an interrupt if there is
>> an underflow in the tx fifo.
>> 
>> Therefore I try to request the related hardware interrupt (which is
>> irq 125 at my emtrion board which has EDMA and 2 McSPI interfaces
>> where I am trying McSPI1).
> 
> Are you sure the irq number is 125? If 125 is a "physical" irq
> number, it is almost probably not the number you should pass to 
> rtdm_irq_request. Have you tried requesting it as a Linux interrupt?
> 
> 
> 
>> 
>> Unfortunately it seems that interrupt 125 is reserved by another
>> linux
> driver because a list of /proc/irq/125 shows:
>> 
>> root@dimm-am335x:/proc# ls /proc/irq/125 53100000.sham  spurious
> 
> Have you tried grepping "sham" in the kernel sources?
> 
> No, I am absolutely unsure if 125 is the right number because I am
> relatively new in programming interrupts in the kernel. So I feel I
> have to read a lot about interrupts in linux? So I have to combine
> original linux kernel function calls and xenomai function calls to
> get interrupts working?

No, the idea is to test the interrupt with Linux alone first, to avoid
any potential bug that Xenomai or more probably the I-pipe patch would add.

> Sorry that I have so few experience there...
> If you have a quick help in mind even though it is not directly
> related to Xenomai, you would help me a lot... :-/
> 
> Thx, I will try to grep for sham. I am afraid there might be a lot of
> hits...

I have done it (grepped \bsham\b) and found that omaps have a peripheral
named sham which is a crypto device.

-- 
                                                                Gilles.

