From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a8e9d962-5de6-6616-327e-d2d709348466@xenomai.org>
Date: Wed, 28 Feb 2018 19:24:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Please review wip/rtnet-fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


Gentlemen, we have 30 patches waiting for review by RTnet gurus in
wip/rtnet-fixes. We already had some positive feedback about them fixing
the ugly SMAP-related issue, which we may want to merge to stable-3.0.x
asap, but there are a couple of unrelated changes to review as well, namely:

9a6bbc384 net/socket: forward private ioctl requests to NIC driver
b78817868 net/socket: align rtdev do_ioctl handler on the regular
ndo_do_ioctl
40b9bdc44 net/socket: enforce secondary mode for SIOCETHTOOL

I don't see anything controversial in those patches, but I'd rather ask
before merging.

3.0.7 is currently on hold until we have wip/rtnet-fixes merged in whole
or in part (at least the SMAP stuff), so we direly need to make some
progress here.

Thanks,

-- 
Philippe.

