MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Wed, 06 May 2015 16:33:50 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <554A2236.5010405@sigmatek.at>
References: <5548A805.60401@sigmatek.at>
 <049c19b3633199cac11cca95cdff99ad@grandegger.com>
 <5549D04C.1060501@sigmatek.at>
 <cdbbfcd38f779f62c8f54fffcaefa26d@grandegger.com>
 <554A2236.5010405@sigmatek.at>
Message-ID: <a5c324c4deaa2975895a9bf6c92a24d8@grandegger.com>
Subject: Re: [Xenomai] Flexcan RT driver registration failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wolfgang.netbal@sigmatek.at
Cc: xenomai@xenomai.org

On Wed, 06 May 2015 16:16:22 +0200, Wolfgang Netbal
<wolfgang.netbal@sigmatek.at> wrote:
> Am 2015-05-06 um 10:51 schrieb Wolfgang Grandegger:
> 
> On Wed, 06 May 2015 10:26:52 +0200, Wolfgang Netbal
>  [1] wrote:
> 
> Dear Wolfgang,
> 
> thank you for your fast replay.
> 
> I'm sure my problems are not from setting the pin configuration, because
> 
> I tested configuration also with the default settings.
> 
> My issue is that the clock rate is set to 66000000 instead of 30000000 
> and that can_serial_clock in register CCM_CCG0 is disabled.
> 
> Do you hava any idea how to activate the serial_clock for can.
> I cant find anything in other devicetree files.
> 
> Looking to the Flexcan function "register_flexcandev()" of the 3.10 
> mainline kernel here:
> 
>  http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c#L1083
[2]
> 
> I realize that the Xenomai kernel support of that driver is not
> correct. Could you please replace *all* "KERNEL_VERSION(3,11,0)" with
> "KERNEL_VERSION(3,10,0)" in your "rtcan_flexcan.c".
> 
>   I made a cherry-pick of commit "can/flexcan: fixup for kernel release
>>= 3.11" (a7b7adec9123dc60587d160f0818322a9a547630 [3]) from
> xenomai-2.6.git [4]
>  and replaced all "KERNEL_VERSION(3,11,0)" with "KERNEL_VERSION(3,10,0)"
> and it works.

I just checked... the proper kernel version switch should be >= 3.6.
I'm going to prepare a patch later this week.

Wolfgang.


