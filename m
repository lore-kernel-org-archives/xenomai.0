Date: Mon, 14 Aug 2017 16:27:50 +0000
Message-ID: <20170814162750.Horde.nKbmM6trcaglkk_2ESDbuZa@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
In-Reply-To: <CAKJ14NeJMtuA04rqvVBALYGEVg0iuuA6Hksw3RPBGQKXAT_0VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Description: Plaintext Message
Subject: Re: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> No problem. Just a remark: I believe this mailing list doesn't like
> top-posting...

Oops, thanks for reminding me, I did read that initially.

Thanks once again for your patient and extremely helpful replies to my
questions.

>
> W/r to the other questions: I'm still unclear about your network
> topology.

My network topology comprises :-

- Linux + Xenomai/RTnet + 2 NICS - rteth0 10.0.0.2 & eth1 192.168.1.71
- Stock Linux - eno1 10.0.0.5

The 10.0.0.X interfaces are connected via layer 2 switch, these are the
only devices on the switch.

> Another way to debug things is to load rtcap.ko before bringing up
> rteth0. Then you bring up rteth0 with rtifconfig, followed by bringing
> up rteth0 with ifconfig (on the Linux side).

Thank you, this was very useful.

 From terminal window on Xenomai system, rtping 10.0.0.2, the rteth0
interface, the packets are
captured by wireshark, however, there is no reply.

I can successfully ping Xenomai RTnet system from stock Linux system
(10.0.0.5) and, once rtroute
is established, rtping from Xenomai to stock Linux system (10.0.0.5).

Your link to UDP client/server and socat script were also very useful,
knowing it had worked for you,
I gave them a try ..... and they worked between 10.0.0.2 and 10.0.0.5, but
not when using 10.0.0.2
for both client and server.

Again, wireshark captures the packet, but the UDP server doesn't receive
it.

The only reason I wanted to rtping 10.0.0.2 from 10.0.0.2 was as a sanity
check prior to moving on to
testing with a remote system, the same for running the client and server
both on 10.0.0.2, I figured
this would give me confidence prior to moving to running between 10.0.0.2
and 10.0.0.5

# ./rtroute
Host Routing Table
Hash        Destination        HW Address               
Device
02        10.0.0.2          5C:F9:DD:74:9C:27        rteth0
05        10.0.0.5          D4:BE:D9:1F:88:C2        rteth0
3F        10.0.0.255        FF:FF:FF:FF:FF:FF        rteth0

# ./rtifconfig
rteth0    Medium: Ethernet  Hardware address: 5C:F9:DD:74:9C:27
          IP address: 10.0.0.2  Broadcast address: 10.0.0.255
          UP BROADCAST RUNNING PROMISC  MTU: 1500

rtlo      Medium: Local Loopback
          UP LOOPBACK RUNNING  MTU: 1500
