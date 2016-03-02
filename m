From: Alexander Syring <xenomai@asyring.de>
Date: Wed, 02 Mar 2016 15:50:18 +0100
Message-ID: <3385442.a3NuqbveQI@alex-xw9400>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] Portation of Allwinner A20 to Ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello 

I've read the FAQ to port to new SoC but I don't know where to start with the 
timers.

The A20 uses this drivers as I can see from the dts:

[..]
	timer {
		compatible = "arm,armv7-timer";
		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
	};
[...]
		timer@01c20c00 {
			compatible = "allwinner,sun4i-a10-timer";
			reg = <0x01c20c00 0x90>;
			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&osc24M>;
		};
[...]
		hstimer@01c60000 {
			compatible = "allwinner,sun7i-a20-hstimer";
			reg = <0x01c60000 0x1000>;
			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&ahb_gates 28>;
		};
[...]

So I found these drivers for the compatible tag
arm,armv7-timer : drivers/clocksource/arm_arch_timer.c (with ipipe enabled)
allwinner,sun4i-a10-timer : drivers/clocksource/sun4i_timer.c (no ipipe)
allwinner,sun7i-a20-hstimer : drivers/clocksource/timer-sun5i.c (no ipipe)

Can someone give me a hint in which file I have to change something or wihich 
file is the main file to do something?

Regards
Alex

