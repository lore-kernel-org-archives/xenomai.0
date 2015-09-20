Date: Sun, 20 Sep 2015 21:00:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150920190009.GE3486@hermes.click-hack.org>
References: <20150918074633.GA7301@hermes.click-hack.org>
 <CAFkYNwaBpwoC7rZBV4eRd7XEZ+c1GzNJZN9ZY_n9WO184A=pFQ@mail.gmail.com>
 <20150918122903.GC7301@hermes.click-hack.org>
 <CAFkYNwa+1ib=a+13PWYdNEwU35pvckchVwGa+Q8Ep7caSo7ioA@mail.gmail.com>
 <20150918124402.GD7301@hermes.click-hack.org>
 <CAFkYNwaSGcNOzKO=frN55CKj-RGSVixYMExRZqn4BaqOZ2PmzA@mail.gmail.com>
 <20150918130000.GG7301@hermes.click-hack.org>
 <CAFkYNwY9xwZ9iazzpgdg5854z-bwwLCsezFHj0TEiPRKrG8qCQ@mail.gmail.com>
 <CAFkYNwa_HaKmtTquOaMDQc_X5HOjXZGEJt1cQxVJhqfKO=nieQ@mail.gmail.com>
 <20150920175717.GB3486@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150920175717.GB3486@hermes.click-hack.org>
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Sun, Sep 20, 2015 at 07:57:17PM +0200, Gilles Chanteperdrix wrote:
> On Sat, Sep 19, 2015 at 01:16:17AM +1200, vibnwis wrote:
> > Hi Gilles,
> > Thank you so much. Finally, I got a working xenomai. Many thanks for the
> > help. Would this change be checked in?
> 
> I think the right change for omap4460 is to provide the global timer
> irq in the device tree. I have to read some documentation to find
> what that irq number is.

Following other device tree files, it seems the global timer irq is
the PPI 11. So, could you try the following patch instead of the
previous patch?

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2cb8144..e51b5e8 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -71,6 +71,7 @@
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x48240200 0x20>;
 		clocks = <&mpu_periphclk>;
+		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	/*


Regards.

-- 
					    Gilles.
https://click-hack.org

