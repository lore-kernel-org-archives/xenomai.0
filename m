Message-ID: <550FFE17.9020400@xenomai.org>
Date: Mon, 23 Mar 2015 07:50:47 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
In-Reply-To: <20150321132130.GC20203@hermes.click-hack.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/21/2015 09:21 AM, Gilles Chanteperdrix wrote:
> On Sat, Mar 21, 2015 at 02:11:11PM +0100, Gilles Chanteperdrix wrote:
>> On Fri, Mar 20, 2015 at 05:06:36PM -0700, Hongfei Cheng wrote:
>>> Gilles - Thank you for sharing the link and updating us with your schedule.
>>>
>>> I just started to port the I-pipe and Xenomai-3 code for supporting
>>> the ARMv8 architecture. Based on my limited understanding of Xenomai,
>>> it appears that the following changes are required in order to get
>>> Xenomai-3 running on the ARMv8 SoC we plan to use (Qualcomm msm8994):
>>>
>>> 1). In vendor kernel tree, add I-pipe support to arm64 generic arch
>>> code: arch/arm64/boot, arch/arm64/kernel, etc.
>>> 2). In vendor kernel tree, add I-pipe support to arm64 MMU: arch/arm64/mm
>>> 3). In vendor kernel tree, add I-pipe support to platform-specific
>>> device tree: arm(64)/boot/dts/qcom
>>> 4). In vendor kernel tree, add I-pipe support to SoC and platform
>>> dependent drivers for arm64: drivers/gpio, drivers/irqchip(?),
>>> drivers/clocksource(?)
>>> 5). In xenomai-3 tree, support arm64 in Cobalt kernel: kernel/cobalt/arch/ar
m64
>>>
>>> Do you (and anyone else who's working on ARMv8) see any critical
>>> modules missing from my list?
>>
>> No, but the contrary, there is no reason to touch boot, kernel, mm.
> 
> Also, I would do things step by step. First get irq interception
> working, then timer interception, at that point I would test with
> rtdm kernel tasks only (without CONFIG_SMP). Then add CONFIG_SMP and
> get SMP specific stuff working, like IPI interception working, test
> with rtdm tasks again, testing on the various cores. Then finally
> add fault/syscall interception, and test with default latency test.
> 
> I would use xenomai 3.x for testing, it will avoid quite a few
> complicated things (kernel-space tasks without task_struct, hybrid
> context switch), and we could leave it at that and decide that
> xenomai 2.6 will never support armv8.


the vendor tree for the 96Board platforms is hosted in github
https://github.com/96boards/linux

hikey and hikey-{feature} branches run 3.18 kernels.
hikey-mainline-rebase tracks mainline.

At the moment we mainly support HiKey but more boards will be coming rapidly
(one from Qualcomm before the summer)
HiKey runs Debian and Android - UEFI support is on going.

I will gladly create a Xenomai integration branch on the Hikey repo if it helps
the development.





> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVD/4XAAoJECDcy2IJkagRk0QH/3fId1BWLIr0ZSR8TB3OTF/L
+hz/JyI/48rKdPbOVn6Cxyi+oizbhOIjzZPGgufO/wpbia99UvOFHmWUkURiC2+6
B8uB3aAlgS/I6VUhV3miMYuZBbEUAc+m4+W3Ob5Nq+5YJWha5bSNNbMBfnwvB3Of
0EjkK/sLKa+lVtDRokmqA5bAejfLlYaWL87OcQU1s8sr326lsPn3ohDw5X7GwTsJ
VD2EiVFg5HnjX7dnt2YRzhsguopPsz40wO/WmHTkr4xrjR1+hgTQd+9VybUWn94K
QqLqbDGauCXQqgmZZf4Z/AI+REnW3hiooiPj9DxCU30XYR3K3rm1NHlCjnNenJQ=
=U2Tu
-----END PGP SIGNATURE-----

