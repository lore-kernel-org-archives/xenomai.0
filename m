Subject: Re: rt_e1000e: Detected Hardware Unit Hang
References: <CALUpYNbg342eACKbNoxZkKV-ykGjRxJhS_xz0oJxzyeSKgxh6Q@mail.gmail.com>
 <07cfdeae-695f-127d-c38f-f3b6503946d2@siemens.com>
 <CALUpYNYPdbVMJ0Yc5kQV8SzhxWJwRKByyJhWYyUJSgpajZjCLA@mail.gmail.com>
 <8d5abaed-466d-cdf7-a933-0973e4174932@siemens.com>
 <CALUpYNYvpLS8r+bC5fOA2mhVPuVtcB6o8oY_7Bh7q_3QcPGeuA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e18a5494-424f-f1ea-6082-1232630a98f9@siemens.com>
Date: Tue, 27 Nov 2018 18:41:03 +0100
MIME-Version: 1.0
In-Reply-To: <CALUpYNYvpLS8r+bC5fOA2mhVPuVtcB6o8oY_7Bh7q_3QcPGeuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Means Lee <leemeaner@gmail.com>
Cc: xenomai@xenomai.org

On 27.11.18 10:47, Means Lee wrote:
> I can't reduce the size of my patch for the e1000e realtime driver existed in 
> Xenomai, because the non-realtime driver evolutions a lot. So I offered the diff 
> file of three files I changed when porting the driver. On my view, the hardware 
> oprations shall be unchanged so I focused on the change of netdev.c. I modfied 
> param.c and e1000.h changed the private data structure and parameters a little.
> 
> For the question you asked:
> - the upstream Linux driver I ported over works fine with my hardware, even when 
> I try to put a strong pressure on it(UDP broadcast storm).
> - when I meet the hardware unit hang, the Tx completion interrupt didn't 
> dissapper but it do reduced a lot.
> - I didn't enable CONFIG_IPIPE_DEBUG_CONTEXT, but I do uses lock in several places.

Then this should be the next thing to do. This not only detects direct locking 
issues but also those triggered by calling into Linux functions that take normal 
locks.

> - then the TX path
>     - the interrupt registertion code was shown below:
>              err = rtdm_irq_request(&adapter->irq_handle,
>                    adapter->pdev->irq, e1000_intr_msi, 0,
>                    netdev->name, adapter);
>     - I write a new index of ring buffer to TDT register to notify the hardware 
> there is an packet should be sent.
>              writel(tx_ring->next_to_use, tx_ring->tail);//after writel, the 
> interrupt routine shall be launched.
>     - If the 'event flow' means the event during the transmit process, the event 

I mean specifically if both the vanilla driver as well as the ported version 
take the code path and receive the same interrupts when sending packets. Of 
course, you can put identical package load on both because higher RTnet layers 
do no exist for vanilla Linux. You may capture the outgoing traffic under RTnet 
(RTcap) and replay that under Linux.

> flow is shown below:
>      e1000e_xmit_frame                        send an packet atomicly
>           e1000_tx_map                           use DMA to map the packet(maped 
> before,so just get the DMA address)
>           e1000_tx_queue                        make sure the tx ring buffer 
> index right
>           write the TDT register to tell hardware to send an packet
> after the hardware sent an packet, it supposed to trigger an TX completion 
> interrupt and the driver shall response:
>      e1000_intr_msi                                triggered when Tx/Rx completion
>           e1000_clean_tx_irq                    recycle the transmit resource
> 
> By the way, I found that every time master station sent an Ready frame belongs 
> to RTcfg, this Tx hung shows up. And the comunication
>   before that works fine: the TDMA sync frame send properly and every stage 
> before the Ready frame goes well.
> If I let it stay in the RTCFG_MAIN_CLIENT_2 stage(so far the master and slave 
> known each other), master and slave could comunicate
> properly. So the Ready frame triggers this problem, but why? An frame of 
> specific format triggers the hardware hung, why it happens?

RTcfg is unlikely to be the reason, but maybe the transmission pattern triggers 
the issue in the driver.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

