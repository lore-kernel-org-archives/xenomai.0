Message-ID: <50BD0343.7000000@xenomai.org>
Date: Mon, 03 Dec 2012 20:53:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E715748DB106B94DAE5D77B7F3D1DC4101BB100291@CIPL-MAIL.in.canon-asia.com>
	<50B8BEAA.607@xenomai.org>
	<E715748DB106B94DAE5D77B7F3D1DC4101BB100298@CIPL-MAIL.in.canon-asia.com>
In-Reply-To: <E715748DB106B94DAE5D77B7F3D1DC4101BB100298@CIPL-MAIL.in.canon-asia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with bringing up Xenomai User Space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dharma R Bhushan <Dharma.Bhushan@sdc.canon.co.in>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/03/2012 05:16 PM, Dharma R Bhushan wrote:
> Gilles wrote:

>> If the toolchain is a linaro toolchain (...), you absolutely
>> need CONFIG_ARM_ERRATA_430973 enabled in the kernel configuration,

>

> I am using code-sourcery tool chain.

> (...)

> I have tried with CONFIG_ARM_ERRATA_430973 enabled. No success.


Please stop top posting. No surprise if you read carefully my answer.

The problem probably comes from your configuration, a simple look at it
shows that you have some options enabled which should be disabled, and
it is documentd, namely CONFIG_CPU_FREQ.

Please also try disabling:
- CONFIG_ARCH_OMAP2
- CONFIG_PERF_EVENTS
- CONFIG_KPROBES
- CONFIG_FTRACE
- CONFIG_PM_SLEEP

Could you post the boot logs if this still fails?

-- 
                                                                Gilles.

