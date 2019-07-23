Subject: Re: TDMA with RTnet on Xenomai
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
 <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
 <CAEmXcAzd3P9DkRHVbtvzgB_J52gUtaVd19h8=r-VL4frp0Gm3Q@mail.gmail.com>
 <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
Date: Tue, 23 Jul 2019 19:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 23.07.19 18:09, danwe via Xenomai wrote:
> Am Di., 23. Juli 2019 um 18:08 Uhr schrieb danwe <
> daniel.wenninger92@gmail.com>:
> 
>>
>>
>> Am Di., 23. Juli 2019 um 17:38 Uhr schrieb Jan Kiszka <
>> jan.kiszka@siemens.com>:
>>
>>> On 23.07.19 17:32, danwe wrote:
>>>>
>>>>
>>>> Am Di., 23. Juli 2019 um 16:58 Uhr schrieb Jan Kiszka <
>>> jan.kiszka@siemens.com
>>>> <mailto:jan.kiszka@siemens.com>>:
>>>>
>>>>     On 23.07.19 16:28, danwe wrote:
>>>>     >     On 22.07.19 17:58, danwe via Xenomai wrote:
>>>>     >     > Hi,
>>>>     >     >
>>>>     >     > I have Xenomai 2 with RTnet on a BeagleBone Black. I ask
>>> myself how  I
>>>>     >
>>>>     >     I cannot tell you in advance if my answers applied to version
>>> 2 as well,
>>>>     >     probably, but no one is working on that anymore.
>>>>     >
>>>>     >     > can run TDMA on BeagleBone Black? Programs like RTping and
>>> Roundtrip
>>>>     >     > program are working.
>>>>     >     >
>>>>     >     > I have changed the rtnet.conf file so that it will use
>>> TDMA.conf file.
>>>>     >     > In TDMA.conf all parameters like IP-address, clock cycle
>>> and slottime
>>>>     >     > are determined.
>>>>     >     > In rtnet file I saw some drivers like rtmac. Do I have to
>>> load that
>>>>     >     > driver for using TDMA as it is not loaded yet? Are there
>>> any other
>>>>     >     > drivers beside rtudp, rtipv4, rtpacket, rt_ticpsw,
>>> rt_davinci_mdio,
>>>>     >     > rt_smsc, rtnet and omap_rng which need to be loaded?
>>>>     >
>>>>     >     The RTnet startup scripts should load all necessary stack
>>> components
>>>>     for you.
>>>>     >     rtmac.ko belongs to them, tdma.ko will not load without it. In
>>>>     addition, the
>>>>     >     scripts will load rtcfg in order to distribute the IP and TDMA
>>>>     configuration
>>>>     >     from the master to the slaves.
>>>>     >
>>>>     >
>>>>     > I do not have tdma.ko nor rtcfg.ko. Is it possible to copy/paste
>>> them to my
>>>>     > sd-card where Xenomai / RTnet is running and load them in the
>>> RTnet startup
>>>>     > scripts? Or do they need to be installed during building the
>>> kernel and
>>>>     Xenomai
>>>>     > / RTnet on top? Do you have those files you can give me?
>>>>     >
>>>>
>>>>     If you enable the related kernel features, they are generated as
>>> part of the
>>>>     normal kernel build. Watch out for
>>> CONFIG_XENO_DRIVERS_NET_RTMAC/TDMA/RTCFG.
>>>>
>>>> Do you mean in my buildroot folder where I can use the command "make
>>> menuconfig"
>>>> and select different kernel build things?
>>>> I have watched out for this but did not find anything. TDMA and rtcfg
>>> folder in
>>>> my compiled buildroot folder existing though. But I don't see any
>>> tdma.ko or
>>>> rtcfg.ko files.
>>>
>>> Then you need to adjust your kernel config. make menuconfig if
>>> interactively,
>>> but I don't know where that result is reused for the next buildroot run.
>>>
>>
>> I have searched for the TDMA and rtcfg folder and run the makefile with
>> make command. It compiled and generated my tdma.ko and rtcfg.ko. Now I have
>> just to copy it on sd-card and run it with my rtnet scripts right? Do they
>> need in specific folders on my sd-card?
>>

These are just more kernel modules, like those for RTnet (rtnet.ko, <driver>.ko)
that likely already exist - unless those are built-in.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

