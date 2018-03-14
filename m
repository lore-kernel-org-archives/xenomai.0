References: <0B8B4C90A6FEA34E9EA10570C016C358BB7C0839@DEMUC-SMX001.data-modul.local>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <57765855-6a4c-4651-70c8-528cc33607dc@xenomai.org>
Date: Wed, 14 Mar 2018 15:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7C0839@DEMUC-SMX001.data-modul.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency Peaks with Skylake vs. Haswell
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/13/2018 12:33 PM, Schrenkhammer, Martin wrote:
> I am currently porting a project from Haswell to Skylake (i5-6440EQ). When in desktop, I observe latency peaks when windows are moved around or zoomed. With Haswell CPUs, there is not impact of graphic workload. Unfortunately everything above 10us  is an issue in our real time system application.
> Currently I am using Xubuntu 16.04 + Kernel 4.9.51 + Xenomai 3.0.6
> I already disabled all power- and performance features like Hyper-Threading, SpeedStep, Turbo Mode, C-States in BIOS and also by kernel parameters. Also disabled i915 power savings like i915.enable_dc=0,  i915.enable_rc6=0, i915.enable_execlists=0... and disabled grafik turbo gt_max_freq_mhz = 350  gt_boost_freq_mhz = 350
> 
> One difference we see between Haswell and Skylake: i915 raises a lot of MSI when moving windows around where there are almost zero at Haswell.
> 
> Any ideas for bringing the peaks down?

Did you track which specific event the i915 driver was handling with
those MSIs?

> 
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     -0.368|     -0.210|      0.259|       0|     0|     -0.368|      0.259
> RTD|     -0.259|     -0.161|      1.601|       0|     0|     -0.368|      1.601
> RTD|     -0.290|     -0.174|      1.367|       0|     0|     -0.368|      1.601

This is unrelated to the issue at stake, but the core timer looks
slightly early (negative mins), which means that the expected intrinsic
latency value is too pessimistic/high. Running autotune may help in
picking better gravity values for this timer.

-- 
Philippe.

