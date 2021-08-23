Subject: Re: Big jitter issues every 5 seconds
References: <FE2C94EF-3136-482C-9A4A-CF252AD452F0@aliyun.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <8cf26766-7cc1-4bf5-d92f-75f9a247da78@numalliance.com>
Date: Mon, 23 Aug 2021 09:25:27 +0200
MIME-Version: 1.0
In-Reply-To: <FE2C94EF-3136-482C-9A4A-CF252AD452F0@aliyun.com>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I understand that you must check max jitters in your system.

However, I have already designed ethercat master stacks.

By design, having 55us or more jitter when sending the sync frame  is 
not a problem for an Ethercat master system,  since the implementation 
of this bus permits it.

Regards,

S.Ancelot

Le 20/08/2021 à 19:14, Ivan Jiang via Xenomai a écrit :
> Dear xenomai Oners:
>
>   
>
>         My name is Ivan and our company use xenomai 3.10 patched on Linux 4.19.94 worked on Daul core Cortex A7 800MHz CPU.
>
>         We used this solution to build an EtherCAT Master controller.
>
>         With the isolcpus=1 nohz=on nohz_full=1  rcu_nocbs=1 the user space latency waveforms is like below:
>
>   
>
>         Normally jitter is from -10~10uS every 1mS period,
>
>         With a -30~30uS worst jitter every 200mS which made by our wifi AP enabled on our A7 Core board, this one could be disappeared if we turned off the WIFI.
>
>         But the most unimaginable jitter is up to -55~55uS every 5S, which could not find any reason,  that we closed all the peripherals on the board except the EtherCAT.
>
>         Whatever we turn on/off the L2 Cache or change the size of registry slots and size of system heap / private heap / shared heap.
>
>         Our biggest problems are why WIFI could influent the Jitters and the biggest jitter every 5S is forbidden, we must get rid of them.
>
>         Could you help us to analysis these questions.
>
>         Sincerely we need your help.
>
>   
>
>         Thank you,
>
>         BR.,
>
>         Ivan
>
>   
>
>   
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image001.png
> Type: image/png
> Size: 319147 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20210821/03a1463a/attachment.png>
