Message-ID: <51DEF6FB.6080403@xenomai.org>
Date: Thu, 11 Jul 2013 20:18:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : No boot kernel with xenomai on i.MX6Q
 Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/11/2013 01:35 PM, Younes CHALABI wrote:

> Hi Gilles,
>
> Thanks for your answers.
>
> It seems that I have a kernel panic while the boot and the cpu cores shut down one after the other still the target doesn't respond, and any new display is shown.
>
> Using :
>
>       - Linux : rel_imx_3.0.15_12.03.00 (linux-3.0 Freescle Release)
>
>       - Patches :      1) adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
>                            2) adeos-ipipe-3.0.36-arm-1.18-11.patch
>                            3) adeos-ipipe-3.0.36-arm-1.18-11-post.patch


The important information about the kernel is its configuration. Please 
try compiling a kernel with a configuration which does not enable 
CONFIG_IPIPE and CONFIG_XENOMAI, when it boots, try enabling the 
options. The error you have does not seem to be related to Xenomai.
The first configuration to try would be imx6_defconfig, where you would 
disable CONFIG_CPU_IDLE.


-- 
                                                                 Gilles.

