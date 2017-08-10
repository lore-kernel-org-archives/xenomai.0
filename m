MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Thu, 10 Aug 2017 14:36:27 +0100
Message-ID: <CAKJ14Ndf43hdOcFSVP_S-ZLji=smtpj7bih=s8618Yfsh5OG7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ? (Paul Wilkinson)
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
> # ./rtping 10.0.0.1
> Real-time PING 10.0.0.1 56(84) bytes of data.
> ioctl: No route to host

You should populate your RTnet routing table with some meaningful
combinations of IP address and MAC address after bringing it up.

The other non-persistent option is to ping your RTnet device from a
non-RTnet device, which auto populates the RTnet routing table with
the IP & mac pair of the sender. After that you can rtping the other
device as well.

>
> However, if I use 'rtnet start', rtping succeeds :-
>
> # ./rtping 10.0.0.1
> Real-time PING 10.0.0.1 56(84) bytes of data.
> 64 bytes from 127.0.0.1: icmp_seq=1 time=4.8 us
> 64 bytes from 127.0.0.1: icmp_seq=2 time=4.4 us
> 64 bytes from 127.0.0.1: icmp_seq=3 time=3.4 us
> 64 bytes from 127.0.0.1: icmp_seq=4 time=3.7 us
> 64 bytes from 127.0.0.1: icmp_seq=5 time=4.2 us

Somehow your rtnet start script does not populate the routing table
properly. Hence if you ping 10.0.0.1, you actually get a reply from
localhost (127.0.0.1).

>
> # ./rtroute
> Host Routing Table
> Hash?? ?Destination?? ?HW Address?? ??? ?Device
> 00?? ?0.0.0.0 ??? ?00:00:00:00:00:00?? ?rtlo
> 01?? ?127.0.0.1 ??? ?00:00:00:00:00:00?? ?rtlo
> 02?? ?10.0.0.2 ??? ?00:00:00:00:00:00?? ?rtlo
> 3F?? ?10.255.255.255?? ?FF:FF:FF:FF:FF:FF?? ?rteth0
>

See:
rtroute --help

E.g (assuming that 02:00:00:00:01:02 is the MAC of 10.0.0.1):

rtroute add 10.0.0.1 02:00:00:00:01:02 dev rteth0

... after that rtping should work.

