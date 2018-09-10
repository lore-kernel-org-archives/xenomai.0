References: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
 <f5ec79d7-be26-3d87-8d1b-8714d4f3a14a@xenomai.org>
 <007001d4361f$01d02010$05706030$@sepro-group.com>
 <346547f0-852d-ffe7-d1ff-f156db9a59d1@gmail.com>
 <00d201d439f1$8ccd3fb0$a667bf10$@sepro-group.com>
 <CAOgDLiEp0SzdwJ9G5+T_zUSM-CAKMompHqWE3SXwfmbJhx1meg@mail.gmail.com>
 <011a01d43b79$28463b80$78d2b280$@sepro-group.com>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <3a158c17-45b9-1a97-9b9c-c6e4981cae51@gmail.com>
Date: Mon, 10 Sep 2018 17:24:46 +0200
MIME-Version: 1.0
In-Reply-To: <011a01d43b79$28463b80$78d2b280$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] TR: RTNet - how to setup rt_fec on IMX6Q (Xenomai
 3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>
Cc: Xenomai <xenomai@xenomai.org>

Hi Stéphane.

With Xenomai 3.0.6 / Linux 4.9.51 build, together with the rt_fec patch
I sent, and with RTNet IP layer enabled (I usually only using raw packet
level), I could reproduce your experiment, but couldn't reproduce the
bug. It just works :


# modprobe rtnet
[   54.424453]
[   54.424453] *** RTnet for Xenomai v3.0.6 ***
[   54.424453]
[   54.431748] RTnet: initialising real-time networking
# modprobe rtipv4
# modprobe rt_fec
# modprobe rtudp
# modprobe rtpacket
# echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
# echo 2188000.ethernet > /sys/bus/platform/drivers/rt_fec/bind
[  440.299232] libphy: fec_enet_mii_bus: probed
[  440.303524] RTnet: registered rteth0
# rtifconfig rteth0
rteth0    Medium: Ethernet  Hardware address: 00:1E:AC:00:B0:63
          BROADCAST  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
 
# rtifconfig rteth0 up 192.168.42.10
[  500.575716] Atheros 8035 ethernet 2188000.ethernet:01: attached PHY
driver [Atheros 8035 ethernet] (mii_bus:phy
#
# [  505.755173] rt_fec 2188000.ethernet (unnamed net_device)
(uninitialized): Link is Up - 1Gbps/Full - flow cont
[  507.835111] rt_fec 2188000.ethernet (unnamed net_device)
(uninitialized): Link is Down
[  508.875169] rt_fec 2188000.ethernet (unnamed net_device)
(uninitialized): Link is Up - 1Gbps/Full - flow contro
[  510.955108] rt_fec 2188000.ethernet (unnamed net_device)
(uninitialized): Link is Down
[  511.995166] rt_fec 2188000.ethernet (unnamed net_device)
(uninitialized): Link is Up - 100Mbps/Full - flow cont
# rtroute add 192.168.42.3 00:0e:c6:d3:d3:e0 dev rteth0
# rtping 192.168.42.3
Real-time PING 192.168.42.3 56(84) bytes of data.
64 bytes from 192.168.42.3: icmp_seq=1 time=394.4 us
64 bytes from 192.168.42.3: icmp_seq=2 time=288.3 us
64 bytes from 192.168.42.3: icmp_seq=3 time=343.3 us
64 bytes from 192.168.42.3: icmp_seq=4 time=384.8 us
....

Note that Ethernet speed negotiation seems to be failing, since it falls
back to 100M after a few seconds, whereas at the the other end of the
cable is supposed to be another Gigabit Ethernet controller as well. I
also saw that behavior with non-real time fec driver, I should check the
cable it looks prehistorical.

Please if possible give a shot to 3.0.6, just to see if this is the cause.

FYI, my test board is an APF6 dev board from OpossSOM, fec related DTS
looks like :

&fec {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_enet>;
    phy-mode = "rgmii";
    phy-reset-duration = <10>;
    phy-reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
    status = "okay";
};

Best regards,

Edouard


On 24/08/2018 09:07, Stéphane Reichert wrote:
> Hello Edouard,
>
> Thanks for your mail.
>
> We already applied these changes in our file fec.c, but it didn"t solve our 
> issue.
>
> Il will let you know if we find an issue.
>
> Best regards
> Stéphane
>
> -----Message d'origine-----
> De : Edouard Tisserant [mailto:edouard.tisserant@gmail.com]
> Envoyé : jeudi 23 août 2018 23:10
> À : Stéphane Reichert
> Cc : Xenomai (xenomai@xenomai.org)
> Objet : Re: [Xenomai] TR: RTNet - how to setup rt_fec on IMX6Q (Xenomai 
> 3.0.7)
>
> Hi Stéphane.
>
> Well, sorry for untested patch, and thanks for your help in debugging it !
>
> Looking back in recent changes in rtnet, this problem may be related to this 
> commit (changes on 8139too.c are explicit):
> https://gitlab.denx.de/Xenomai/xenomai/commit/3e97e64ee27ce01e8488d06c52bc4681729b30b9
>
> Patching fec.c in a similar way may certainly help, since apparently 
> signatures are now incompatible.
>
> Please let me know if it helps.
>
> Best regards,
> Edouard.
>
>
> Le mer. 22 août 2018 à 10:24, Stéphane Reichert <sreichert@sepro-group.com> 
> a écrit :
>> Hello Edouard,
>>
>> Thanks again for your patch.
>>
>> I tried it on my kernel, but unfortunately I am facing the same issue
>> (ioctl: Resource temporarily unavailable error message on rtping).
>>
>> Best regards
>> Stéphane
>>
>> -----Message d'origine-----
>> De : Edouard Tisserant [mailto:edouard.tisserant@gmail.com]
>> Envoyé : mardi 21 août 2018 23:19
>> À : Stéphane Reichert; xenomai@xenomai.org Objet : Re: [Xenomai] TR:
>> RTNet - how to setup rt_fec on IMX6Q (Xenomai
>> 3.0.7)
>>
>> Hello Stéphane.
>>
>> I'm porting EtherLAB to Xenomai3 on Imx6, using RTNet instead of
>> EtherLAB provided drivers.
>>
>> This is still work in progress, but the fec.c patch I have now may help.
>> Find it attached.
>>
>> I built it last time on kernel 4.9.51 and xenomai 3.0.6. This is
>> largely untested, your feedback is welcome.
>>
>> Beware content of DTS for vanilla FEC from kernel 4.x may not be
>> compatible anymore with the one expected by FEC from RTnet. You may
>> have to patch you DTS accordingly.
>>
>> Best regards,
>>
>> Edouard
>>
>>
>>
>> On 17/08/2018 13:39, Stéphane Reichert wrote:
>>> Hello Philippe,
>>>
>>> I have noticed in the file fec.c that the function fec_enet_ioctl
>>> did not match the prototype of do_ioctl (it looks like "request" and 
>>> "arg"
>>> parameters are switched). Is it a mistake ?
>>>
>>> (I tried to switch these parameters but it didn't solved my problem
>>> as well).
>>>
>>> Stephane
>>>
>>>
>>> -----Message d'origine-----
>>> De : Philippe Gerum [mailto:rpm@xenomai.org] Envoyé : vendredi 17
>>> août
>>> 2018
>>> 10:28 À : Stéphane Reichert; xenomai@xenomai.org Objet : Re:
>>> [Xenomai] RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)
>>>
>>> On 08/16/2018 03:23 PM, Stéphane Reichert wrote:
>>>> Hello,
>>>>
>>>>
>>>>
>>>> We are trying to use the rt_fec driver for RTNet on a iMX6Q board.
>>>>
>>>>
>>>>
>>>> I have patched the KConfig to add this driver on buildroot and it
>>>> compiles perfectly.
>>>>
>>>>
>>>>
>>>> But now, I am not able to use it on our board (it works when I “rtping”
>>>> the loopback,
>>>>
>>>> but it doesn’t work if I try to ping an external board).
>>> The fec driver does not seem to tell the stack about the carrier
>>> enable state. If so, you may want to try the following patch:
>>>
>>> diff --git a/kernel/drivers/net/drivers/fec.c
>>> b/kernel/drivers/net/drivers/fec.c
>>> index 36870ba16..d94ec690f 100644
>>> --- a/kernel/drivers/net/drivers/fec.c
>>> +++ b/kernel/drivers/net/drivers/fec.c
>>> @@ -1323,6 +1323,7 @@ fec_enet_open(struct rtnet_device *ndev)
>>>               return ret;
>>>       }
>>>       phy_start(fep->phy_dev);
>>> +     rtnetif_carrier_on(ndev);
>>>       rtnetif_start_queue(ndev);
>>>       fep->opened = 1;
>>>       return 0;
>>>
>>> --
>>> Philippe.
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai


