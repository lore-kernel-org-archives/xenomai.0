From: Umair Ali <ali.umair@tut.fi>
Date: Wed, 25 Nov 2015 16:47:52 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A70D816@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70D805@mb2010-1.intra.tut.fi>
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70D805@mb2010-1.intra.tut.fi>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTnet traffic problem over the network
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry i forget to write the Subject line in the last email
________________________________

Hello Xenomai team,

I am working on sending the raw Ethernet packets through RTnet driver (rt_8=
139t). I am using the the example i.e. raw-ethernet.c as my starting point =
for sending the raw Ethernet packets from Rtnet source file. I have managed=
 to compile the using skin=3DPosix and also able run it with rteth0 interfa=
ce. The code file is attached with this email along with makefile. I have c=
onfigured the rteth0 interface with ip and netmask with promisc mode. Morov=
er over i have added the route by using the command "./rtroute solicit 10.0=
.0.11 dev rteth0". I am able to ping also as below:

root@cpc:/usr/xenomai/sbin# ./rtping 10.0.0.11
Real-time PING 10.0.0.11 56(84) bytes of data.
ioctl: No route to host
root@cpc:/usr/xenomai/sbin# ./rtroute solicit 10.0.0.11 dev rteth0
root@cpc:/usr/xenomai/sbin# ./rtping 10.0.0.11
Real-time PING 10.0.0.11 56(84) bytes of data.
64 bytes from 10.0.0.11: icmp_seq=3D1 time=3D408.6 us
64 bytes from 10.0.0.11: icmp_seq=3D2 time=3D370.1 us
64 bytes from 10.0.0.11: icmp_seq=3D3 time=3D387.2 us
64 bytes from 10.0.0.11: icmp_seq=3D4 time=3D413.4 us
^C
--- 10.0.0.11 rtping statistics ---
4 packets transmitted, 4 received, 0% packet loss
worst case rtt =3D 413.4 us"

The other PC is non real time windows PC. And I can see the ping traffic on=
 the windows PC. But when i run the code after compilation I can not see th=
e traffic on the network. The output of the code is

root@cpc:/usr/xenomai# ./raw_packet rteth0 aliumair
sock: 3
string copy: rteth0
ioctl:  0
addr.sll_family: 17
addr.sll_protocol: 13330
addr.sll_ifindex: 1
Sent frame of 1514 bytes
Sent frame of 1514 bytes

My first question is what i am doing wrong due to which i am able to see th=
e traffic on the network even though i can see the ping traffic.

Now my second problem is when i am running the code after the compilation a=
nd look a the threads with output such as

root@cpc:/home/cpc# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0      0          idle       core       -1           -                   =
  R          [ROOT/0]
  1      0          idle       core       -1           -                   =
  R          [ROOT/1]
  0      405        rt         core       98           -                   =
 W          [rtnet-stack]
  0      406        rt         core        0           -                   =
  W          [rtnet-rtpc]
  1      2282       rt         core        0           -                   =
 W          [rtnetproxy]
  0      2737       rt         cobalt    100   140ms47us       D          r=
aw_packet
root@cpc:/home/cpc# cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0      0        idle       core           -1           -                 =
R          [ROOT/0]
  1      0        idle       core           -1           -                 =
R          [ROOT/1]
  0      405    rt         core           98            -                 W=
          [rtnet-stack]
  0      406    rt         core            0            -                 W=
          [rtnet-rtpc]
  1      2282  rt         core            0            -                 W =
         [rtnetproxy]
  0      2737  rt         cobalt        100   924ms122us    D          raw_=
packet

I have found that the time out for the raw_packet thread is varying. I thin=
k if the the thread is running in real time it should be constant and deter=
ministic. So Please guide me if i am missing anything.

Details of my setup are
root@cpc:/home/cpc# dmesg | grep xenomai
[    0.000000] Linux version 3.14.39-xenomai-3.0.1 (root@cpc) (gcc version =
4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #2 SMP PREEMPT Tue Nov 10 18:02:47 EE=
T 2015
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.14.39-xeno=
mai-3.0.1 root=3DUUID=3De29fa266-6a54-4815-b5bd-ea0168f18fd7 ro quiet splas=
h crashkernel=3D384M-:128M vt.handoff=3D7
[    0.836257]           (see xenomai.smi parameter). You might encounter
[    1.640220] usb usb1: Manufacturer: Linux 3.14.39-xenomai-3.0.1 ehci_hcd
[    1.641529] usb usb2: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.642402] usb usb3: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.643256] usb usb4: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.644153] usb usb5: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd

And i have run all the modules in order to make the rteth0 to be up as expl=
ained in the link
https://sir.upc.edu/wikis/roblab/index.php/Development/RTnet

Thanks in advance

Best regards
Ali





-------------- next part --------------
A non-text attachment was scrubbed...
Name: raw_packet.c
Type: text/x-csrc
Size: 3667 bytes
Desc: raw_packet.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151125/7a0cf0a9/at=
tachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: makefile
Type: application/octet-stream
Size: 2319 bytes
Desc: makefile
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151125/7a0cf0a9/at=
tachment.obj>
