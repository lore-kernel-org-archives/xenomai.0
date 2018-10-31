From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
Date: Wed, 31 Oct 2018 15:08:05 +0100
Message-ID: <7041379.eS1cmEbPlD@lenni>
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BBF2@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <2247681.JhopzYo4NN@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BBF2@DDCEXCH.ddc-ny.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hillman,
 Robert" <hillman@ddc-web.com>

Pham, Phong wrote:
> This is what I see when my RTnet box, my laptop, and my FTP server
> (local on laptop) is on the same subnet 192.168.7.0:
> 
> 192.168.7.79 is my RTnet box.

Which processor architecture is it?

> I used my laptop (192.168.7.106) to
> ping the RTnet box which is what you see with ICMP protocol.  The
> first TCP packet sent by my RTnet box (packet # 11) has the SYN bit
> not set.  (see attached image.  I pulled in your patch along with the
> patch named "rtdm: add integer file descriptor to struct rtdm_fd" to
> get TCP to compile.

So you don't use latest next? Do you use stable? Did you made changes to 
the source code we are not aware of?

> Any advice you may have?  Do you know which
> relevant routine goes and set the TCP SYN bit that I can start
> looking?

It is set in rt_tcp_connect() line 1536:

ret = rt_tcp_send(ts, TCP_FLAG_SYN);

in kernel/drivers/net/stack/ipv4/tcp/tcp.c

-- 
Sebastian




