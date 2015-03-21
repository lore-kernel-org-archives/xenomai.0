Date: Sat, 21 Mar 2015 14:21:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150321132130.GC20203@hermes.click-hack.org>
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150321131111.GA20203@hermes.click-hack.org>
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: xenomai@xenomai.org

On Sat, Mar 21, 2015 at 02:11:11PM +0100, Gilles Chanteperdrix wrote:
> On Fri, Mar 20, 2015 at 05:06:36PM -0700, Hongfei Cheng wrote:
> > Gilles - Thank you for sharing the link and updating us with your schedule.
> > 
> > I just started to port the I-pipe and Xenomai-3 code for supporting
> > the ARMv8 architecture. Based on my limited understanding of Xenomai,
> > it appears that the following changes are required in order to get
> > Xenomai-3 running on the ARMv8 SoC we plan to use (Qualcomm msm8994):
> > 
> > 1). In vendor kernel tree, add I-pipe support to arm64 generic arch
> > code: arch/arm64/boot, arch/arm64/kernel, etc.
> > 2). In vendor kernel tree, add I-pipe support to arm64 MMU: arch/arm64/mm
> > 3). In vendor kernel tree, add I-pipe support to platform-specific
> > device tree: arm(64)/boot/dts/qcom
> > 4). In vendor kernel tree, add I-pipe support to SoC and platform
> > dependent drivers for arm64: drivers/gpio, drivers/irqchip(?),
> > drivers/clocksource(?)
> > 5). In xenomai-3 tree, support arm64 in Cobalt kernel: kernel/cobalt/arch/arm64
> > 
> > Do you (and anyone else who's working on ARMv8) see any critical
> > modules missing from my list?
> 
> No, but the contrary, there is no reason to touch boot, kernel, mm.

Also, I would do things step by step. First get irq interception
working, then timer interception, at that point I would test with
rtdm kernel tasks only (without CONFIG_SMP). Then add CONFIG_SMP and
get SMP specific stuff working, like IPI interception working, test
with rtdm tasks again, testing on the various cores. Then finally
add fault/syscall interception, and test with default latency test.

I would use xenomai 3.x for testing, it will avoid quite a few
complicated things (kernel-space tasks without task_struct, hybrid
context switch), and we could leave it at that and decide that
xenomai 2.6 will never support armv8.

-- 
					    Gilles.

