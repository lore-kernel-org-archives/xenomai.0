From: Long Qian <lqian8@jhu.edu>
Date: Wed, 10 Sep 2014 06:14:28 +0000
Message-ID: <1410329668469.74031@jhu.edu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [RTnet] Multiple frame received by socket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Zihan Chen <zihan.chen@jhu.edu>

Hi all,

I was doing some timing test between RTnet and non-RT ethernet module. I tr=
ied nomac and rtmac without TDMA. The problem I come with is same for the t=
wo configurations.
A socket program on RTnet keeps sending and receiving Ethernet frame, the n=
on-RT side is just an echo program. When the program continuously sends out=
 frames from RTnet without any interval, the socket will receive same echo =
frame for 3 times. But when an interval of some millisecond is inserted, on=
e echo frame will be received, which is what I expected.
rtnet, rt_e1000e, rtmac, nomac, rtipv4, rtcap, rtudp, rtpacket modules are =
inserted when the program is running.
My RTnet version is 0.9.13 and Xenomai version is 2.6.38.?
Does anyone has any idea about this?

Thanks!
Qian?

?
