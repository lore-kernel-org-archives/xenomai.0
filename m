Subject: Re: [RTnet] RTcfg: error -11
References: <20200309155830.Horde.qT5DihtwzbpuZDudGbUV2U3@webmail.b-tu.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d6a118f-744f-a577-3e8e-dd4edbc3e371@siemens.com>
Date: Mon, 9 Mar 2020 19:53:12 +0100
MIME-Version: 1.0
In-Reply-To: <20200309155830.Horde.qT5DihtwzbpuZDudGbUV2U3@webmail.b-tu.de>
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
To: Benji <miethben@b-tu.de>, xenomai@xenomai.org

On 09.03.20 15:58, Benji via Xenomai wrote:
> Hi,
> 
> i try to get RTnet up and running, but there are some issues with setup.
> 
> Two system are connected via a switch. Both have 2 network interface,
> Intel i210 and Intel 82574L. Only Intel i210 is used by Xenomai/ RTnet.
> One system is configured as master in 'rtnet.conf', the other one as a
> slave. If 'rtnet start' is executed following outputs appears.
> 
> Master:
> 
>> Waiting for all slaves...
> 
> Slave:
> 
>> Stage 1: searching for master...
> 
> RT interface came up as 'rtifconfig' is shown, but both hang on there 
> stages.
> 
> At master the dmesg output are floated with messages like:
> 
>> [  323.903321] rt_igb: rteth0: Reset adapter
>> [  323.905082] TDMA: Failed to transmit sync frame!
>> [  323.910082] TDMA: Failed to transmit sync frame!
>> [  323.915083] TDMA: Failed to transmit sync frame!
>> [  323.920083] TDMA: Failed to transmit sync frame!
>> [  323.932087] RTcfg: error -11 while sending stage 1 frame
> 
> Anybody knows that error -11 means? I can't find any information on
> this error code.

EAGAIN - the tx queue is filled up, no packets go out, eventually the 
sender is out of (statically allocated) resources. Does transmission 
work fine without RTmac/TDMA? Might be that interrupt are not coming 
(/proc/xenomai/irq).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

