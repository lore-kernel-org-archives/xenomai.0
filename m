Subject: Re: TDMA with RTnet on Xenomai
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
 <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
 <CAEmXcAzd3P9DkRHVbtvzgB_J52gUtaVd19h8=r-VL4frp0Gm3Q@mail.gmail.com>
 <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
 <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
 <CAEmXcAw_Qek1jEguriG51MKoosN2QOVuAOHSjkW0j43rinryHA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d74187a6-761f-4fd8-bf5a-bf72f58b6fd9@siemens.com>
Date: Wed, 24 Jul 2019 10:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAw_Qek1jEguriG51MKoosN2QOVuAOHSjkW0j43rinryHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 24.07.19 10:15, danwe wrote:
> Today I have tried TDMA on rtnet with all the necessary modules/drivers.
> Unfortunately I do not see any different output on rtping. It is the same as before.
> This is the output:
> 
> # rtping 192.168.127.11
> Real-time PING 192.168.127.11 56(84) bytes of data.
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=1 time=226.7 us
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=2 time=142.2 us
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=3 time=151.1 us
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=4 time=128.8 us
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=5 time=135.1 us
> 64 bytes from 192.168.127.11 <http://192.168.127.11>: icmp_seq=6 time=122.9 us
> 
> --- 192.168.127.11 rtping statistics ---
> 6 packets transmitted, 6 received, 0% packet loss
> worst case rtt = 226.7 us
> 
> And this are the modules which are loaded:
> 
> # lsmod
> Module                  Size  Used by    Tainted: G
> tdma                   18805  0
> rtcfg                  45592  0
> rtmac                   7219  1 tdma
> rtudp                   7640  0
> rtipv4                 18699  2 rtcfg,rtudp
> rtpacket                4179  0
> rt_ticpsw              26115  0
> rt_davinci_mdio         4570  0
> rt_smsc                 2165  0
> rtnet                  28479  7 tdma,rtcfg,rtmac,rtudp,rtipv4,rtpacket,rt_ticpsw
> omap_rng                4174  0
> 
> I would like to ask you if you could take a look at my settings for the master
> in rtnet.conf and tdma.conf if everything is correct? For slave I have just
> change "master" to "slave". Should I start realtime loopback device and
> capturing interface? I do not have started the driver for realtime loopback
> device. Is that a problem?

I don't recall all details anymore, but I do not spot any obvious mistake.

What did you call to start rtnet on both sides? What was the console output? Did
you try adding -v to the start script to see more?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

