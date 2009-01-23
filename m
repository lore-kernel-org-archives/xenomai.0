Message-ID: <4979F92A.70702@domain.hid>
Date: Fri, 23 Jan 2009 18:06:50 +0100
From: Federico Ridolfo <federico.ridolfo@domain.hid>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49799B02.1010202@domain.hid>
In-Reply-To: <49799B02.1010202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: federico.ridolfo@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Ok, i'm debugging the problem, but i have not a solution.
I compiled the kernel with the debug switch for irq.c.
In addition i added the mpc52xx_psc_spi module in my
.config.
So, now i'm sure that the irq used in mpc52xx_psc_spi
for the PSC3 is 131 and for PSC6 is 132:

# dmesg
mpc52xx-psc-spi f0002400.spi: probe called without platform data, no
(de)activate_cs function will be called
irq: irq_create_mapping(0xc041d2a0, 0x84)
irq: -> using host @c041d2a0
irq: -> obtained virq 132

I'm using the same irqs for my rtdm spi driver, but it doesn=ECt work.
If i reboot the board and try my rtdm driver, the result is -ENODEV

If i "modprobe  mpc52xx_psc_spi"  and retry my rtdm driver -> the board
hangs for ever.
I have the same result  also if i "rrmod mpc52xx_psc_spi" before.
My dts is:
/dts-v1/;

/ {
    model =3D "colgp,cirneco5200";
    compatible =3D "colgp,cirneco5200";
    #address-cells =3D <1>;
    #size-cells =3D <1>;

    cpus {
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        PowerPC,5200@domain.hid {
            device_type =3D "cpu";
            reg =3D <0>;
            d-cache-line-size =3D <32>;
            i-cache-line-size =3D <32>;
            d-cache-size =3D <0x4000>;    // L1, 16K
            i-cache-size =3D <0x4000>;    // L1, 16K
            timebase-frequency =3D <0>;    // from bootloader
            bus-frequency =3D <0>;        // from bootloader
            clock-frequency =3D <0>;        // from bootloader
        };
    };

    memory {
        device_type =3D "memory";
        reg =3D <0x00000000 0x04000000>;    // 64MB
        //reg =3D <0x00000000 0x08000000>;    // 64MB
        //reg =3D <0x00000000 0x10000000>;    // 256MB
    };

    soc5200@domain.hid {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        compatible =3D "fsl,mpc5200b-immr";
        ranges =3D <0 0xf0000000 0x0000c000>;
        reg =3D <0xf0000000 0x00000100>;
        bus-frequency =3D <0>;        // from bootloader
        system-frequency =3D <0>;        // from bootloader

        cdm@domain.hid {
            compatible =3D "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
            reg =3D <0x200 0x38>;
        };

        mpc5200_pic: interrupt-controller@domain.hid {
            // 5200 interrupts are encoded into two levels;
            interrupt-controller;
            #interrupt-cells =3D <3>;
            device_type =3D "interrupt-controller";
            compatible =3D "fsl,mpc5200b-pic","fsl,mpc5200-pic";
            reg =3D <0x500 0x80>;
        };

        // General Purpose Timer
        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <0>;
            reg =3D <0x600 0x10>;
            interrupts =3D <1 9 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            fsl,has-wdt;
        };

        timer@domain.hid {  =20
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <1>;
            reg =3D <0x610 0x10>;
            interrupts =3D <1 10 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <2>;
            reg =3D <0x620 0x10>;
            interrupts =3D <1 11 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <3>;
            reg =3D <0x630 0x10>;
            interrupts =3D <1 12 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <4>;
            reg =3D <0x640 0x10>;
            interrupts =3D <1 13 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <5>;
            reg =3D <0x650 0x10>;
            interrupts =3D <1 14 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <6>;
            reg =3D <0x660 0x10>;
            interrupts =3D <1 15 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        timer@domain.hid {
            compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index =3D <7>;
            reg =3D <0x670 0x10>;
            interrupts =3D <1 16 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        rtc@domain.hid {    // Real time clock
            compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
            device_type =3D "rtc";
            reg =3D <0x800 0x100>;
            interrupts =3D <1 5 0 1 6 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        can@domain.hid {
            compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
            cell-index =3D <0>;
            interrupts =3D <2 17 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            reg =3D <0x900 0x80>;
        };

        can@domain.hid {
            compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
            cell-index =3D <1>;
            interrupts =3D <2 18 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            reg =3D <0x980 0x80>;
        };
      =20
        gpio@domain.hid {
            compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
            reg =3D <0xb00 0x40>;
            interrupts =3D <1 7 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        gpio@domain.hid {
            compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wku=
p";
            reg =3D <0xc00 0x40>;
            interrupts =3D <1 8 0 0 3 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        spi@domain.hid {
            compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
            reg =3D <0xf00 0x20>;
            interrupts =3D <2 13 0 2 14 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        usb@domain.hid {
            compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-b=
e";
            reg =3D <0x1000 0xff>;
            interrupts =3D <2 6 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        dma-controller@domain.hid {
            device_type =3D "dma-controller";
            compatible =3D "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm"=
;
            reg =3D <0x1200 0x80>;
            interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
                          3 4 0  3 5 0  3 6 0  3 7 0
                          3 8 0  3 9 0  3 10 0  3 11 0
                          3 12 0  3 13 0  3 14 0  3 15 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        xlb@domain.hid {
            compatible =3D "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
            reg =3D <0x1f00 0x100>;
        };

        serial@domain.hid {        // PSC1
            device_type =3D "serial";
            compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart"=
;
            port-number =3D <0>;  // Logical port assignment
            cell-index =3D <0>;
            reg =3D <0x2000 0x100>;
            interrupts =3D <2 1 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        serial@domain.hid {        // PSC2
            device_type =3D "serial";
            compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart"=
;
            cell-index =3D <1>;
            port-number =3D <1>;
            reg =3D <0x2200 0x100>;
            interrupts =3D <2 2 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

      =20
        spi@domain.hid {        // PSC3 in spi mode
            compatible =3D "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
            cell-index =3D <2>;
            port-number =3D <2>;
            reg =3D <0x2400 0x100>;
            interrupts =3D <2 3 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        // PSC3 in CODEC mode example
        //i2s@domain.hid {        // PSC3
        //    compatible =3D "fsl,mpc5200b-psc-i2s"; //not 5200 compatibl=
e
        //    cell-index =3D <2>;
        //    reg =3D <0x2400 0x100>;
        //    interrupts =3D <2 3 0>;
        //    interrupt-parent =3D <&mpc5200_pic>;
        //};
  =20
        //serial@domain.hid {        // PSC3
        //    device_type =3D "serial";
        //    compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uar=
t";
        //    cell-index =3D <2>;
        //    reg =3D <0x2400 0x100>;
        //    interrupts =3D <2 3 0>;
        //    interrupt-parent =3D <&mpc5200_pic>;
        //};

        serial@domain.hid {        // PSC4 uart
            device_type =3D "serial";
            compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart"=
;
            cell-index =3D <3>;
            port-number =3D <3>;
            reg =3D <0x2600 0x100>;
            interrupts =3D <2 11 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        serial@domain.hid {        // PSC5 uart
            device_type =3D "serial";
            compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart"=
;
            cell-index =3D <4>;
            port-number =3D <4>;
            reg =3D <0x2800 0x100>;
            interrupts =3D <2 12 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        // PSC6 in spi mode example
        spi@domain.hid {        // PSC6
            compatible =3D "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
            cell-index =3D <5>;
            port-number =3D <5>;
            reg =3D <0x2c00 0x100>;
            interrupts =3D <2 4 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

      =20
        //serial@domain.hid { // PSC6 in UART mode
        //    device_type =3D "serial";
        //    compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uar=
t";
        //    cell-index =3D <5>;
        //    port-number =3D <5>;
        //    reg =3D <0x2c00 0x100>;
        //    interrupts =3D <2 4 0>;
        //    interrupt-parent =3D <&mpc5200_pic>;
        //};


        ethernet@domain.hid {
            device_type =3D "network";
            compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
            reg =3D <0x3000 0x400>;
            local-mac-address =3D [ 00 00 00 00 00 00 ];
            interrupts =3D <2 5 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            phy-handle =3D <&phy0>;
        };

        mdio@domain.hid {
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            compatible =3D "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
            reg =3D <0x3000 0x400>;    // fec range, since we need to
setup fec interrupts
            interrupts =3D <2 5 0>;    // these are for "mii command
finished", not link changes & co.
            interrupt-parent =3D <&mpc5200_pic>;

            phy0: ethernet-phy@domain.hid {
                device_type =3D "ethernet-phy";
                reg =3D <0>;
            };
        };

        ata@domain.hid {
            device_type =3D "ata";
            compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
            reg =3D <0x3a00 0x100>;
            interrupts =3D <2 7 0>;
            interrupt-parent =3D <&mpc5200_pic>;
        };

        i2c@domain.hid {
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c"=
;
            cell-index =3D <0>;
            reg =3D <0x3d00 0x40>;
            interrupts =3D <2 15 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            fsl5200-clocking;
        };

        i2c@domain.hid {
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c"=
;
            cell-index =3D <1>;
            reg =3D <0x3d40 0x40>;
            interrupts =3D <2 16 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            fsl5200-clocking;
            rtc@domain.hid {
                device_type =3D "rtc";
                compatible =3D "epson,pcf8563";
                reg =3D <0x51>;
            };
        };
        sram@domain.hid {
            compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
            reg =3D <0x8000 0x4000>;
        };
    };

    pci@domain.hid {
        #interrupt-cells =3D <1>;
        #size-cells =3D <2>;
        #address-cells =3D <3>;
        device_type =3D "pci";
        compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
        reg =3D <0xf0000d00 0x100>;
        interrupt-map-mask =3D <0xf800 0 0 7>;
        interrupt-map =3D <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
                 0xc000 0 0 2 &mpc5200_pic 1 1 3
                 0xc000 0 0 3 &mpc5200_pic 1 2 3
                 0xc000 0 0 4 &mpc5200_pic 1 3 3

                 0xc800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
                 0xc800 0 0 2 &mpc5200_pic 1 2 3
                 0xc800 0 0 3 &mpc5200_pic 1 3 3
                 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
        clock-frequency =3D <0>; // From boot loader
        interrupts =3D <2 8 0 2 9 0 2 10 0>;
        interrupt-parent =3D <&mpc5200_pic>;
        bus-range =3D <0 0>;
        ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
              0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
              0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
    };
};

Ideas? Thanks for your help

Philippe Gerum wrote:
> Federico Ridolfo wrote:
>  =20
>> Hi all,
>> my platform is a mpc5200b based one. I wrote
>> some rtdm driver for that platform on linux-2.6.18
>> kernel. Some info:
>> - ARCH=3Dppc
>> - no fdt (so no dts)
>> - u-boot
>> - xenomai 2.3.2,
>> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
>> All works fine.
>>
>> Now i want to use:
>> - ARCH =3D powerpc
>> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
>> - fdt (so i have a dts file)
>> - xenomai-2.4.6.1
>> - u-boot
>> Ok. My board boots, all peripheral s work. Xenomai works, but
>> my rtdm drivers don't work. The problem is that the rtdm_irq_request
>> returns -ENODEV coming from line 166 in wrappers.h:
>> ...
>> #else /* > 2.6.19 */
>> #define rthal_irq_chip_enable(irq)                    \
>>     ({                                \
>>         int __err__ =3D 0;                    \
>>         if (unlikely(rthal_irq_handlerp(irq)->unmask =3D=3D NULL))    =
\
>>             __err__ =3D -ENODEV;     \
>>         else                            \
>>             rthal_irq_handlerp(irq)->unmask(irq);        \
>>         __err__;                        \
>>     })
>> ...
>> Seems that adeos doesn't not set the unmask function. In the linux ker=
nel
>> the right functions for my pic in in
>> arch/powerpc/platforms/52xx/mpc52xx_pic.c
>> I thing i have to add some code in mpc52xx_pic.c in order to match
>> device tree table
>>    =20
>
> To complete my previous answer: unless you have a very particular hw de=
sign, it
> is unlikely that the PIC code is missing anything to support your board.
>
>  =20
>> and also something in my dts file.
>>    =20
>
> However, a too generic device tree description may not reflect all the
> peripherals you have on your board, so yes, updating it may be needed s=
o that
> the platform code maps the hw interrupt sources you want.
>
> I suspect you will have no regular drivers on these IRQs, so /proc/inte=
rrupts
> should not list them.
>
> The point is: are those interrupts sources known from the kernel? Enabl=
ing the
> debug switch in arch/powerpc/kernel/irq.c should give you some hints ab=
out which
> hw IRQ sources are actually enumerated then mapped on your board (remem=
ber to
> increase the console_loglevel or set ignore_loglevel to get this ouput)=
. If you
> don't find those you need, then you will likely want to fix the dts fil=
e.
>
>  Any help is very usefull!!!
>  =20
>> Thanks
>>
>>
>> --
>> chicco
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>    =20
>
>
>  =20



