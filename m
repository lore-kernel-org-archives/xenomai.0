Message-ID: <54103074.30409@xenomai.org>
Date: Wed, 10 Sep 2014 13:05:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1410329668469.74031@jhu.edu>
In-Reply-To: <1410329668469.74031@jhu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RTnet] Multiple frame received by socket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Long Qian <lqian8@jhu.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Zihan Chen <zihan.chen@jhu.edu>

On 09/10/2014 08:14 AM, Long Qian wrote:
> Hi all,
> 
> I was doing some timing test between RTnet and non-RT ethernet module. I tried nomac and rtmac without TDMA. The problem I come with is same for the two configurations.
> A socket program on RTnet keeps sending and receiving Ethernet frame, the non-RT side is just an echo program. When the program continuously sends out frames from RTnet without any interval, the socket will receive same echo frame for 3 times. But when an interval of some millisecond is inserted, one echo frame will be received, which is what I expected.
> rtnet, rt_e1000e, rtmac, nomac, rtipv4, rtcap, rtudp, rtpacket modules are inserted when the program is running.
> My RTnet version is 0.9.13 and Xenomai version is 2.6.38.?

There is no xenomai version 2.6.38.
http://xenomai.org/asking-for-help/


-- 
                                                                Gilles.

