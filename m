MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Sat, 12 Aug 2017 15:26:07 +0100
Message-ID: <CAKJ14NeJMtuA04rqvVBALYGEVg0iuuA6Hksw3RPBGQKXAT_0VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, paul.w@mrmoco.com

>
>   Thank you Andreas and Christophe for helping resolve the rtroute issue.

No problem. Just a remark: I believe this mailing list doesn't like
top-posting...

>
> The messed up routing table was likely as a result of my various attempts
> to get it working.
>
> Unfortunately, now that I've hopefully corrected the RTnet routing table,
> rtping hangs after printing, "Real-time PING 10.0.0.2 56(84) bytes of
> data".
>
> Perhaps related, the receiver side (@10.0.0.2) of a trivial UDP
> client/server
> utility does not receive the UDP packets the server side is sending (both
> when
> sent locally to receiver (compiled and linked against cobalt), and when
> sent
> from 10.0.0.5 - these I can see being sent using wireshark).
>
> I've only configured the rteth0 interface, not rtlo.
>
> # ./rtroute
> Host Routing Table
> Hash?? ?Destination?? ?HW Address?? ??? ?Device
> 02?? ?10.0.0.2 ??? ?5C:F9:DD:74:9C:27?? ?rteth0 - local
> Xenomai/RTnet NIC
> 05?? ?10.0.0.5 ??? ?D4:BE:D9:1F:88:C2?? ?rteth0 - remote Linux
> 07?? ?192.168.1.71 ?? ?98:DE:D0:03:80:CA?? ?rteth0 - local 2nd NIC
> 3F?? ?10.255.255.255?? ?FF:FF:FF:FF:FF:FF?? ?rteth0
>
> # ./rtping 10.0.0.2/ - never returns/
> Real-time PING 10.0.0.2 56(84) bytes of data.
> ^C
> --- 10.0.0.2 rtping statistics ---
> 3 packets transmitted, 0 received, 100% packet loss
> worst case rtt = 0.0 us
>
> # ./rtping 10.0.0.5/ - and 10.0.0.5 can ping successfully Xenomai/RTnet/
> Real-time PING 10.0.0.5 56(84) bytes of data.
> 64 bytes from 10.0.0.5: icmp_seq=1 time=494.3 us
> 64 bytes from 10.0.0.5: icmp_seq=2 time=442.9 us
> 64 bytes from 10.0.0.5: icmp_seq=3 time=600.4 us
> ^C
> --- 10.0.0.5 rtping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss
> worst case rtt = 600.4 us

It's good that rtping to 10.0.0.5 works. So your kernel modules should be OK.

W/r to the other questions: I'm still unclear about your network
topology. As far as I understand: - rteth0 on one peer is configured
as 10.0.0.1
- there are 3 other peers in the network, 10.0.0.2, 10.0.0.5, and 192.168.1.71
- all the peers are connected together via a layer2 switch

rtping hanging and not complaining about a missing route is typically
the case if the ICMP packets from rtping cannot reach the adjacent
peer, which is generally related to a network configuration issue.

Another way to debug things is to load rtcap.ko before bringing up
rteth0. Then you bring up rteth0 with rtifconfig, followed by bringing
up rteth0 with ifconfig (on the Linux side). After that you can trace
the traffic going through rteth0 using tcpdump (e.g. see [1] how to
combine tcpdump and wireshark).

I would start investigating UDP after verifying that rtping works. In
my case I could get UDP working by compiling [2] using the gcc and ld
flags provided by xeno-config (note that there is an bug in this
example: the buffer needs to be 0 termintated between recvfrom() and
sendto()). I started this UDP server on Xenomai, whereas on the peer
running Linux I used a script [3] to send/receive UDP frames.


A.

[1] https://linuxexplore.com/2012/06/07/use-tcpdump-to-capture-in-a-pcap-file-wireshark-dump/
[2] http://www.binarytides.com/programming-udp-sockets-c-linux/
[3]

# StartScript
#!/bin/sh

idx=0;
while true;
do
        echo hahu${idx} | socat - UDP:192.168.3.3:8888;
        idx=$((idx+1));
done

exit 0
# EndScript

