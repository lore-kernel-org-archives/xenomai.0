Message-ID: <64079ce9-c264-055f-7911-7a24144f4a15@siemens.com>
Date: Thu, 2 Jun 2022 11:54:10 +0200
MIME-Version: 1.0
Subject: Re: [Cobalt Xenoami3.1 PATCH 0/2] notify Xenomai udpated clockfreq.
Content-Language: en-US
References: <20220527062203.9498-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220527062203.9498-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 27.05.22 08:22, Hongzhan Chen via Xenomai wrote:
> When there is refined tsc clock, notify Xenomai to apply it.
> Linux may schedule a delayed work to refine tsc clock and update
> tsc_khz which happen after Xenomai finsih init but tsc_scale and
> tsc_shift still keep the value depending on origianl tsc clock
> which is outdated. The difference between two clocks may cause
> timing issue.
> 
> For example:
>   [ 0.001731] tsc: Detected 2899.886 MHz TSC
>   [ 5.588387] tsc: Refined TSC clocksource calibration: 2903.999 MHz
>   cat /sys/module/xenomai/parameters/clockfreq
>   2899886000
>   After patching, we like to use 2903.999 MHz.
> 
> The patchset includes IPIPE patch and cobalt-patch.
> 

Sounds reasonable, but you could help me with reviewing this by already
answering:

 - How does dovetail (and xenomai 3.2 or evl) address this?
 - Why is this tagged "3.1" only?
 - Which I-pipe series is this targeting (5.4, or also 4.19)?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

