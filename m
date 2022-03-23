Date: Wed, 23 Mar 2022 14:07:47 +0100 (CET)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: RTNET setup issue
In-Reply-To: <d01-623aff00-2f-400dfa00@254399035>
Message-ID: <freemail.20220323140747.6187.1@fmxmldata10.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

=20
"Fran=C3=A7ois Legal" <devel@thom.fr.eu.org> =C3=ADrta:
>Le Mercredi, Mars 23, 2022 10:48 CET, Paal Tamas via Xenomai <xenomai@xeno=
mai.org> a =C3=A9crit:
>
>> Dear All,   I am trying to set up RTNET using the latest xenomai_3.2.1 o=
n an x86_64 system. I need only the raw packet (e.g rtpacket layer). I trie=
d a lot of things but I still got errors like:  ioctl: Inappropriate ioctl =
for device    I try to use this PCI device:
>> 01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Con=
nection (rev 01)
>>     Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
>>     Kernel driver in use: rt_igb
>>     Kernel modules: igb, rt_igb   What I do is: ifconfig enp1s0f0 down
>> ifconfig enp1s0f1 down
>> rmmod igbmodprobe rtnet
>> modprobe rtpacket
>> modprobe rt_igb
>> modprobe rtipv4
>> modprobe rtudp  set up the rtnet.conf file and start rtnet: /usr/xenomai=
/sbin$ sudo ./rtnet start
>> ioctl: Inappropriate ioctl for device
>> ioctl: Inappropriate ioctl for device
>> ioctl: Inappropriate ioctl for device
>> Stage 1: searching for master...ioctl: Inappropriate ioctl for deviceSta=
ge 2: waiting for other slaves...
>> Stage 3: waiting for common setup completion...ioctl: Inappropriate ioct=
l for deviceclickandmove@clickandmove-desktop:/usr/xenomai/sbin$ sudo /usr/=
xenomai/sbin/rtifconfig -a
>> ioctl: Inappropriate ioctl for device   The kernel log:  [   50.360253] =
igb 0000:01:00.1: removed PHC on enp1s0f1
>> [   50.553797] igb 0000:01:00.0: removed PHC on enp1s0f0
>> [   81.769798] RTnet: registered rteth0
>> [   81.769802] rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Co=
nnection
>> [   81.769804] rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 6c:b=
3:11:56:2e:32
>> [   81.769807] rt_igb 0000:01:00.0: rteth0: PBA No: Unknown
>> [   81.769808] rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s=
), 1 tx queue(s)
>> [   81.777139] rt_loopback: initializing loopback interface...
>> [   81.777315] RTnet: registered rtlo
>> [   81.787311] RTcfg: init real-time configuration distribution protocol
>> [   81.793326] RTmac: init realtime media access control
>> [   81.800424] RTmac/TDMA: init time division multiple access control me=
chanism   Even rtifconfig returns the same error  /usr/xenomai/sbin/rtifcon=
fig -aioctl: Inappropriate ioctl for device   What am I doing wrong? Thank =
you,Tamas
>>
>
> Hello,
>
>what makes you think it does not work ? Using the rtnet script, you&#39;re=
 trying to configure rtmac & rtcfg which you stated are not necessary for y=
our setup.
>
>Have you tried only rtifconfig rteth* up and checked the Tx/Rx counters di=
splayed there ?
>
>Fran=C3=A7ois

>Hello,  The "rtifconfig rteth0 up" command returns the  "ioctl: Inappropri=
ate ioctl for device" error too. That&#39;s why I think something is wrong.=
 Thank you,Tamas
