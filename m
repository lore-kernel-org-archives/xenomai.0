From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
Date: Tue, 30 Oct 2018 21:16:47 +0100
Message-ID: <2247681.JhopzYo4NN@lenni>
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44EE54593B5@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <6420434.4R09zZnBme@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE54593B5@DDCEXCH.ddc-ny.com>
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

Hi,

on 10/19/18 04:00 AM, Pham, Phong wrote:
> I do see a TCP packet sent out on the LAN when rt_dev_connect() is
> invoked; however, the packet itself is not valid.  The SYN flag in
> the TCP protocol is not set when the first TCP packet was sent.

Strange. Wireshark shows me that a connection initiated by a RTnet box 
can be successfully established and that the SYN flag indeed is set.

-- 
Sebastian




