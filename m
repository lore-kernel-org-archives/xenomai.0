From: Laurent LEQUIEVRE <laurent.lequievre@gmail.com>
Message-ID: <5763C908.6010007@gmail.com>
Date: Fri, 17 Jun 2016 11:55:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] need help to Xenomai Cobalt RTnet socket UDP recvfrom non
	blocking
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, laurent.lequievre@gmail.com

Hello,

I installed xenomai 3.0.2 and try to test some RTnet features needed for 
the communication with my Kuka robot arm.

I specify that I want to work with the skin posix only.

I need to create a UDP socket with a timeout on the 'recvfrom' function 
(Non blocking recvfrom).

I tested this first code :

int udp_socket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
bind(udp_socket, ...)
struct timeval timeout;
timeout.tv_sec = 1;
timeout.tv_usec = 0;

setsockopt(udp_socket, SOL_SOCKET, SOCKET_SO_RCVTIMEO, &timeout, 
sizeof(timeout));
--> this function return -1, errno=92, Protocol not available ???
....
recvfrom(udp_socket, ....) --> blocked ??

I tested this second code :

int udp_socket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
bind(udp_socket, ...)
fcntl(udp_socket, F_SETFL, O_NONBLOCK);
--> this function return 0
....
recvfrom(udp_socket, ....) --> blocked ??

Can you give me a sample ?

Thanks for your help,

Regards,

Laurent LEQUIEVRE






