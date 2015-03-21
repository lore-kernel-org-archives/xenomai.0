MIME-Version: 1.0
In-Reply-To: <20150320181308.GA27775@hermes.click-hack.org>
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
Date: Fri, 20 Mar 2015 17:06:36 -0700
Message-ID: <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles - Thank you for sharing the link and updating us with your schedule.

I just started to port the I-pipe and Xenomai-3 code for supporting
the ARMv8 architecture. Based on my limited understanding of Xenomai,
it appears that the following changes are required in order to get
Xenomai-3 running on the ARMv8 SoC we plan to use (Qualcomm msm8994):

1). In vendor kernel tree, add I-pipe support to arm64 generic arch
code: arch/arm64/boot, arch/arm64/kernel, etc.
2). In vendor kernel tree, add I-pipe support to arm64 MMU: arch/arm64/mm
3). In vendor kernel tree, add I-pipe support to platform-specific
device tree: arm(64)/boot/dts/qcom
4). In vendor kernel tree, add I-pipe support to SoC and platform
dependent drivers for arm64: drivers/gpio, drivers/irqchip(?),
drivers/clocksource(?)
5). In xenomai-3 tree, support arm64 in Cobalt kernel: kernel/cobalt/arch/arm64

Do you (and anyone else who's working on ARMv8) see any critical
modules missing from my list?

Thanks!
Hongfei

On Fri, Mar 20, 2015 at 11:13 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Fri, Mar 20, 2015 at 09:45:59AM -0700, Hongfei Cheng wrote:
>> Gilles,
>>
>> Do you mind to share the maker of the ARMv8 board which you are
>> working on, as indicated in the posting below?
>
> https://www.96boards.org/products/hikey/
>
> But I have not started working on it, and will not start before a
> few weeks.
>
> --
>                                             Gilles.

