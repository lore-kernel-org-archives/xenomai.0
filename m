Subject: Re: Big jitter issues every 5 seconds
References: <FE2C94EF-3136-482C-9A4A-CF252AD452F0@aliyun.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b819286b-54f5-1c9f-9384-f86d18ddcb37@siemens.com>
Date: Mon, 23 Aug 2021 08:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <FE2C94EF-3136-482C-9A4A-CF252AD452F0@aliyun.com>
Content-Type: text/plain; charset="utf-8"
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
To: Ivan Jiang <jcgeforce@aliyun.com>, xenomai@xenomai.org

On 20.08.21 19:14, Ivan Jiang via Xenomai wrote:
> Dear xenomai Oners:
> 
>  
> 
>        My name is Ivan and our company use xenomai 3.10 patched on Linux 4.19.94 worked on Daul core Cortex A7 800MHz CPU.
> 
>        We used this solution to build an EtherCAT Master controller.
> 
>        With the isolcpus=1 nohz=on nohz_full=1  rcu_nocbs=1 the user space latency waveforms is like below:
> 
>  
> 
>        Normally jitter is from -10~10uS every 1mS period,
> 
>        With a -30~30uS worst jitter every 200mS which made by our wifi AP enabled on our A7 Core board, this one could be disappeared if we turned off the WIFI.
> 
>        But the most unimaginable jitter is up to -55~55uS every 5S, which could not find any reason,  that we closed all the peripherals on the board except the EtherCAT.
> 
>        Whatever we turn on/off the L2 Cache or change the size of registry slots and size of system heap / private heap / shared heap.
> 
>        Our biggest problems are why WIFI could influent the Jitters and the biggest jitter every 5S is forbidden, we must get rid of them.
> 
>        Could you help us to analysis these questions.
> 

I'm afraid, 55 µs is already quite good for such a low-end system, even
with core isolation measures.

The last-level caches are typically shared (maybe lstopo can visualize
their hierachy), and the RT workload will likely not fit into core-local
L1 caches. So you cannot avoid eventual spikes already from that
perspective.

In addition, there are likely contention points on the I/O path of your
SoC - only the SoC vendor may be able to tell you where. One you
apparently found already (access to wifi vs. access to Ethernet or
something else on the RT I/O path).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

