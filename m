Subject: Re: Kernel module symbol conflicts
References: <0fe3471eadf34083b9de1b766c327c72@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9ec08cea-b00a-29d6-1c77-772717483de0@siemens.com>
Date: Tue, 2 Apr 2019 12:59:25 +0200
MIME-Version: 1.0
In-Reply-To: <0fe3471eadf34083b9de1b766c327c72@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 28.03.19 16:12, Lange Norbert via Xenomai wrote:
> Hello,
> 
> We use a setup with multiple network controllers, and so far only one of them is realtime capable.
> The issue is, that there are nonRt and Rt drivers active at the same time (igb statically builtin and rt_igb as module).
> 
> And while it works, I got some irregular weird crashes. Is there an issue with the loaded rt_igb module having a lot symbols
> that are identically named with the igb driver?
> 
> Does that mean the rt_igp module will use the exported functions/variables from the igb driver,
> as a normal dynamic linker would?
> 
> Whats the policy of xenomai, should this even work (igp and rt_igp at the same time)?
> 
> Example of conflicting symbols:
> 
> # cat /proc/kallsyms | grep ' T igb_config'
> ffffffff94f3b2e0 T igb_configure_tx_ring
> ffffffff94f3b6f0 T igb_configure_rx_ring
> ffffffff94f49c30 T igb_config_collision_dist
> ffffffff94f49d50 T igb_config_fc_after_link_up
> 
> # nm /lib/modules/4.14.94-xeno2-static/kernel/drivers/xenomai/net/drivers/igb/rt_igb.ko | grep ' T igb_config'
> 0000000000004db0 T igb_config_collision_dist
> 0000000000004eb0 T igb_config_fc_after_link_up
> 000000000000dd60 T igb_configure_rx_ring
> 000000000000d9f0 T igb_configure_tx_ring
> 

Yeah, it's probably not a good idea having both drivers with identical symbols 
being active at the same time. These symbols aren't exported, but they are at 
least global. The proper solution would be renaming those of the rt_igb driver 
(and probably others from our stack).

Jan

