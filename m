From: Wolfgang Grandegger <wg@grandegger.com>
References: <a7acf6ef-489a-98dc-edae-e45229dd9d3a@foxmail.com>
Message-ID: <984827b9-0e03-f90c-f269-ceaa42cd4d4c@grandegger.com>
Date: Mon, 26 Sep 2016 14:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <a7acf6ef-489a-98dc-edae-e45229dd9d3a@foxmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTcan: Assertation failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Am 26.09.2016 um 09:49 schrieb Jack Lee:
>
>  [ 5911.271780] rtcan0: real bitrate 1000000, sampling point 75.0%
>  [ 5911.271806] rtcan_sja_set_bit_time: btr0=0x0 btr1=0x14
>  [ 5911.271868] Assertion failed!
>  drivers/xenomai/can/rtcan_raw.c:rtcan_tx_push:178 dev->tx_socket == 0
>  [ 5911.271872] (1) TX skb still in use
>  [ 6011.087098] rtcan0: real bitrate 1000000, sampling point 75.0%
>  [ 6011.087119] rtcan_sja_set_bit_time: btr0=0x0 btr1=0x14
>  [ 7985.615408] perf interrupt took too long (2512 > 2500), lowering
>  kernel.perf_event_max_sample_rate to 50000
>
>
> Hi, Wolfgang,
>
> I got this error with my advantech PCM26D2CA CAN-board when real-time
> applications were running.
>
> The PCM26D2CA board has two ports: "rtcan0" was used by user
> applications and "rtcan1" was used by "rtcanrecv" to monitor CAN bus.
>
> The bitrate was set previously and not set explicitly here.

What do you mean? It looks like bitrate was set while the interface was 
active... which should not be allowed. But unfortunately, it is. Anyway, 
I can not see how that function is called accidentally. Must be done 
somehow by you system. Or are there any other related messages in kernel 
log (dmesg) indicating that there was a bus error.

Wolfgang.

