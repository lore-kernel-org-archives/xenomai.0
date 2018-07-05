References: <0DD381DBF8F68D419C32ACFCEB28EB2553ADA8AD@SHSMSX101.ccr.corp.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b4d410e-5e3d-dc1c-9744-273e1a4c7e28@siemens.com>
Date: Thu, 5 Jul 2018 08:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <0DD381DBF8F68D419C32ACFCEB28EB2553ADA8AD@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to locate the max latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zheng, Qi" <qi.zheng@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-07-03 10:59, Zheng, Qi wrote:
> I am using xenomai 3.0.5 (https://xenomai.org/downloads/xenomai/stable/xenomai-3.0.5.tar.bz2) on the Intel SKL platform.
> On console mode or accessed by vnc viewer (no i915 graphics interrupt), the max latency values are usually below 20us no matter low or high loading (by stress-ng).
> But the max latency can reach up to 40us on GUI (gnome)  mode (dozens of i915 interrupt counts per second).
> I tried enabling the ipipe trace function, but couldn't find valuable information.
> Is there any other good ways to locate the max latency?
> Or does anybody have experience on reducing the latency caused by graphics (such as i915) ?
> Many thanks.
>
First of all, how long did you run the tests? Maybe enabling graphics
just increases the probability to hit the peak, and the same is
conceptually possible without it.

It may also be the case that this is hardware-induced (GPU). Do you see
a similar increase in the latency (even if from a different ground
level) when using the PREEMPT-RT kernel?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

