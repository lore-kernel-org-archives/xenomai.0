References: <87y299tb20.fsf@xenomai.org>
 <3d37d434-6193-9841-ad34-278979019165@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Xenomai 4] Heads up
Message-ID: <875yw8xxtc.fsf@xenomai.org>
In-reply-to: <3d37d434-6193-9841-ad34-278979019165@siemens.com>
Date: Sun, 15 Aug 2021 11:21:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 10.08.21 20:21, Philippe Gerum via Xenomai wrote:
>> 
>> I won't join the Xenomai meeting this week, so this is the latest news
>> from Dovetail and Xenomai 4:
>> 
>> Dovetail runs on top of v5.14-rc5 (arm, arm64 and x86_64), the code is
>> visible from the v5.14-dovetail-rebase branch at [1].  As usual, I'm
>> testing Dovetail with the EVL core (Xenomai 4). The current code is
>> available at [2] branch v5.14-evl-rebase.
>> 
>> In addition, several important updates went to the stable Dovetail
>> (v5.10.y) tree (i.e. RCU NMI in the pipeline entry). There is no kernel
>> interface change which might affect Xenomai3/Cobalt 3.2 though.
>> 
>> With respect to Xenomai 4, progress was made with the network
>> (mini-)stack based on the EVL core. The most important aspect is that
>> EVL is now able to leverage the common socket interface, for adding new
>> network protocols or extending existing ones. This is still WIP, but we
>> are getting closer to something usable, and EVL gained a socket
>> interface in the process for dealing with real-time protocols.
>> 
>> In a nutshell, the basic idea is to create an out-of-band data path
>> traversing the regular network stack which EVL and the applications can
>> connect to. This means that a netdev can accept in-band and out-of-band
>> traffic, ethtool is still available to configure the ethernet devices
>> shared with EVL etc. (as a bonus, there is no need for any proxy in
>> order to share a single NIC between the out-of-band and in-band network
>> stacks). There is work ahead, and this is fun stuff.
>> 
>> [1] git@source.denx.de:Xenomai/linux-dovetail.git
>> [2] git@source.denx.de:Xenomai/xenomai4/linux-evl.git
>> 
>
> Surely interesting work. Three even more interesting aspects still needs
> to be seen, though:
>
>  - How will driver conversions look like in practice (lock and interrupt
>    conversions, prioritization of data paths over control paths, turning
>    off throughput favoring features)?
>

There is no one-fits-it-all approach to this, but the idea remains the
same for any EVL-related changes in drivers:

- define clear-cut operating modes for the driver, in-band should not
  overlap with out-of-band during time-critical operations. E.g. no
  significant reconfiguration while out-of-band packets are in flight,
  that would have to wait until the oob activity pauses, contention on
  the converse path is deemed an application bug. However, mixing
  in-band and out-of-band traffic on the same device should be possible
  without proxying, with the software always giving precedence to the
  latter when it comes to feeding the driver.

- ensure that all code paths are categorized between in-band only,
  out-of-band only, and shared between stages. From that point, use some
  EVL mechanisms if/when applicable like "staxes" in order to enforce
  basic sanity between the first two. Dovetail also has "hybrid locks",
  which can be traversed from any stage, still abiding by the semantics
  of the current stage (in that sense, this is distinct from "hard"
  locks which enforce the semantics of the out-of-band stage). Of
  course, that means that the length of the covered sections should be
  compatible with real-time requirements.

These details are only part of the solution obviously, there will be
more issues to deal with.  However, there is at least one hurdle less:
the mini-stack does not define its own (rt)skb type, but rather happily
conveys all the traffic via the common sk_buff. This tends to limit the
amount of code which needs to be adapted in a NIC driver.

I'm thinking about enabling some form of out-of-band support in the
NAPI, but this idea is still brewing, nothing concrete yet.

>  - How to provide zero copy (not available with RTnet either, yes, but
>    needed for lowest-latency traffic in the future)?
>
>  - How to make buffer allocation similarly deterministic as with rtskbs
>    (e.g. an evl_net_dev_alloc_skb that needs no timeout but uses a
>    per-socket pool again)?

A "generic" per-socket pool would assume too much about the identity of
the DMA mapping for any given socket buffer among multiple devices
(which is the limitation rtskb_map() lives with). Since the regular way
is to have a per-device mapping strategy, the pre-mapped buffers we need
should be obtained from the device driver, not from the generic net
core. In order to achieve some form of starvation prevention, I would
rather go for limiting the amount of buffer memory consumed by a socket
at any point in time, similarly to the sk_{r|w}mem_alloc counters of the
regular net core.

Added to that, a socket would be allowed to reserve a number of socket
buffers from a given device pool, which corresponds to the arbitrary
amount of memory specified for SO_SNDBUF. The mini-stack would then
contribute the corresponding number of freshly allocated buffers to the
proper per-device pool. Conversely, such ownership would influence the
way out-of-band socket buffers are released after use. If some
application needs such reserve guarantee from multiple devices, then it
would have to use multiple sockets, which seems an acceptable
requirement.

IOW, if all sockets contribute the amount of guaranteed socket buffers
to the buffer pool of the device they are bound to, and these socket are
not allowed to over-consume their guaranteed amount, then we should be
ok.

A way to achieve zero-copy would involve extending this per-socket,
per-device reserve to the RX side, and make the resulting rings
exportable to userland with proper synchronization. In this case, the
reserved socket buffers forming the TX/RX rings could refer to different
segments of a single piece of kernel memory which the application would
map. Grantedd, this looks all nice and simple in theory, the devil is
obviously in the details in practice, but that should be doable.

This said, I have a modest roadmap for the mini-stack for the time
being, which is supporting AF_PACKET and AF_INET/IPPROTO_UDP in
out-of-band mode end-to-end, from the application to the wire through
the NIC driver, using common kernel/user memory transfers. No bells and
whistles, just the basic reliable stuff my application use case
requires.

-- 
Philippe.

