Message-ID: <53341923.3050401@xenomai.org>
Date: Thu, 27 Mar 2014 13:27:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
 <5332BF1F.3000504@xenomai.org>
 <76a8b1fe.2477d.144fe96fb16.Coremail.ericvic@163.com>
 <5332D759.7010806@xenomai.org>
 <23d0b1ec.250da.144fecc28e4.Coremail.ericvic@163.com>
 <53335E2F.4040608@xenomai.org>
 <594fd0f5.8241.14501ff6aba.Coremail.ericvic@163.com>
In-Reply-To: <594fd0f5.8241.14501ff6aba.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai  ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/27/2014 06:24 AM, 嵌入式工程师 wrote:
> I do as you said ,the result is the matter still has ,but when i change  
> 
> UIMAGE  arch/arm/boot/uImage
> Image Name:   Linux-3.0.43-ge13355f
> Created:      Thu Mar 27 11:07:59 2014
> Image Type:   ARM Linux Kernel Image (uncompressed)
> Data Size:    3448764 Bytes = 3367.93 kB = 3.29 MB
> Load Address: 10008000
> Entry Point:  10008000
>   Image arch/arm/boot/uImage is ready
> 
> 
> CONFIG_SMP=y
> CONFIG_SMP_ON_UP=y
> to 
> CONFIG_SMP=n
> CONFIG_SMP_ON_UP=n
> CONFIG_BROKEN_ON_SMP=y
> the up-kernal start  and latency start  and do my program

Turning off SMP improves latency, that is a general rule, for all
processors. The problem is that if you do that you do not take advantage
of all the cores your processor has. The question is: what latency did
you have with the correct branch? If it is, say, less than 80us, it is a
bit high but may still be normal. If it is 300us, then you may still
have a problem, it depends on the answer you give to the questions I
asked about your usage of rt_pipes.

To be sure that you are running the kernel I expect, could you show us
the boot logs?

Regards.

-- 
                                                                Gilles.

