References: <CAG8a9PyaFXitcmim4801QgY4azT-RWBv8XOHen-_PvzrUQrqyQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai 4 / EVL: Out-of-band access to EtherNet interface
Date: Sat, 30 Apr 2022 09:19:57 +0200
In-reply-to: <CAG8a9PyaFXitcmim4801QgY4azT-RWBv8XOHen-_PvzrUQrqyQ@mail.gmail.com>
Message-ID: <878rrnypzj.fsf@xenomai.org>
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
To: Kevin Hall <hallsoftware@gmail.com>
Cc: xenomai@xenomai.org


Kevin Hall via Xenomai <xenomai@xenomai.org> writes:

> Hi,
>
>
> Is OOB I/O service a candidate for an EtherNet-based fieldbus protocol? I
> read in a comment that it only applies to VLAN-tagged IP protocols, but I
> don't know how old that is or if things have changed. I am able to send and
> receive packets when using send() and recv(), but since these are not
> out-of-band, I am often times seeing large delays in the processing of
> data. That's why I am trying to use oob_read(...) and oob_write(...).
>
>
> Additional Information: I am using Xenomai 5.15 with a Raspberry Pi 4. The
> fieldbus protocol is EtherCAT (0x88a4).
>
>

oob_read/write is independent from the EVL net mini-stack, this is a
generic API for talking to oob-capable drivers. The mini-stack
implements such a driver, which at the moment can (only) send/receive
raw ethernet packets via common ethernet drivers.

To get this done, we need a way to distinguish between regular and oob
traffic, this is where VLAN tagging comes into play. Some VLANs can be
assigned to oob traffic, handled by the mini-stack as such instead of
leaving it to the regular network stack for processing (see
evl_net_ether_accept() in kernel/evl/net/input.c which deals with
ingress traffic).

-- 
Philippe.

