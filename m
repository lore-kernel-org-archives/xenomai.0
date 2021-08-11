Subject: Re: [Xenomai 4] Heads up
References: <87y299tb20.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d37d434-6193-9841-ad34-278979019165@siemens.com>
Date: Wed, 11 Aug 2021 09:58:00 +0200
MIME-Version: 1.0
In-Reply-To: <87y299tb20.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 10.08.21 20:21, Philippe Gerum via Xenomai wrote:
> 
> I won't join the Xenomai meeting this week, so this is the latest news
> from Dovetail and Xenomai 4:
> 
> Dovetail runs on top of v5.14-rc5 (arm, arm64 and x86_64), the code is
> visible from the v5.14-dovetail-rebase branch at [1].  As usual, I'm
> testing Dovetail with the EVL core (Xenomai 4). The current code is
> available at [2] branch v5.14-evl-rebase.
> 
> In addition, several important updates went to the stable Dovetail
> (v5.10.y) tree (i.e. RCU NMI in the pipeline entry). There is no kernel
> interface change which might affect Xenomai3/Cobalt 3.2 though.
> 
> With respect to Xenomai 4, progress was made with the network
> (mini-)stack based on the EVL core. The most important aspect is that
> EVL is now able to leverage the common socket interface, for adding new
> network protocols or extending existing ones. This is still WIP, but we
> are getting closer to something usable, and EVL gained a socket
> interface in the process for dealing with real-time protocols.
> 
> In a nutshell, the basic idea is to create an out-of-band data path
> traversing the regular network stack which EVL and the applications can
> connect to. This means that a netdev can accept in-band and out-of-band
> traffic, ethtool is still available to configure the ethernet devices
> shared with EVL etc. (as a bonus, there is no need for any proxy in
> order to share a single NIC between the out-of-band and in-band network
> stacks). There is work ahead, and this is fun stuff.
> 
> [1] git@source.denx.de:Xenomai/linux-dovetail.git
> [2] git@source.denx.de:Xenomai/xenomai4/linux-evl.git
> 

Surely interesting work. Three even more interesting aspects still needs
to be seen, though:

 - How will driver conversions look like in practice (lock and interrupt
   conversions, prioritization of data paths over control paths, turning
   off throughput favoring features)?

 - How to provide zero copy (not available with RTnet either, yes, but
   needed for lowest-latency traffic in the future)?

 - How to make buffer allocation similarly deterministic as with rtskbs
   (e.g. an evl_net_dev_alloc_skb that needs no timeout but uses a
   per-socket pool again)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

