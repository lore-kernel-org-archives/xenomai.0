References: <a8e9d962-5de6-6616-327e-d2d709348466@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f6913f09-11c2-bf26-fb77-f39533786ba8@siemens.com>
Date: Wed, 28 Feb 2018 20:36:06 +0100
MIME-Version: 1.0
In-Reply-To: <a8e9d962-5de6-6616-327e-d2d709348466@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Please review wip/rtnet-fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2018-02-28 19:24, Philippe Gerum wrote:
> 
> Gentlemen, we have 30 patches waiting for review by RTnet gurus in
> wip/rtnet-fixes. We already had some positive feedback about them fixing
> the ugly SMAP-related issue, which we may want to merge to stable-3.0.x
> asap, but there are a couple of unrelated changes to review as well, namely:
> 
> 9a6bbc384 net/socket: forward private ioctl requests to NIC driver

Seems harmless, but do we have a user for that? I'm also skeptical if
SIOCPROTOPRIVATE should actually target a device driver. Seems more like
it's used at higher levels.

> b78817868 net/socket: align rtdev do_ioctl handler on the regular
> ndo_do_ioctl

Mostly fine, except for some unrelated whitespace breakage in
kernel/drivers/net/stack/socket.c.

> 40b9bdc44 net/socket: enforce secondary mode for SIOCETHTOOL

Looks good, just also indent the "break" of the SIOCETHTOOL block with tabs.

> 
> I don't see anything controversial in those patches, but I'd rather ask
> before merging.
> 
> 3.0.7 is currently on hold until we have wip/rtnet-fixes merged in whole
> or in part (at least the SMAP stuff), so we direly need to make some
> progress here.

I didn't look into all details, rather relying on test results as well.
Some minor findings:

There is a ping-pong debug change in "net/tcp: recvmsg: remove direct
references to user memory" vs. "net/tcp: sendmsg: remove direct
references to user memory". Please remove.

"net/udp: ioctl: fix temp arg buffer type" should get folded into the
commit that caused the regression ("net/udp: ioctl: remove direct
references to user memory").

Jan

