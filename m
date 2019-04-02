Subject: Re: RTnet packet loss issue
References: <4e051b43-3677-e3e4-55f7-12aff5468c32@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <42f53356-c988-8810-422a-c9ab7b415c4e@siemens.com>
Date: Tue, 2 Apr 2019 13:01:56 +0200
MIME-Version: 1.0
In-Reply-To: <4e051b43-3677-e3e4-55f7-12aff5468c32@compador.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 28.03.19 09:53, Johannes Holtz via Xenomai wrote:
> Preface:
> 
> Xenomai 2.6
> 
> Vanilla kernel 3.8.13 i686
> 
> RTnet 0.9.13
> 
> 
> I have two PCs (M and S) connected via Ethernet exclusively for RTnet use.
> 
> M--[switch]---S
> 
> M's NIC is driven by the rt_r8169 driver
> 
> S's NIC by the rt_e1000 driver
> 
> 
> The problem is that the connection is unstable and about 80% of the packets get 
> lost.
> 
> root@machinectrl:~# rtping 192.168.0.1
> Real-time PING 192.168.0.1 56(84) bytes of data.
> 64 bytes from 192.168.0.1: icmp_seq=1 time=111.2 us
> 64 bytes from 192.168.0.1: icmp_seq=7 time=99.2 us
> 64 bytes from 192.168.0.1: icmp_seq=13 time=99.1 us
> 64 bytes from 192.168.0.1: icmp_seq=23 time=100.5 us
> 64 bytes from 192.168.0.1: icmp_seq=24 time=97.5 us
> 64 bytes from 192.168.0.1: icmp_seq=30 time=104.8 us
> 64 bytes from 192.168.0.1: icmp_seq=32 time=101.8 us
> 64 bytes from 192.168.0.1: icmp_seq=34 time=102.1 us
> 64 bytes from 192.168.0.1: icmp_seq=35 time=101.4 us
> 64 bytes from 192.168.0.1: icmp_seq=37 time=101.5 us
> 64 bytes from 192.168.0.1: icmp_seq=38 time=99.7 us
> 64 bytes from 192.168.0.1: icmp_seq=43 time=99.2 us
> 64 bytes from 192.168.0.1: icmp_seq=54 time=101.3 us
> 64 bytes from 192.168.0.1: icmp_seq=60 time=102.2 us
> 64 bytes from 192.168.0.1: icmp_seq=63 time=97.3 us
> 64 bytes from 192.168.0.1: icmp_seq=69 time=100.3 us
> 64 bytes from 192.168.0.1: icmp_seq=80 time=101.2 us
> 64 bytes from 192.168.0.1: icmp_seq=84 time=100.7 us
> 64 bytes from 192.168.0.1: icmp_seq=86 time=103.4 us
> 64 bytes from 192.168.0.1: icmp_seq=88 time=105.1 us
> 64 bytes from 192.168.0.1: icmp_seq=89 time=101.2 us
> 64 bytes from 192.168.0.1: icmp_seq=96 time=100.7 us
> 64 bytes from 192.168.0.1: icmp_seq=98 time=99.2 us
> 64 bytes from 192.168.0.1: icmp_seq=99 time=103.2 us
> 64 bytes from 192.168.0.1: icmp_seq=113 time=98.8 us
> 64 bytes from 192.168.0.1: icmp_seq=116 time=105.7 us
> 64 bytes from 192.168.0.1: icmp_seq=119 time=111.2 us
> 64 bytes from 192.168.0.1: icmp_seq=126 time=101.7 us
> 64 bytes from 192.168.0.1: icmp_seq=130 time=102.6 us
> ^C
> --- 192.168.0.1 rtping statistics ---
> 135 packets transmitted, 29 received, 79% packet loss
> worst case rtt = 111.2 us
> 
> This happens sometimes from the start after both machines are booted without 
> prior communication.
> If it is not broken from the start the RTnet works as expected.
> But it also happens after the system is running for several hours without any 
> noticeable user action that would cause it.
> 
> The cables and connectors have all been double checked.
> 
> Is this a know error or is there anything you can tell me about this pattern?
> 
> I'm grateful for every piece of advice as always.
> 

Check if you are also missing interrupts on one of the sides. Are they shared 
with other devices?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

