References: <27f25f2c-b872-9c8f-9068-bb3e8d3e1d1e@foxmail.com>
From: Jack Lee <jacklee11@foxmail.com>
Message-ID: <6c34772f-46cc-da8b-62bb-b1ebabb2ca38@foxmail.com>
Date: Tue, 27 Sep 2016 09:57:29 +0800
MIME-Version: 1.0
In-Reply-To: <27f25f2c-b872-9c8f-9068-bb3e8d3e1d1e@foxmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTcan: Assertation failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>, wg@grandegger.com



On 09/27/2016 09:27 AM, Jack Lee wrote:
> Hello,
>
> more on that subject:
>
> Am 26.09.2016 um 14:04 schrieb Wolfgang Grandegger:
> >//>/[ 5911.271780] rtcan0: real bitrate 1000000, sampling point 75.0% />/[ 5911.271806] rtcan_sja_set_bit_time: btr0=0x0 btr1=0x14 />/[ 5911.271868] Assertion failed! />/drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:178 dev->tx_socket == 0 />/[ 5911.271872] (1) TX skb still in use />/[ 6011.087098] rtcan0: real bitrate 1000000, sampling point 75.0% />/[ 6011.087119] rtcan_sja_set_bit_time: btr0=0x0 btr1=0x14 />/[ 7985.615408] perf interrupt took too long (2512 > 2500), lowering />/kernel.perf_event_max_sample_rate to 50000 />//>//>/Hi, Wolfgang, />//>/I got this error with my advantech PCM26D2CA CAN-board when real-time />/applications were running. />//>/The PCM26D2CA board has two ports: "rtcan0" was used by user />/applications and "rtcan1" was used by "rtcanrecv" to monitor CAN bus. />//>/The bitrate was set previously and not set explicitly here./
> What do you mean? It looks like bitrate was set while the interface was
> active... which should not be allowed. But unfortunately, it is. Anyway,
> I can not see how that function is called accidentally. Must be done
> somehow by you system. Or are there any other related messages in kernel
> log (dmesg) indicating that there was a bus error.
>
> Wolfgang.
Well, you reminded me and I checked my code. It was done by myself 
explicitly in fact. I have
a script to initialize the real-time environment which started the CAN 
device
and set the bit rate, and I set the bit rate again in my application.
It's my fault to start this thread and waste your time. Sorry for that.
Beg your pardon!

If I have a chance to travel to the Europe one day, I really want to 
have a visit on
you guys. If you come to China, especially Beijing, Wuhan, Shenzhen, 
don't hesitate to contact me, I am glad to help :)

Have a good day!



