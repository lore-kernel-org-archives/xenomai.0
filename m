Message-ID: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
Date: Thu, 26 Apr 2007 14:04:12 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13538_22559348.1177589052500"
Subject: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_13538_22559348.1177589052500
Content-Type: multipart/alternative; 
	boundary="----=_Part_13537_26414451.1177589052500"

------=_Part_13537_26414451.1177589052500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everybody,

I am using kernel 2.6.20.4 and Xenomai 2.3.1 on a SMP enabled dual core Pen=
tium 4.
Everything works fine when I do not enable the CONFIG_PCI_MSI (Messages sig=
naled interrupts) for
PCI Express.
As I am always short with interrupts I want to use MSI for the PCIe base
I/O devices like Ethernet.

When I run the same kernel without any Xenomai patch, it works really fine.
My onboard PCIe e1000 network adapter will be loaded fine and gets the (coo=
l) interrupt number 219!
Perfect!

When I use the Adeos patch from Xenomai 2.3.1 on this kernel the modprobe o=
f the e1000 driver
leads to a kernel crash.
At this stage no real time application is running.
Using a serial console, I was able to log the kernel dump.
Here it is:

BUG: unable to handle
 kernel NULL pointer dereference at virtual address 00000000
 printing eip:
*pde =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in: e1000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010086   (2.6.20.4 #7)
EIP is at _stext+0x3feffc70/0x14
eax: c0112244   ebx: 00000006   ecx: c011434d   edx: c168c000
esi: 00000006   edi: 00000046   ebp: ffffffff   esp: c168de20
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1231, ti=3Dc168c000 task=3Dc1692a90 task.ti=3Dc168c0=
00)
Stack: c03e5680 000000db 00000000 c03d9100 c010ef83 00006d80 00000001 00000=
060
       e099a210 00000286 ffffff24 df77b5c8 00000000 0000000f 00000001 c0103=
439
       df77b5c8 e099a0ff e09c0000 00000000 0000000f 00000001 80080740 dfd20=
07b
Call Trace:
 [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0a1>] dev_mc_upload+0x24/0x37
 [<c02db5ac>] dev_open+0x44/0x62
 [<c02da079>] dev_change_flags+0x47/0xe4
 [<c030d192>] devinet_ioctl+0x252/0x56f
 [<c02db18a>] dev_ifsioc+0x113/0x38d
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c02d1732>] sock_ioctl+0x18e/0x1ad
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c015e18f>] do_ioctl+0x1f/0x62
 [<c015e416>] vfs_ioctl+0x244/0x256
 [<c015e45b>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code:  Bad EIP value.
EIP: [<00000000>] _stext+0x3feffc70/0x14 SS:ESP 0068:c168de20
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010b903>] smp_call_function+0x66/0x10a
 [<c0118e12>] printk+0x62/0xd5
 [<c010b9c2>] smp_send_stop+0x1b/0x2b
 [<c01183ad>] panic+0x4d/0xe4
 [<c0103f71>] die+0x1f2/0x226
 [<c011167c>] do_page_fault+0x447/0x517
 [<c010f61d>] __ipipe_handle_exception+0xce/0x158
 [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
 [<c033336d>] error_code+0x81/0x90
 [<c011434d>] try_to_wake_up+0x33c/0x346
 [<c0112244>] __activate_task+0x1c/0x29
 [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0a1>] dev_mc_upload+0x24/0x37
 [<c02db5ac>] dev_open+0x44/0x62
 [<c02da079>] dev_change_flags+0x47/0xe4
 [<c030d192>] devinet_ioctl+0x252/0x56f
 [<c02db18a>] dev_ifsioc+0x113/0x38d
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c02d1732>] sock_ioctl+0x18e/0x1ad
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c015e18f>] do_ioctl+0x1f/0x62
 [<c015e416>] vfs_ioctl+0x244/0x256
 [<c015e45b>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have attached my kernel config to this mail.
Any idea on this? Is there anybody out there that has MSI running succesful=
ly with the Xenomai adeos patch?

Thanks for any feedback on that issue!

Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


50=80 AMAZON-Einkaufsgutschein bei Bestellung von Arcor-DSL:
Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_13537_26414451.1177589052500--

------=_Part_13538_22559348.1177589052500
Content-Type: application/octetstream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

H4sICHSDMEYAAy5jb25maWcAlFxhb9s4k/6+v0LovsC1wLaxHcdNFpcDaIqyeRYlRaQcu18EN1Fb
Xx07r2PvNv/+hqRlURKp7LvAphGfITUkZ4Yzw1F+/+13Dx0Pu6fVYf2w2mxeve/FttivDsWj97T6
WXgPu+239fc/vcfd9r8OXvG4PkCPcL09/vJ+FvttsfH+KvYv6932T2/wafRp0Ps0BALx4+ih5703
GHn9wZ/D6z8HPW/Q633+7fffcBwFdJIvrkf55eD2tXyekIikFOeCMlK1hjGe+STJeZYkcSoqgAuE
ZyJFmFgwwlAyjVOAQkISkvIKg9dWD4xlbQYoR7nPkAWIYdh28zibtBun94ROpgZPKMXTnKFlPkVz
kic4D3xcoT6jxgMJytlTLm7fXWzWXy+edo/HTfFy8a8sQozkKQkJ4uTik96ed7/Bwv7u4d1jAbt2
OO7Xh1dvU/wFu7N7PsDmvFQLTxawIrDIkUBhfaHzGUkjYjTSiIqcRHPgXjLDqLi9HOhXTZSUbLyX
4nB8rgaHYVA4hxWncXT77p3kqQ3kKBOxt37xtruDHOC8b/fm+vIln9NELtJ5EHjMI27pmcScLnJ2
l5GMmB3G3M+TNMaE8xxhLMyuZyKB+AzESXArmglufyfKfGpusHwEnmGa5grO9C+1WcxKroEz6ztx
knEibC+FFwQcJCRJCUaC+Oa4IBNoaekjdzFFDPrxOEsxkftSvgjncQIaR7+QPIjTnMMvtR3AIjRf
QdiY+D7xLW/JqN8fNfvmrQWZwRNfMm6OWraBaAKjeYK4berTWCShqWtJSiMxq55rikjCIMdgAgwY
9CUPMpOZIBNkYfRJYhPlU0aY8RiicfU0ZzmZgw7BS7JI1ExMKnImBya1SQoaLfWQlrkp3jiTK9Wr
uvAwHpvESvHC3epx9XUDeq4sgvdyfH7e7Q+VCrLYz0Ji8KMb8iwKY+S3mmHbsQGeXw7wSV3tenHq
zlN81uowtExtBoSm2Y4TMIN4SiO5NWpG483u4ae3Wb0W+2oWY2mQDPM0rjE3DmegBHMwybk6A6wc
hjxorR6NPf7wo5ArtzdsIo05nhI/j+LYsEBlK+LtNp8gP9STaCA4uKvZcpSFQg9x5qxsLQexsl8S
wXiduOTZsu4lfGLr9t1qCyf8+nl12O1fT+dFWqw2Hw/rJylFXz++vL4ciifjhCYRnHjGwSQbpL3I
owyHJOO3Ty0EjpY54nRes8JnlPIpJaFvnc6ZKE2oD2fwOCSWWZ2pOMFZSsVSmnWw7hYmE5oQubj5
lJhiX8MdzXmUgnTJs67FHJnAmZwuLR1LCDqD4gp+e9Vv9wd7KPlJ+Jfb/uC6DctjyLp0PgHz1hJn
sX5ab7/rs7/RQVr1aCI3hMY+xV1rWSMFA+TApWeWhki4KZSkaQrFEwePcvV1vQFvxMqjPBvkRuuO
b7BIUu0P2VZHw3Jhu2VL091PCQlba8l/rPbg9K63h2K/Pz4fXuwsT2l6l4dg+8PuV2lC4k9I601s
9fBjvS3qmgYuYx4kWWkUI0a9v1eHhx+Pu/b+AingWiZyWG8S4WV7PnKE3f7nar87bh9tY3A1hiAY
xKtb42rEDdk/YfdxOkMpHIZNXTvh2gvQRlgu8bfVQ/HSWAI+o1EeISHtR9u2aMCltwYKnkAACjbs
3YxcZB16fKLg5tnfBNXR74ZZ3a9owtBsM0gntHRiHbAUcjcK+pR28M0Sm6U8geBNpS3tUlui3Gu3
uGsaHtsdhYokAz80jt4gmqfirVfNF1LY3npbKhB1yfOJwGcWMZPNeUBDH3woaaOVyPr79V/aY9C6
VezXEPw8nlvr7/dTKp2ivD+6uuqhttUuXg5gtt/srqzVGJR76p5qSQvG5h9S8nsq8FQQLlqMYRS9
yZSkafZL9jtQ5pfd3ju8PhfeavvofStkGGpqOGem3EL0X4/tZAsEMA7xAHAeL9GEpE48yhiye0oS
5RmD8NUJj+kE+HO/m/J7h7wBegr6ZYjvpCH8c6/Xs8IJStGcpnbm2OX1yA4MXcBVByC4PeKUGGN2
xWMj14AJWEGaMUrfgLtxZkdl9DawKHDZbViLVmYOFmefHe3XjremGY/tDjkjQUAxcVgwdk9B/WiC
HYyc4EEnemn3jdmExD6ZLPodaB46dg8vU7pw7sGcInyZ27kyZNtmSAHFLFng6aSu1wvk+/WWsA9m
A1w86RQF4vbzOVK+h1M2lyNAFzi7JjG49FNmbqzKm00RGLgwngzy7NLOapNsNLRwXCbnwOuk4xTc
JnBoQrSs83qfKFeG5/GsDtBoHiaNqY7rKStl1eIE+a3Op4UaDevNkziGeScUN18lSJhnnKQ4Thr8
QWueJGmcw3riGZi1OgwKbi7fNCEnr9eyHlGqMk2310bKQYWwnAkLucaYwWuSEsKkAxFHtYCvbJ/H
YRYJlC7tdk9TdWH5eGbLKdCGDyhFTOYXbUsZWxoZJq0GOYkA1XKiJZIMxZSkzITmTOWRq+xODKI9
Rta50OuZU71SMo5jEdBFljjSLBSnMQb9dg7BuPtMhO2lNZOijutgvX/6G4Idw6upMny+3QSBpoR5
Os5smQbsj5GRDIjiKZ2ccmeVIOqm4cQ6+gkd1eHz+TgheRwEnEBg+Qv39H+1xHoAQRD0z0kko5hG
1p3DAQt2xgmTUEZAgMcQvDNY6rBBASqdySiLw9TA0NZuATp7l2wxFGWolkiFeAt+E3RSwdaFqXhv
E9VfUn/riVPVz+T2PJzMNJhqwZOQijwR6h5AWYWhmVnWmWOej4ZjhxfFkJjmhMmFovUjsiQQaS28
IIHNPZd+LAQxkamhnGAcK++xEpgveb/uTlXA4KrXIL10eF56FPswtzCMkaImC2I7BJPpklNpeWA9
UymefS2cZlIeLJNwBNfn7nAiTSJL91PSW+6IpbtcFdjruc/jMrZOdn8Xe+9ptV19L56K7aG8//He
I5zQPzyUsA+VT54YYpOwPCQThJc1S87amScTbN5HtGyNfCu8+/Gv1fahePSwuq467leSKRUoaIbP
KYEPHm8mtOUQNZcAnuGH3Q+Q2BgJQVLbVYiGMyHiqDXinPokdg8KOzEj9oNM4YEjdFGgD1rlRk83
VLHdjuvp8sx+PiiUju0+tAItR1NtNUKEZzKxli8JSs3rB815c/dNkBgGRM8kvidpow1ERJCGlwKS
o5yS1iZIo4hoVHdXtCAlzJAjLTXsLOYfvDGNuSE71bAJa40ltSnYF/8+FtuHV+/lYbVpZFGBIA9S
ctfqOT6+VBqVYFCoBDNM0R8eoRx+Mgw/4DdTx3BNeuER3D7FrVWnFMyYfuwg8SmonM1N0zCKDL9R
Nsk31lv0CPW28sW1ViKv18dZvTtB5k6rvty4K5gKacqN2xF9qy6dsVpj7USAZ0cMY2/n+Negbr61
DcQQi/tyf+TWXODV/hH27YNxVWaspSJtj0C96e7wvDl+t8lUaZUlWbMr+VU8HA/qhu7bWv7Y7Z9W
ByMPMqZRwIS8oDTuJnUbijPRamRUufQ6K1wcZEpXS2vpbhHRho1r/zPXQOjS5gRsAKml1nULyAOy
XS5lETXzm0Fa8/Xks4pe7H6pRHk2BmMRUmy3qMBq3rC2pcjo6Z4DgRw8DnBkUP1iANqRP5dehJ+n
sKjW8AeIAjqWUeO00TeJ7KkgyZaMPTrASWr31CWnihNH+JrY3W6+jMAmxjNK7OZCLkeO7GknhRFu
55ZqdqUH4cbVVoksihyXHYqojbeGkG6xvKiNeL1Qp0mhRnLCY0KafX2KJo0mgZOyuYrOoA1+nZyF
wsLtmQZnY9MxLu9RS/z23cPx6/rhXX105l9x2r6fo8mf3ny9PxxXG5kzhmCr7gGZ6gkSMndscjK3
J5XkhEf/aJdGXQSAy5SH9LMZSmeWxQGKgIaifmCfG51OwjilPsRuZu9TnRIEn2CswEAeupakegP8
FtLI7kNFstIjimQhwOwU4tmVqRpuoRxybt0vN1/VRsEry2sa7Rbs14/fi66+ZybKNQlyMnZw4WOc
NDzl92bV1oeG2Cj61vUfFv/RIIq+dVMBFuIfD6KIrdZNWGte1ELcPlV0c4j78uveoO8qeMCwg5aR
whCbw8CjPUlIE3uKVGZ9HCmawZW1PUTJ2AoQ+JfYA+R7mFz7LFILeLfjMha62O29b6v13gPH9Fg0
XFJp21rX5Oap7x30tVKzUzITE2KPTaaIpcin9qiHpr7d6xrb50cJIXLz+m15Lv5aPxTNOzRVQbh+
ODV7cbNOESLqyEdhbNbYQJipiq4CmrJ7lMqbXhoayebgPpd1TGBpDHlQNRdLWZlCGzHWyRhtt8XD
Adb+o3fcrr+tIbw4vgCjzxCOev/98X9Oda76GSKFn6pOqYoVwPaAH20ZmRVPu/2rJ4qHH9vdZvf9
9bQSEDow4dd0B57bTuhqv9psio0n3c92nVcCTkPtND01NO7VylZwx6gjyVR1hIUN7NJg0PBMVYp0
kk0c90wljhbX159v7KdaSdMfXA/biyJdcpU32KxeLYsS1dJE8OionEn2u8PuYbepecgQf7hcP2hv
xmwVcspQGNVsj3qjzXo2XbEWWOvYFvYDC1aCOjK/sidO7nKXjp5gTDnvopEv9xG+GdkTZCVJ1ihb
bBHg+F5mo5g181cShbq6rt05XSYiDht1bC2yaGxfpRLni+uOl6fIyEEYjbqA87Y/smGqHtasIzFB
VaKoKPq9wbBJoapua5uN/TRm0hxjf26fCRxEeTwH/4SIaduarF8eDLmqhHbMcsTt28MnNKcxHlpB
QQOmamTbuRaBLuD/hF6wgF2kYdhWNJDL9nLqxpOeFquXAoYEu797OMocjfIfLtaPxafDr4OMi70f
xeb5Yr39tvPAsZCSrooParMzhs458NQpAVM/b+hLexSfcuNu7tSgo0gVZlhnhe3Vpz6BRXLr54km
COMksce5BhXH3H5FK2cuS9TlRop22Zqc8MOP9TM0lLt08fX4/dv6l2l+5CCn68/2BDHzR8OeVTMV
Ak71tBU22ebQMJ4WAkxray/TRnwqD3KdLGoNGgfBOG5kaBok1bTavRNBR4N+l1X4IjPu1j2X2apG
7q6BqtJpG2tVb/WpQy27oKE4CpdS8DpXFBE8GizsPuuZJqT9q8VlNw3zPw/fGkdQuui2v0oYukcR
KQ1C0k2Dl9cDPLrpZhnzq6tB95kkSS7/AYndgz+bjERcvjEpSTKyuyolyf+qa1q7k30+nnB/YL1r
KgkSqpJqbWkT14N+N4sRv/487HfPNPHxoAfilMeOCuwWYUTuu2c0v3dU4Z0pKGVo0m0hOYVd6neL
Aw/xTY+8sQkiZYObboGYUwTCt3DogjSSKLWfpBKTFTqO73LqlsGi8HQ+dhuKppGozjNLWA/HhPYC
bPnsFFEfdFmk1o+HMK+ZM/mci4k9nFOgJe1iwvLiKg94eeYr3k5M6UrA94/rl59/eIfVc/GHh/2P
4AB9aPvEvO4mTVPdauerhGPObbmA85ipbUF5mkP86Me2dPD5vRMrN7jtkfHdU2FuCMR1xafvn2Ci
3v8dfxZfd7/Odw7e03FzWD9vCi/MopqDoxZSux8AubcCfpcRseMrNUUSxpMJjeyXRoqAYxSBr7iM
sF2uxH61fZHstjnk8hKyKVd1kgC/RUHVzzeIOOL/hCSkY/jHPo/N7u+P+utHSzWrZkLg7sPu8j4H
M7FQCuVmBKhuXNZEEciizwBxhyzr5WjeQDXgKepfDTpeoQiG9oyXJkC4exaI4s+dszgROE+OM9HN
G6PcuNwQReDLT4QG9sSCHkGm7/myS8KigavMVo+QYle9FCMTpMwnHHuuhNmZRldKdNM0xLPOCDgV
1PrdlkLHGQdlrju1CogZFbLAh0+TmEYdUuWzxWX/pt+xX77Al4PrjrUirnBLa3smMvDbffmJWIfZ
mvjCfjul0VNFZoTTq8suXhqEOWOOBJSWAkcx3UlEqOjsHFHU75KhJOlYFuooZ9bHqeQeD3ujjgG4
cPjPGl0yGOEadLFD4Wlil3DNPeJ9ux+lYU4Hw549ElUEd0ow86BLuE80/U7xugshgrJnCc84dUbF
+sBLugbgBE2Q48LVWMxh13L4+PLm6lc33utQQwFr4Eaz/jC/HAYdBKFIEReOyiAtUzxx1ERrBp3V
W3oJUsvNkf64RWr/++f97vGDzreW2WjVXvx6BiqV1dl8ME7Z09hAUyvtEUiW1+qMvjWYl6kdOMnM
9IBqghDDKCeChmaQpKjY3DVkNDfy4z44KLW/7KBI7uT6NtrAsWWUkyYzi2GzhYbtlkGbijdasrA5
UYhMWi2C8BYPujQcx2xMo/rn/4lawtCuLhpkrjSzBFPhyL9q2J0fUHhHckDj7oD+jDui+Qq3B7ga
XyYp4Y6aKklAAuSorwPQ8pVDvXdHDuCMf+6YvsQXA/s5WRHYg2CFdyQBFN6VgVAEHR6LwrtSN4qA
oXROQtcNkiSQuumGwXnsJoBgE3e+QGc5OoRE5vu6UVB/N4E0EC4XVxHc+R3Dy5tUl2+qCb40i43r
eDtB1MAJbEDq/vSxnMOgN+gSRbBQI8e5fMI7hgcz5QbvaTSOo471OxHk87D9dy3izeMpQ1AeJ957
SSCPqT8UKfVJ7c4Uy7/XYEud6+sSGXB/rGdKvPcqEJLHWThn9QtYy2cSR/lnjTz5iYo74RJknDrU
TkMycu6CHR5M2dkS4sqLdq9/eTP03gfrfXEP/1trGyWdImsNADGWe0aNCKz8Yn29PexefpT9LHE1
Q1jW/7M442Qs2h+JlmUKrTef+qvyxDnF5p8u8TPGluZdvhQfV4qD3GVw/H1xlB0KR3JF1VWMm5qp
r8FSvC0Otjs3QBplHvrSa7rsWFhAQ9oWfHL4IesLQDjBtO32HrDCvq4PH2orI28E5R9nMq77Ga0l
86YoSZaMuL4jyaKJ4woXI84h5rF4UPK9Ol2WX4LHUb2ahP3qcx8SDsyHJDT/MAhQjsyny+rhEl/1
r6rHeZzKj+bPz2KZTOM4qhr0RyFP9Z07sceZXYsMkhRh1L49E8fN+tn7tnpab1697dsSCmIUUuOD
Gp8M+r2hybbCn0y5C2Xt573dCJxQVzSr4Qgltu3xyXBhLGBpXK+HvarRZzf9nrE/MN7VYGTwi0T/
c8/sQBKMqsdp0ldobUUbZdoGUrvfS6SOXA7M3qcm14zAQb3u9/tS2M1ep2bi7OajRBCsvsEJaFoT
kibmHANfDsx1QAn4g7GoGsbDYfWgb/4abP5/Y9fS3DiOg+/zK1x76d1DV8dOOpG3qg+yJNts6xWJ
8mMuKnfiSrsmY6fsZLd7f/0CpGSTIuDkkIcASKJIkARB4OOJyL0jKL3hL7OuJ4XZVSJYdXRqO6KT
nMbQzVOjEVNfllEiDEI0mKnGOFE8mAmC3L6WWeYQYIFlbUW0ZBg+o1ouRCmZ8bUV9PqDISuA5lVd
LDGhjIzkA9tjaLZClIugbxJgHAu740BLc7pR24lg5DDGGQGWmIKfMiMPWyLfFc8i3da1+kaeYdz8
xUEemrQzwPtBlAorhlFTtLtPiglYAuQIEA9mRmWpreyO9lzxxdXsBvmlDfhXeYBU7y69a29gtMTU
VzBeZ8IKbPdsMRZGXRde/3ZolkgRuO4Bjd8fWh9Qzpi9w3K2oqABytnQi0WnseeYgSfkyhijsUKN
mWiULq1R6j72rzv+cKIRz614nkqnUVwiJhmdqC+WE2oTsByIzPpquOZbLVkVon/F1Ato4DJK61S4
Gzxy/9dm1ysU7ohr0Eg3ehHtyufN8dhDUA4wxXeff67/Pqwft3vrm1HpnSBS/YD1TqMptVA/p3sW
TK7cOGQWWFORM9UB6sp4JXKaXnI34Idw7kQwrphhDxetWVpmMdsgCCp4YbiIY5X0VsA/RGSwKMMU
wdlO2GxnZUKO08jQYi8/97vfVNYS2FOpG+sldi9vr6zJI9K8sjNrkFCPx5hbHHccLup51XFzeMYV
1pZAedJ3qyUCAqz9pul1XvrVkuWWQRGBki+tsDtaZvXt7tbrFv57tgIRuocqAVle5kfz9/hUxKmu
aCcW2rpzFq1UuNP521sKGGozGwPxxIH5b8aERp5k4tm7Ikv5rkgaLSSz2D2XRmYLf8EAkZ7ayFjG
ZArRohyY36aJF0KWtQA8MONwc5QA7kMwubHNe4N+/yr3GdgVJTIvYS7wGWiHVqFKKZgM30alsiqY
aqXkK0Yn+lm0PCjzWeF2QDTECrAKYKHNJYahWKX+OKo4XR8eFQCE+JL12v3+dqzD2G4z9x4ua+Fd
3VgNpMnwm20ALRFIbxDcMT47LZL7Bad4jUAgQD2oiVOxYU3d0R5NL3w6emniJ1G31HqY/Lk+rB8w
eceJ3p4b6+65rJsR38h2XRi0s8koDQamc7KuC63p3B6JuSvjbLU0t3oa9cAluoU1mdaCzWKkOc1I
i7ryC4n4EAS3qFJM7D6JdL9QCUVLCWtyKpMFjAyUAIr6WDrxoXmUje5rEKmmaNjfSyoTCbNZh16d
y5XhetL+cpbYhI0Pvp5CwxUcsZ0hF+dtWRgThZtHpMh9whjIE2FnbSUC7PA0pCyHRQMe2cP05471
JYNpmDFILAvoOGmY0YNmOi98mlNI2nSaRCnLCyWTdlVcD2/pmHU/B4MvYEpXZumKXtxPrLwDuGQ3
yhSP2UVQPGYPreGRuFPIU/t23UKkcxEyDnVkc554xeP3AZDN+emRR8GYtS1iJ3KHmFgajunNBGQW
3Pa2YvohB5aGbOEx04JmMpuBijlkQl2RmUzoL0ceV6HI42pM3efPuSjWZOHPmd4deHfXt7/qSc54
FNIy4Jl6v5Pnw+zWQDLS3ThnshBhuJgo5DAXFUyvIPKEXB8G8JPT3Q4UO4g7ACfNPkNAbzAQ4Ye5
oES5vROMRkz8ri9KJxuun5/Xx0/HXv/zf2EF2/vxZg9+bnriyRpK9rvt6/6AS2Rn0pkuEhszRhEQ
NIaZ0GHYL8raHwlZTaqiuig182TE5OG3IuO7vnf1lQkVaWRQ424GNOBhKzOX/U6KpiMyDX0mfkp/
s4YdxmBopyrVptvfm8ftmlIihbBTd+Y83Wjbp+0rTPjz7eNm3xsd9uvHh7UGSQ3d54Rzdxdlcli/
/Nw+HN2WO+WKRqEwU0VH5v91AD9jEcc2JErDQBQ+eILvMFR0+ygW1hIZ6IkfYC4RXYvAHynMncmU
7qP4AAQ8mEYxHl7CyUgRq3dLzqrEQoqiYJCDgJsndOQQ3rgaRQUbSwkCfsFsXAKrFLHwU/bjRFJK
ljmf+HZAlsGKbLwYIE2Z0R5YZT/sd914Jv/C5AtcGFpZHjtzIQ/nebZVfVi0sQW6MF9ipcoVN9lq
LlsP/OSFXGZKxAqKMlBvwTbzbFXQcxPwrjmrAZsxy8Iso8cgrXkxW/USE2J5zVJIqOx7RSErYg8w
2O+O++dN73F7fMGkYr3EcgcS0ExylQdLAtypz8aYoI9+POzdhAbr4U8DBlrOjtCnlgntYIdb4O4i
bgyGOIzD43FUUIUi2HWRSQeb73xDlpKJLUivvV+e8WZNUYe9qPqL90/75pgoBysjzibWdhJew4o9
rZYwxKW0+hgy3GBgiARxJQcDCwz4NLrWcRC2x0O5JkcXFr9E8HrXOoAZPuz6A6ZqJtH+znLkqgoQ
z5C008CYdixOZgU8Wqxoaqce4muc5XImo39jAdDpVmAn3+wQeOrYBM2gF/aTzk/ZHv9qS/mpBWDA
R07Wj0+bV8pbjI+d+OGE2MxKkuBLGaqFJWW0JYlr3yEkC2ERpNEC1tSh60VW8jZeBJLkYfv0ZNAE
KN1uO8IPpQxN+J2KkU+0ahT6Qe9zb3M47NHd87p5OAESHjb4HDQ9/ln45b8uAJ6oh3SfjGeq4Lkc
m16ASABWcpYMQF19wmmOYWnR7mm7I1zwmCAWpRPjwByUDp63m53pt1NwSCq49STjqK0OHhWZL1Hy
by3Z4BNt/+dA1czmLnTeGDHN9G6EdaaYHOhEsHPlaFK9xFwesp+fJASVBwHca/1Im6Af2HmTYuhD
wPyAnn5bqfbgGE7oRqE0UEPhd9v/Dpcs8BG8JxkpyOtz+YtIlFEBHLueTmS1KqPXeq2IyrcDrWaW
hOcXXKj170qAngPeq8Mlf+9kXA44Xha4zHasgA667NZIljjvOSlwJsXYQDZsCAptznzGfZVJKkgl
PD3g7BKpZMa9T/NuOgUc47bA2O3FOnzxC6I7YDdxeokos+Ht7ZWl1d+zWNjIe3+CGFmYKhxbt+J1
Gp+yL8Os/DL25Rewjsi3A8+6PSnhDosy74rg9ekYKrCsEIn52831HcUXWTBFcGH57R/b497zvg4/
9w2QtFQ6daxD5o6bt8e9gkp0SnxOLzUJM9vxq2ink+raqRxhac+XMsntFlSEd5R9WsHcF48YnW64
CpyaaCt13p6VR6r+0HWAyB6b5+f1brN/O3aq4qymId/5/DHPm15kYbQexx5F/K0jnuXe1VaBUynz
CwPKNOd59+nyhufiwZEcr6JboI1NVbNb2dXD1Bm0kTKno/UVi3ZeI0uDrpJxSsAOOy8JO28xOTIw
dmjUOanmXIkmr9kF8N0aoMfoJVVa2GBRcAnzYz0py3pWjGgnqyFT5rOEroUyGXFNEAiGkQY5e08G
ayRW+VlNGHYf+EeDq/W6Veae/P1i26O5X0jMDkwvIUXqgfMk2o6/KdhP/9n04vXu6W39tHFxrPVY
fb5oh05rwDTY7Yhbw4hr6YXJu7um/X220B3dlJaQ95V2anSEaI9RR+hDr/tAwT0Gl6ojRPsSOkIf
Kfgt06dtIaZ320IfqQImo6gjRIdTWkLD6w88afiRBh4yyYS20M0HyuTd8fUEJg4qfE37s6zH9Acf
KTZI8Urgl4Eg49uNkvS7Paxl8NXRSvA600q8XxG8trQSfAO3Enx/aiX4VjtVw/sf03//a5jtORSZ
ZcKrmVC6lk1vliC7kmNLZZrNg+PrYfvjDY8sjxF8T8PCWyCNYewuZcUO7jsjk5Ehc0U2FjHnX58B
e0Tgt870ueg/1w82Urc+rlwU9+PYn5TGueXG+/BIY7U1Ry2JFbZtnVSl1KtFy4uIrlq0fYp74tYq
xcA4zHgeZXHnLFrczeGMsAjBNC+tTdVRPOw6WHP1dzeln/txFZnHDOgC6KPHaVcfnufYHB3V//qH
dRv8zKNilJkRZZFfxCvndGg8dmAsUjzcKG+scZuZ5OpwFCO3I6ugwHqKbhFuNg/6bHUCXn0WccAU
hMdB33j4/fK6f9I7V9QjNTCi6xzb/jisD797h/3b63ZnoUwKiQip1mcERVAHgZDSjDEGIulYBfr1
wDArxUhRAiMxAs85d7Hk/gRRdE3gOTnG4qw5sbVVhyzx89o+06pFdoDFI9jG96XLwXNUVU9zWXmk
YqrsowbUcX/dwwan0r5GMM/m9CWbgUelIzK9CTs7UzFN6rRa9DL8H8s7LCc0gQAA
------=_Part_13538_22559348.1177589052500--


