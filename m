References: <56139C8B.3060509@control.lth.se>
 <20151006192323.GB30765@hermes.click-hack.org> <5614C8E3.5090809@sigmatek.at>
 <5614D22A.8030203@sigmatek.at>
From: Anders Blomdell <anders.blomdell@control.lth.se>
Message-ID: <5615108A.6070001@control.lth.se>
Date: Wed, 7 Oct 2015 14:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <5614D22A.8030203@sigmatek.at>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problems disabling SMI interrupts on MSI H87-G43
 motherboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, Xenomai@xenomai.org

On 2015-10-07 10:04, Johann Obermayr wrote:
> Am 07.10.2015 um 09:25 schrieb Johann Obermayr:
>> Am 06.10.2015 um 21:23 schrieb Gilles Chanteperdrix:
>>> On Tue, Oct 06, 2015 at 12:03:55PM +0200, Anders Blomdell wrote:
>>>> Hi
>>>>
>>>> I have problems disabling SMI-interrupts on "MSI H87-G43 motherboard" =
(http://www.msi.com/product/mb/H87-G43.html)
>>>>
>>>> This is what msi.c says at bootup (after attached patch is applied):
>>>>
>>>>    kernel: [Xenomai] SMI workaround failed! (1830: 1 & ~1 -> 1)
>>>>
>>>> and this is what lspci says:
>>>>
>>>>
>>>> Anybody who has a good idea how to fix this?
>>> You should first check that the way smi.c retrieves the address of
>>> the SMI_EN register is still valid for your chipset. If it is, then
>>> try fiddling with the BIOS settings to see if some setting can
>>> disable generation of SMIs. If unsuccessful, you can try contacting
>>> the motherboard support to see if they have any advice.
>>>
>> On new Mainboards, you can't disable SMI.
>> Because this is a security problem, so SMI is locked by BIOS.
>> There are some registery on the mainboard chipset, hat lock the SMI regi=
ster.
>> So you can't disable the SMI.
>> We also had this trouble, and we get a own BIOS with disabled SMI.
>>
>> Regards
>>   Johann
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://xenomai.org/mailman/listinfo/xenomai
>>
> Found this:
>=20
> GEN_PMCON_1=97General PM Configuration 1 Register (PM=97D31:F0)
> Offset Address: A0h Attribute: R/W, RO, R/WO
> Default Value: 0000h Size: 16-bit
> Lockable: No Usage: ACPI, Legacy
> Power Well: Core
>=20
> Bit 4: SMI_LOCK =97 R/WO. When this bit is set, writes to the GLB_SMI_EN =
bit (PMBASE
> + 30h, bit 0) will have no effect. Once the SMI_LOCK bit is set, writes o=
f 0 to
> SMI_LOCK bit will have no effect (that is, once set, this bit can only be=
 cleared by
> PLTRST#).
>=20

Thanks everybody, seems like I have to give up on that motherboard:

1. Nothing found to disable in the BIOS
2. Disabling all sourcecs with smictrl (git://git.kiszka.org/smictrl.git)
   still gives high latencies with RTNet (+1.5 milliseconds).=20
3. latency test does not show anything suspicious, so it might
   be some other issue.

Anybody that has a suggestion on a recent motherboard that has been used wi=
th
RTNet and showing good results?

Thanks everyone!

/Anders


--=20
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


