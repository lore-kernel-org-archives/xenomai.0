Date: Fri, 1 Oct 2021 10:03:23 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
Subject: RTNET i.mx6 raw packets
Message-ID: <freemail.20211001100323.12881.1@fmxmldata07.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear All, I would like to use RTNET with raw packets on the fec interface of my i.mx6 CPU. The purpose of the whole thing is to use the Soem ECAT master.
I am lost. I need your help. Xenomai_3.1, kernel 4.14.78.I am using this rtnet fec patch:
https://xenomai.org/pipermail/xenomai/2019-March/040580.html The fec interface is eth0.
I am initializing RTnet the following way: ifconfig eth0 down
modprobe rtnet_fec
modprobe rtpacket
echo 2188000.ethernet >  /sys/bus/platform/drivers/fec/unbind
echo 2188000.ethernet >  /sys/bus/platform/drivers/rtnet_fec/bind
/usr/xenomai/sbin/rtifconfig rteth0 up
   >RTnet: registered rteth0
   >rtnet_fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
   >pps pps0: new PPS source ptp0
   >libphy: fec_enet_mii_bus: probed
   >rtnet_fec 2188000.ethernet rteth0: RTnet mode enabled
   >rtnet_fec 2188000.ethernet rteth0: registered PHC device 0
   >Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:07: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:07, irq=POLL)
/usr/xenomai/sbin/rtifconfig
   >rteth0    Medium: Ethernet  Hardware address: F8:DC:7A:1B:88:F1
   >          UP BROADCAST  MTU: 1500
   >          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
   >          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
   >          collisions:0
   >          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b) If I load the ipv4 module and add the routing info: modprobe rtipv4
/usr/xenomai/sbin/rtifconfig rteth0 down
/usr/xenomai/sbin/rtifconfig rteth0 up 192.168.100.50
   >rtnet_fec 2188000.ethernet rteth0: carrier lost
   >rtnet_fec 2188000.ethernet rteth0: Link is Up - 100Mbps/Full - flow control rx/tx
   >rtnet_fec 2188000.ethernet rteth0: carrier detected
/usr/xenomai/sbin/rtifconfig
   >rteth0    Medium: Ethernet  Hardware address: F8:DC:7A:1B:88:F1
   >          IP address: 192.168.100.50  Broadcast address: 192.168.100.255
   >          UP BROADCAST RUNNING  MTU: 1500
   >          RX packets:65 errors:0 dropped:0 overruns:0 frame:0
   >          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
   >          collisions:0
   >          RX bytes:7605 (7.4 Kb)  TX bytes:686 (686.0 b)
/usr/xenomai/sbin/rtroute add 192.168.100.100 00:13:3b:93:07:20 dev rteth0
/usr/xenomai/sbin/rtping 192.168.100.100
   >Real-time PING 192.168.100.100 56(84) bytes of data.
   >64 bytes from 192.168.100.100: icmp_seq=1 time=499.7 us
   >64 bytes from 192.168.100.100: icmp_seq=2 time=424.0 us
   >64 bytes from 192.168.100.100: icmp_seq=3 time=531.0 us
   >64 bytes from 192.168.100.100: icmp_seq=4 time=750.3 us
   >^C
   >--- 192.168.100.100 rtping statistics ---
   >4 packets transmitted, 4 received, 0% packet loss
   >worst case rtt = 750.3 us
   
As you can see ping works. Now comes the difficulties.
I try to send raw packet this was (pseudo code coming): #define ETH_P_ECAT 0x88A4
const unsigned char txframe[]={0xff,0xff,0xff,0xff,0xff,0xff,0x1,0x1,0x1,0x1,0x1,0x1,0x88,0xa4,0xe,0x10,0x7,0x1,0x0,0x0,0x0,0x0,0x2,0x0,0x0,0x0,0x0,0x0,0x0,0x0};
int sock = rt_dev_socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ECAT));    
struct ifreq ifr;
strcpy(ifr.ifr_name, "rteth0");
rt_dev_ioctl(sock, SIOCGIFINDEX, &ifr);
struct sockaddr_ll sll;
sll.sll_family = AF_PACKET;
sll.sll_ifindex = ifr.ifr_ifindex;
sll.sll_protocol = htons(ETH_P_ECAT);
rt_dev_bind(sock, (struct sockaddr *)&sll, sizeof(sll));
unsigned char buf[4096];
memset(&buf,0,4096);
for(i=0;i<30;i++)buf[i]=txframe[i];
rt_dev_send(sock, buf, 64, 0);
rt_dev_close(sock); Almost every function call returns positive value (sock is 3, ifindex is 1) only rt_dev_send() failes. It returns EFAULT (-14) that means "Bad Address". Memory fault? I do not see why!
I am testing it since a few days. I tried several things (allocate buffer differently, use different MAC addresses, data size in the data and so on), but nothing worked. I get the same error all the time.
I have already enabled CONFIG_XENO_DRIVERS_RTNET_CHECKED for kernel configuration, but I do not see any error appearing. Note:
If I compile and run the same code with the socket(),ioctl(),bind(),send(),close() function on my other ethernet interface "eth1" (that is a USB to ethernet adapter and has no RTNET support) it works
fine till RTnet is not initialized. If I initialize RTNET the way I desribed above the ioctl() (to read the interface index) and send() functions return EPERM (-1) error (Operation not permitted). (I am working as root.) This is very strange too.
I would assume that RTNET has no effect on the "standard" networking interface.
What am I doing wrong? I checked the mailing list for more than a year back, but I found no answer.
Any help is appreciated.
Thank you in advance,
Tamas 
