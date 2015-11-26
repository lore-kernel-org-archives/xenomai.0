Date: Thu, 26 Nov 2015 21:53:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151126205329.GA31584@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70D88D@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70D88D@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Broadcast Netwrok traffic (rtnet) as raw ethernet is
 not able to capture on windows PC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Nov 26, 2015 at 11:01:21AM +0000, Umair Ali wrote:
> Hello Xenomai team,

Hi, we received your message three times. One time would have been
enough.

> 
> I am working on sending the raw Ethernet packets through RTnet
> driver (rt_8139t). I am using the the example i.e. raw-ethernet.c
> as my starting point for sending the raw Ethernet packets from
> Rtnet source file.

So, you are not using the advices I gave you in answer to your first
question.

> I have managed to compile the using skin=Posix
> and also able run it with rteth0 interface. The code file is
> attached with this email along with makefile. I have configured
> the rteth0 interface with ip and netmask with promisc mode.
> Morover over i have added the route by using the command
> "./rtroute solicit 10.0.0.11 dev rteth0". I am able to ping also
> as below:

You do not need to add a network route to send raw packets. The
network routes are only used to route IP packets.

> 
> root@cpc:/usr/xenomai/sbin# ./rtping 10.0.0.11
> Real-time PING 10.0.0.11 56(84) bytes of data.
> ioctl: No route to host
> root@cpc:/usr/xenomai/sbin# ./rtroute solicit 10.0.0.11 dev rteth0
> root@cpc:/usr/xenomai/sbin# ./rtping 10.0.0.11
> Real-time PING 10.0.0.11 56(84) bytes of data.
> 64 bytes from 10.0.0.11: icmp_seq=1 time=408.6 us
> 64 bytes from 10.0.0.11: icmp_seq=2 time=370.1 us
> 64 bytes from 10.0.0.11: icmp_seq=3 time=387.2 us
> 64 bytes from 10.0.0.11: icmp_seq=4 time=413.4 us
> ^C
> --- 10.0.0.11 rtping statistics ---
> 4 packets transmitted, 4 received, 0% packet loss
> worst case rtt = 413.4 us"

So, RTnet works on your machine. This is a really high value for an
rtnet ping, though.

> 
> The other PC is non real time windows PC.

That explains the long ping time.

> And I can see the ping traffic on the windows PC. But when i run
> the code after compilation I can not see the traffic on the
> network. The output of the code is

So, obviously, the code is wrong. I am not really interested in
knowing why, so I have implemented a program doing what you are
trying to do, and tested that it works with RTnet. Why your example
fail is left as an exercise for you if you are interested. 

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

#include <pthread.h>
#include <sched.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>

#define check_unix(expr)						\
	({								\
		int _rc = (expr);					\
		if (_rc < 0) {						\
			fprintf(stderr, "%s:%d: %s failed: %d (%m)\n",	\
				__FILE__, __LINE__, #expr, errno);	\
			exit(EXIT_FAILURE);				\
		}							\
		_rc;							\
	})

#define check_pthread(expr)						\
	({								\
		int _rc = (expr);					\
		if (_rc != 0) {						\
			fprintf(stderr, "%s:%d: %s failed: %d (%s)\n",	\
				__FILE__, __LINE__, #expr, _rc, strerror(_rc)); \
			exit(EXIT_FAILURE);				\
		}							\
		_rc;							\
	})

int main(int argc, const char *argv[])
{
	struct sched_param sparm;
	struct sockaddr_ll peer;
	struct ethhdr *header;
	struct ifreq ifr;
	char buffer[2048];
	int sock, err;

	if (argc != 3)
		exit(EXIT_FAILURE);

	sparm.sched_priority = 1;
	check_pthread(pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparm));

	sock = check_unix(socket(PF_PACKET, SOCK_RAW, 0));
	
	check_unix(snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", argv[1]));

	check_unix(ioctl(sock, SIOCGIFHWADDR, &ifr));
	
	header = (struct ethhdr *)buffer;
	memset(&header->h_dest, 0xff, sizeof(header->h_dest));
	memcpy(&header->h_source, ifr.ifr_hwaddr.sa_data, 
		sizeof(header->h_source));
	header->h_proto = htons(ETH_P_802_EX1);
	
	check_unix(snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", argv[1]));

	check_unix(ioctl(sock, SIOCGIFINDEX, &ifr));

	memset(&peer, '\0', sizeof(peer));
	peer.sll_family = AF_PACKET;
	peer.sll_halen = 6;
	peer.sll_ifindex = ifr.ifr_ifindex;

	err = check_unix(
		snprintf(buffer + sizeof(*header), 
			sizeof(buffer) - sizeof(*header), "%s", argv[2]));

	for (;;) {
		struct timespec ts;

		check_unix(
			sendto(sock, buffer, err + sizeof(*header), 0,
				(struct sockaddr *)&peer, sizeof(peer)));

		ts.tv_sec = 1;
		ts.tv_nsec = 0;
		check_unix(nanosleep(&ts, NULL));
	}
}

-- 
					    Gilles.
https://click-hack.org

