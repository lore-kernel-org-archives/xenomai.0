Message-ID: <51C213E4.5050905@grandegger.com>
Date: Wed, 19 Jun 2013 22:26:12 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <50CB364C.70706@wanadoo.fr> <50CB561D.5070706@grandegger.com>
	<CANKLDmugXc4M08TYJaq0ON-Ls04=xk=6oh3dR0gLD0CPBxZjxg@mail.gmail.com>
	<51B0353B.7060206@grandegger.com>
In-Reply-To: <51B0353B.7060206@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Init issue with rtcan_flexcan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Thierry Bultel <thierry.bultel@wanadoo.fr>, xenomai@xenomai.org

Hi Henri,

On 06/06/2013 09:07 AM, Wolfgang Grandegger wrote:
> Hi Henri,
> 
> On 06/05/2013 09:15 AM, Henri Roosen wrote:
>> On Fri, Dec 14, 2012 at 5:38 PM, Wolfgang Grandegger <wg@grandegger.com>wrote:
>>
>>> On 12/14/2012 03:23 PM, Thierry Bultel wrote:
>>>> Hi,
>>>> some days ago I have posted a patch for the rtcan_flexcan to be
>>>> correctly probed on the iMX6q
>>>>
>>>> It is functional, but I have not tested it enough, I am sorry about that.
>>>> It only works if the linux flexcan driver module has been used once
>>> before.
>>>>
>>>> Else I have got IRQs but no packet go to the upper layer, I think it is
>>>> stuck in passive state, I am investigating on it.
>>>
>>> It would be nice if you could port the missing patches from the mainline
>>> Linux kernel to rtcan_flexcan.
>>>
>>
>> I have ported code from the mainline linux flexcan driver that fixes the
>> behavior described by Thierry. Please find attached:
>> 0001-make-rtcan_flexcan-driver-compatible-with-non-OpenFi.patch
>> 0002-Fix-rtcan_flexcan-for-mx6-for-OpenFirmware-platforms.patch
>>
>> The attached patches can be applied to the current mainline xenomai git
>> (anywhere after commit-3ddc61cda095a9ae51277608d7fd4e9c2c481625). They make
>> Thierry's patch obsolete.
>>
>> I have tested the rtcan_flexcan driver in the non-CONFIG_OF configuration
>> only. On a wandboard with iMX6Solo using the freescale 3.0 kernel. I only
>> compile tested the CONFIG_OF configuration for the current ipipe master
>> (3.8) because wandboard solo is not yet supported by OpenFirmware. It would
>> be great if someone could test the OF version.
> 
> Thanks for your contribution. Looks good at a first glance. Just need to
> check back- (and forward-) compatibility. I will also try to get access
> to boards using Flexcan. Hope to find some time over the WE.

So far I didn't get a chance to test you driver modifications. Anyway,
the patch looks good. Gilles, could you please add my

"Acked-by: Wolfgang Grandegger <wg@grandegger.com>"

and apply the patch, thanks.

Thanks for your contribution,

Wolfgang.

