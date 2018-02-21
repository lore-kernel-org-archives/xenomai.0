MIME-Version: 1.0
In-Reply-To: <CAOuPNLg3Dh2xJiqou0XhXJxQrckmxoVUXDyhye+dYjX3JdFLog@mail.gmail.com>
References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
 <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
 <CALLqZ8SQp0b6rXxecDaJRqmsCcegUyjzsWjiX28COUrwHY0f1g@mail.gmail.com>
 <CAOuPNLha-XLmhdnp3vcUktrgXOmehMOZNxF72scaiv37xV7-5g@mail.gmail.com>
 <CALLqZ8Tvs8k_356Vcy=FCFBjzu6u3_FfbGEtf_thPKeh_qVMGQ@mail.gmail.com>
 <CAOuPNLhR_na2Kk2U=poywxjAZegR2ahjjQL5HnujEqdq3Z1=kA@mail.gmail.com>
 <486ddc38-4890-0515-0f17-de8d31bbe9fa@web.de>
 <CAOuPNLhqbD=8agrNMPDWFaXKm2RniD_G6FLyNUtC4K9mhPhHRA@mail.gmail.com>
 <198d3b6e-f486-51c1-ef0d-c82461e24a4f@web.de>
 <CAOuPNLhvY_-_ZDxBXJ2GBdiEB1FtKm6i1jDRK4hhsAEx5kLLLA@mail.gmail.com>
 <CAOuPNLi_1NpGz_uNar2xTPTa-g3OC0cj_G4YUgJb6N5rsV4o_g@mail.gmail.com>
 <CAOuPNLiQCtfd_h3tQpKFyg2=z1zZgwJaQw=tf9TmXBEJ6V5VUQ@mail.gmail.com>
 <c7cd7331-f757-f5ae-c9c9-b593de6ddc89@web.de>
 <CAOuPNLj_finB-eL4WE8_LdYf4mujW8KJsJaLgVev5KfL4P5pgQ@mail.gmail.com>
 <023001d3ab02$b4be6fe0$1e3b4fa0$@mrmoco.com>
 <CAOuPNLg3Dh2xJiqou0XhXJxQrckmxoVUXDyhye+dYjX3JdFLog@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 21 Feb 2018 19:34:26 +0530
Message-ID: <CAOuPNLhZLdzwfThVcZrSK4+e9vqzNqe83Hx78VwSQABGMVoccQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [rtnet] - help required with rtnet interface bring up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Wilkinson <paul.w@mrmoco.com>, Jan Kiszka <jan.kiszka@web.de>, Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Feb 21, 2018 at 6:02 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> On Wed, Feb 21, 2018 at 4:27 PM, Paul Wilkinson <paul.w@mrmoco.com> wrote:
>>
>>
>> -----Original Message-----
>> From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Pintu Kumar
>> Sent: 20 February 2018 16:58
>> To: Jan Kiszka <jan.kiszka@web.de>; Pintu Kumar <pintu.ping@gmail.com>
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] [rtnet] - help required with rtnet interface bring up
>>
>> On Tue, Feb 20, 2018 at 6:27 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>> On 2018-02-20 07:43, Pintu Kumar wrote:
>>>> Dear Jan,
>>>>
>>>> I had two network adapter setup in my virtual box:
>>>> NAT0: NAT network
>>>> NAT1: Host-only adapter
>>>>
>>>> Now I removed NAT1, and changed NAT0 to Host only type So, now I just
>>>> have only one ethernet interface (eth0).
>>>>
>>>> After this if I install RTnet, rteth0 is up, but still it does not
>>>> connect to the host PC.
>>>> (I cannot ping the IP address from host).
>>>>
>>>> Note: The ip address is visible only in vnic0 and not in rteth0.
>>>>
>>>> And I still get the kernel errors flooded:
>>>> [58710.438552] RTcfg: error -11 while sending stage 1 frame
>>>> [58710.438585] RTcfg: error -11 while sending stage 1 frame
>>>> [58710.438602] RTcfg: error -11 while sending stage 1 frame .....
>>>>
>>>> Please let me know if I am missing something.
>>>>
>>>> Here is the output from ifconfig:
>>>>
>>>> pintu@osboxes:~$ ifconfig
>>>> lo        Link encap:Local Loopback
>>>>           inet addr:127.0.0.1  Mask:255.0.0.0
>>>>           inet6 addr: ::1/128 Scope:Host
>>>>           UP LOOPBACK RUNNING  MTU:65536  Metric:1
>>>>           RX packets:42 errors:0 dropped:0 overruns:0 frame:0
>>>>           TX packets:42 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1
>>>>           RX bytes:4594 (4.5 KB)  TX bytes:4594 (4.5 KB)
>>>>
>>>> rteth0    Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>>>           RX packets:92071 errors:0 dropped:92052 overruns:0 frame:0
>>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:2584501 (2.5 MB)  TX bytes:0 (0.0 B)
>>>>
>>>> rteth0-mac Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>>>           RX packets:92071 errors:0 dropped:57 overruns:0 frame:0
>>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:2584501 (2.5 MB)  TX bytes:0 (0.0 B)
>>>>
>>>> rtlo      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
>>>>           inet6 addr: fe80::200:ff:fe00:0/64 Scope:Link
>>>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>>>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>>>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:504 (504.0 B)  TX bytes:0 (0.0 B)
>>>>
>>>> vnic0     Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>>>           inet addr:192.168.56.102  Bcast:192.168.56.255  Mask:255.255.255.0
>>>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>>>           UP BROADCAST RUNNING  MTU:1496  Metric:1
>>>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>           TX packets:57 errors:0 dropped:0 overruns:0 carrier:0
>>>>           collisions:0 txqueuelen:1000
>>>>           RX bytes:0 (0.0 B)  TX bytes:7598 (7.5 KB)
>>>>
>>>> pintu@osboxes:~$ sudo /usr/xenomai/sbin/rtifconfig [sudo] password
>>>> for pintu:
>>>> rteth0    Medium: Ethernet  Hardware address: 08:00:27:52:BA:F1
>>>>           IP address: 192.168.56.102  Broadcast address: 192.168.56.255
>>>>           UP BROADCAST RUNNING  MTU: 1500
>>>>
>>>> rtlo      Medium: Local Loopback
>>>>           IP address: 127.0.0.1
>>>>           UP LOOPBACK RUNNING  MTU: 1500
>>>>
>>>> pintu@osboxes:~$ sudo /usr/xenomai/sbin/rtroute Host Routing Table
>>>> Hash Destination HW Address Device
>>>> 00 0.0.0.0  00:00:00:00:00:00 rtlo
>>>> 01 192.168.56.1  0A:00:27:00:00:12 rteth0
>>>> 01 127.0.0.1  00:00:00:00:00:00 rtlo
>>>> 26 192.168.56.102 00:00:00:00:00:00 rtlo 3F 192.168.56.255
>>>> FF:FF:FF:FF:FF:FF rteth0
>>>>
>>>
>>> Key question, once again: Do you want RTmac/TDMA and medium access
>>> control mechanism? If yes, do you have a full RTnet stack running on
>>> BOTH ends already?
>>>
>>> If no, don't use the rtnet start script. Only configure what you
>>> actually need. You can follow init_rtnet() from that script for these steps.
>>>
>>
>> OK. Thank you so much for all your help, and sorry for troubling you so much.
>>
>> I think I have also tried manually. But still I am not able to ping from host.
>>
>> I followed the below steps.
>>
>> 1) rtnet stop = > since the rtnet driver was already loaded from boot.
>> 2) modprobe -r e1000 (remove non-rt driver)
>> 3) modprobe rtnet
>> 4) modprobe rt_e1000
>> 5) rtifconfig rtlo up 127.0.0.1
>> 6) rtifconfig rteth0 up 192.168.56.101
>>
>> After this only vnic0 is visible in ifconfig (with IP address).
>> After that I also did:
>>
>> 7) ifconfig rtlo up
>> 8) ifconfig rteth0 up
>>
>> Now, rtlo and rteth0 is visible, but I could not ping the IP from outside.
>> Also, if I ping 192.168.56.101 locally also, it still returns 127.0.0.1
>>
>> So, I tried changing the route, but no success.
>>
>> If any steps is missed out please let me know.
>>
>> Tomorrow, I will also cross check with init_inet() and update.
>>
>>
>> Thanks,
>> Pintu
>>
>>> Jan
>>>
>>
>> It's been a while since I setup or used rtnet, but I recall needing to run the  rtroute command before being able to ping to and from.
>>
>> Eg 'rtroute add 192.168.56.101 Mac-Address-Of-rteth0-NIC dev rteth0'
>>
>> Add destination to rteth0 routing table manually (same as above but with destination IP and MAC addresses) or ping 192.168.56.101 from destination and the destination route is added to rteth0 routing table, complete with destination MAC address.
>>
>> 'rtroute' wil list the current routing table.
>>
>
> Dear Paul, Thank you so much for your suggestion.
>
> Yes, I already tried attaching the route, but still I am not connected.
> In fact the situation becomes more worse.
> I am not able to ping that IP using rtping.
>
> Please see the details below:
>
> Previous rtroute table entry:
> ---------------------------------------
> $ sudo /usr/xenomai/sbin/rtroute
> Host Routing Table
> Hash Destination HW Address Device
> 01 127.0.0.1  00:00:00:00:00:00 rtlo
> 26 192.168.56.102 00:00:00:00:00:00 rtlo
> 3F 192.168.56.255 FF:FF:FF:FF:FF:FF rteth0
>
> After this when I do rtping, I get:
> $ sudo /usr/xenomai/sbin/rtping 192.168.56.102
> Real-time PING 192.168.56.102 56(84) bytes of data.
> 64 bytes from 127.0.0.1: icmp_seq=1 time=5.1 us
> 64 bytes from 127.0.0.1: icmp_seq=2 time=6.8 us
> ^C
>
>
> After adding the route manually:
> --------------------------------------------------
> $ sudo /usr/xenomai/sbin/rtroute add 192.168.56.102 08:00:27:52:BA:F1 dev rteth0
>
> $ sudo /usr/xenomai/sbin/rtroute
> Host Routing Table
> Hash Destination HW Address Device
> 01 127.0.0.1  00:00:00:00:00:00 rtlo
> 26 192.168.56.102 08:00:27:52:BA:F1 rteth0
> 26 192.168.56.102 00:00:00:00:00:00 rtlo
> 3F 192.168.56.255 FF:FF:FF:FF:FF:FF rteth0
>
>
> $ sudo /usr/xenomai/sbin/rtping 192.168.56.102
> Real-time PING 192.168.56.102 56(84) bytes of data.
> ioctl: Resource temporarily unavailable
>
>
> If you need more information please let me know.
>

One more question, what is the purpose of REBIND_RT_NICS ?

If I add the line like this:
REBIND_RT_NICS="0000:00:03.0"

Then, when I stop rtnet, the non-real time driver is automatically loading.
Do I need to set it, considering I am using same network for both.


And, these are the final steps I followed:

sudo /usr/xenomai/sbin/rtnet stop
sudo modprobe -r e1000
sudo modprobe rtnet
sudo modprobe rtipv4
sudo modprobe rt_e1000
sudo modprobe rtudp
sudo modprobe rtpacket
sudo modprobe rt_loopback
sudo echo 0000:00:03.0 > /sys/bus/pci/drivers/rt_e1000/bind
sudo /usr/xenomai/sbin/rtifconfig rtlo up 127.0.0.1
sudo /usr/xenomai/sbin/rtifconfig rteth0 up 192.168.56.102 netmask 255.255.255.0
sudo modprobe rtcfg
#sudo modprobe rtmac
#sudo modprobe tdma

But, now rteth0 is not coming up.

Is anything missing here ?


Thanks,
Pintu


>
> Thanks,
> Pintu
>
>
>
>> Paul.
>>
>> ___________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

