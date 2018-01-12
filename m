References: <0e3bd82f06324467932a33ca3ffe4085@ocnapvsw3301.ocr.priv>
 <16361_1515687408_5A578DF0_16361_2622_1_ffea3d58-bdb2-cc1b-d3d5-35e8a614477c@utpvision.it>
 <0728c0c5a202411db337cb9d6f866a22@ocnapvsw3301.ocr.priv>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f44ed317-e90e-472c-8527-4654404781f1@siemens.com>
Date: Fri, 12 Jan 2018 14:36:35 +0100
MIME-Version: 1.0
In-Reply-To: <0728c0c5a202411db337cb9d6f866a22@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] R: Xenomai 3.0.6 high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "Simone M. Zucchi" <simone.zucchi@utpvision.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-01-12 10:51, Fazio Maurizio wrote:
> Hello,
> I applied your solution. I launched again the latency test but again worst case was 164us...
> I monitored the test for a while and I noticed these behaviors:
> - When I launched the console application the worst latency grew over 100 us...
> - After a while the monitor has gone to black screen and then I moved the mouse... even in this case  the worst latency grew over 100us
> 
> Have you any idea?
> 

You didn't specify enough details of your hardware platform and
configuration yet. Maybe the latencies are related to hw effects, thus
not much that software can contribute to.

Typical sources:
 - system management mode (BIOS)
    -> disable SMI, if possible, via the related Xenomai logic
 - contentions on graphic operations, specifically with built-in GPUs
    -> head-less operation, possibly also a different graphic mode
       (framebuffer instead of DRM)
 - aggressive power management
    -> disable in the kernel, watch out for suspicious BIOS settings

Software-related latencies can be identified by using tracing, ftrace
with event tracing (trace-cmd, kernelshark) or the ipipe function
tracer. Specifically, use the latency benchmark to stop the latter when
a new maximum arrives. If you share the trace, the community may help
with analyzing.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

