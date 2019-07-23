Subject: Re: TDMA with RTnet on Xenomai
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
Date: Tue, 23 Jul 2019 17:38:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
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

On 23.07.19 17:32, danwe wrote:
> 
> 
> Am Di., 23. Juli 2019 um 16:58 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>>:
> 
>     On 23.07.19 16:28, danwe wrote:
>     >     On 22.07.19 17:58, danwe via Xenomai wrote:
>     >     > Hi,
>     >     >
>     >     > I have Xenomai 2 with RTnet on a BeagleBone Black. I ask myself how  I
>     >
>     >     I cannot tell you in advance if my answers applied to version 2 as well,
>     >     probably, but no one is working on that anymore.
>     >
>     >     > can run TDMA on BeagleBone Black? Programs like RTping and Roundtrip
>     >     > program are working.
>     >     >
>     >     > I have changed the rtnet.conf file so that it will use TDMA.conf file.
>     >     > In TDMA.conf all parameters like IP-address, clock cycle and slottime
>     >     > are determined.
>     >     > In rtnet file I saw some drivers like rtmac. Do I have to load that
>     >     > driver for using TDMA as it is not loaded yet? Are there any other
>     >     > drivers beside rtudp, rtipv4, rtpacket, rt_ticpsw, rt_davinci_mdio,
>     >     > rt_smsc, rtnet and omap_rng which need to be loaded?
>     >
>     >     The RTnet startup scripts should load all necessary stack components
>     for you.
>     >     rtmac.ko belongs to them, tdma.ko will not load without it. In
>     addition, the
>     >     scripts will load rtcfg in order to distribute the IP and TDMA
>     configuration
>     >     from the master to the slaves.
>     >
>     >
>     > I do not have tdma.ko nor rtcfg.ko. Is it possible to copy/paste them to my
>     > sd-card where Xenomai / RTnet is running and load them in the RTnet startup
>     > scripts? Or do they need to be installed during building the kernel and
>     Xenomai
>     > / RTnet on top? Do you have those files you can give me? 
>     >
> 
>     If you enable the related kernel features, they are generated as part of the
>     normal kernel build. Watch out for CONFIG_XENO_DRIVERS_NET_RTMAC/TDMA/RTCFG.
> 
> Do you mean in my buildroot folder where I can use the command "make menuconfig"
> and select different kernel build things?
> I have watched out for this but did not find anything. TDMA and rtcfg folder in
> my compiled buildroot folder existing though. But I don't see any tdma.ko or
> rtcfg.ko files.

Then you need to adjust your kernel config. make menuconfig if interactively,
but I don't know where that result is reused for the next buildroot run.

> 
>     >
>     >     >
>     >     > And now I ask myself how can I run TDMA? Is it just using the IPs
>     >     > (which are written in your TDMA.conf file) for your microcomputer, and
>     >     > that's it?
>     >
>     >     Try the rtnet start scripts. They set up a TDMA network according to
>     the conf
>     >     file. One node should be configured to be master, another as slave.
>     >
>     >     > If TDMA will work, do I see any output of my communication cycle or
>     >     > anything that shows that TDMA is running? At the moment I don't see
>     anything.
>     >
>     >     A basic test is rtping: If you can ping the other RTnet station,
>     connections
>     >     works. If you see a suspicious jitter of the ping delay that is
>     between one and
>     >     two times the TMDA cycle time, also that works.
>     >
>     >     > What else do I have to change in rtnet.conf? I have just changed the
>     >     > very last line for using TDMA.conf file and I have changed TDMA_MODE
>     >     > to master for my master BBB and to slave for my slave BBB.
>     >     >
>     >     > So just the short question: What to do to use TDMA?
>     >     >
>     >
>     >     rtnet.conf is documented. If anything concrete remains unclear from
>     reading
>     >     that, please let us know. Also study the help of the rtnet start script.
>     >
>     >     Did you check that raw (RTmac-free) RTnet works fine (rtping)?
>     >
>     >  
>     > When I'd like to use "rtping" I need to tell the microcomputers to which
>     MAC the
>     > IP-address of the other microcomputer belongs to.
>     > So I use the command: #  rtroute add IP_other_µC MAC_other_µC dev rteth0
>     > Doing this on both µC then I can use "rtping" with: # rtping
>     IP_address_other_µC.
>     > Then rtping works fine. That should be fine, shouldn't it?
>     >
> 
>     This sounds good, indeed. If the pings also run for some dozens of packets, it's
>     perfect because that test reveals there are package leaks / unacknowledged
>     outgoing packets that would otherwise empty the buffer pool quickly.
> 
> 
> Yes rtpings don't stop. But this is just because the buffer works, isn't it? It
> has nothing to do with TDMA, right?

Yes. This is a good sign for the tricky low-level driver part, but you still
need to enable TDMA in the kernel to get that working as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

