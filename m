Message-ID: <5549D04C.1060501@sigmatek.at>
Date: Wed, 06 May 2015 10:26:52 +0200
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
MIME-Version: 1.0
References: <5548A805.60401@sigmatek.at>
 <049c19b3633199cac11cca95cdff99ad@grandegger.com>
In-Reply-To: <049c19b3633199cac11cca95cdff99ad@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Flexcan RT driver registration failed
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wg@grandegger.com
Cc: xenomai@xenomai.org

Dear Wolfgang,

thank you for your fast replay.

I'm sure my problems are not from setting the pin configuration, because 
I tested configuration also with the default settings.

My issue is that the clock rate is set to 66000000 instead of 30000000 
and that can_serial_clock in register CCM_CCG0 is disabled.

Do you hava any idea how to activate the serial_clock for can.
I cant find anything in other devicetree files.

Kind regards
Wolfgang

Am 2015-05-05 um 15:32 schrieb Wolfgang Grandegger:
> On Tue, 05 May 2015 13:22:45 +0200, Wolfgang Netbal
> <wolfgang.netbal@sigmatek.at> wrote:
>> Dear All,
>>
>> I have a custom board with an imx6dl using freescale yocto 3.10.53 with
>> Xenomai 2.6.4.
>> The probe function works fine while booting the kernel
>>
>> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>> rtcan: registered rtcan0
>> flexcan 2090000.can: RTCAN device registered (reg_base=d0c00000,
>> irq=142, clock=66000000)
>> rtcan: registered rtcan1
>> flexcan 2094000.can: RTCAN device registered (reg_base=d0c08000,
>> irq=143, clock=66000000)
>>
>> After Linux started I call the function flexcan_mode_start() and get the
>> following message and CAN connections doesn't work.
>>
>> rtcan0: Failed to softreset can module (mcr=0x5b80000f)
>>
>> I have a working configuration for this board using Kernel 3.0.43 and
>> Xenomai 2.6.2.1
>>
>> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>> flexcan netdevice driver
>> rtcan: registered rtcan0
>> flexcan imx6q-flexcan.0: RTCAN device registered (reg_base=e0968000,
>> irq=142, clock=30000000)
>> rtcan: registered rtcan1
>> flexcan imx6q-flexcan.1: RTCAN device registered (reg_base=e0970000,
>> irq=143, clock=30000000)
>> ...
>> rtcan0: writing ctrl=0x03292005
>>
>> It seems that the clock is the difference so I checked the values of
>> register CCM_CCGR0
>> 3.0.43 address 0x20C4068 is set to 0x7fc03f
>> 3.10.53 address 0x20C4068 is set to 0x4cc00f
>>
>> so on kernel 3.10.53 are the serial clocks for can disabled.
>>
>> If anyone has a hint for me how to activate the serial clock in register
>> CCM_CCGR0 and change the clock to 30000000 that would be great.
> Have a look into the directory "arch/arm/boot/dts" of a recent kernel tree
> and execute therein "grep LEXCAN[12] *.dts*". There are various boards
> setting the pins you mention below. Maybe you find some matching hardware.
>
>> Here is the part of the devicetree used to configure flexcan.
>>
>>
>> #include "imx6dl.dtsi"
>>
>> / {
>>
>> };
>>
>> /*
>>    * PAD settings
>>    */
>> &iomuxc {
>>       flexcan1 {
>>           pinctrl_flexcan1_sigmatek: flexcan1grp-sigmatek {
>>               fsl,pins = <
>>                   MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX NO_PAD_CTRL
>>                   MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX NO_PAD_CTRL
>>               >;
>>           };
>>       };
>>
>>       flexcan2 {
>>           pinctrl_flexcan2_sigmatek: flexcan2grp-sigmatek {
>>               fsl,pins = <
>>                   MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX NO_PAD_CTRL
>>                   MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX NO_PAD_CTRL
>>               >;
>>           };
>>       };
>> };
>>
>> /*
>>    * CAN
>>    */
>> &flexcan1 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_flexcan1_sigmatek>;
>>       status = "okay";
>> };
>>
>> &flexcan2 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_flexcan2_sigmatek>;
>>       status = "okay";
>> };
> Hope that already helps.
>
> Wolfgang
>


