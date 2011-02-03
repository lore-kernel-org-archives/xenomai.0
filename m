Message-ID: <4D4A84ED.7030604@domain.hid>
Date: Thu, 03 Feb 2011 11:35:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
In-Reply-To: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rudolf Meijering <rudolf@domain.hid>
Cc: xenomai@xenomai.org

On 2011-02-03 09:57, Rudolf Meijering wrote:
> Hi,
> 
> We are in the process of developing a non-tracking safety Radar and would
> really appreciate some guidance in selecting a real-time operating system
> especially with the aim of offloading processing to a GPU. Can anyone share
> their experience with real-time GPU offloading on either Xenomai or Realtime
> Linux (PREEMPT_RT patch)? I have read reports on 900us delays with Nvidia
> graphics drivers, has this been resolved?

The NVIDIA CUDA bits cause problems to any RT scenario when you trigger
DMA memory allocations/releases, thus mapping during runtime (wbinvd). I
can't tell you details, but my colleagues somehow solved this for our
non-RT GPU offloading tasks although we received no information which
APIs can trigger the problematic code paths (the binary blob is in the
loop so only NVIDIA can tell).

> 
> Background:
> The application basically requires the radar to output a disable
> signal, within 100ms, when an object is detected. Radar data is received
> every 1 ms and processed.
> 
> Platform: x86_64, most likely Intel i7 CPU
> Total processing latency: 100ms
> Interrupt frequency: 1KHz
> 
> From what I can read both Xenomai and Realtime Linux should easily meet
> these requirements, but what about RT GPU support?

Given the fact that the NVIDIA driver is neither designed nor properly
tested against PREEMPT-RT (you need extra hacks to make it work), I'm a
bit skeptical that you can expect any RT properties when trying to use
the GPU in time critical paths. No one (except maybe the vendor) knows
the timing of the GPU hardware and software bits under critical load
scenarios.

If "just" that 100 ms is the deadline and you measure over a long time
that your GPU tasks always complete much earlier, you may argue that
it's /probably/ safe. But if you need to certify this, well...

[ And, personally, I don't trust the NVIDIA driver a lot. But that might
be influenced by the fact that latest versions lock up my notebook
regularly after resume and that I filed another obvious locking issue of
the compilable driver stub around mmap_sem without any response from the
vendor. ]

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

