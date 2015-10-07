References: <56139C8B.3060509@control.lth.se>
 <20151006192323.GB30765@hermes.click-hack.org>
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <5614C8E3.5090809@sigmatek.at>
Date: Wed, 7 Oct 2015 09:25:23 +0200
MIME-Version: 1.0
In-Reply-To: <20151006192323.GB30765@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems disabling SMI interrupts on MSI H87-G43
 motherboard
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Am 06.10.2015 um 21:23 schrieb Gilles Chanteperdrix:
> On Tue, Oct 06, 2015 at 12:03:55PM +0200, Anders Blomdell wrote:
>> Hi
>>
>> I have problems disabling SMI-interrupts on "MSI H87-G43 motherboard" (http://www.msi.com/product/mb/H87-G43.html)
>>
>> This is what msi.c says at bootup (after attached patch is applied):
>>
>>    kernel: [Xenomai] SMI workaround failed! (1830: 1 & ~1 -> 1)
>>
>> and this is what lspci says:
>>
>>
>> Anybody who has a good idea how to fix this?
> You should first check that the way smi.c retrieves the address of
> the SMI_EN register is still valid for your chipset. If it is, then
> try fiddling with the BIOS settings to see if some setting can
> disable generation of SMIs. If unsuccessful, you can try contacting
> the motherboard support to see if they have any advice.
>
On new Mainboards, you can't disable SMI.
Because this is a security problem, so SMI is locked by BIOS.
There are some registery on the mainboard chipset, hat lock the SMI 
register.
So you can't disable the SMI.
We also had this trouble, and we get a own BIOS with disabled SMI.

Regards
   Johann

