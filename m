Subject: Re: Controlling DMA priority between GPU and CPU on x86
References: <a10e8232f3104d32900617139e7033da@heig-vd.ch>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cc3833cd-118f-8fce-6bd4-585bb79330a6@siemens.com>
Date: Fri, 4 Oct 2019 10:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <a10e8232f3104d32900617139e7033da@heig-vd.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rossier Daniel <Daniel.Rossier@heig-vd.ch>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.10.19 17:23, Rossier Daniel via Xenomai wrote:
> Hi all,
> 
> We are currently working on a project called OpenCN which is a framework deeply inspired from LinuxCNC, but with a revisited architecture.
> Hence, OpenCN is related to machine control.
> 
> Our framework mainly use a AMP approach and runs the Xenomai/Cobalt kernel on a dedicated CPU with no I-pipe (reworked out).
> (We plan to release the framework by first of November).

IOW, "bare-metal" Cobalt? Collaborative AMP, or partitioned via virtualization?

> Our framework works well on a x86 PC, but we have to face an issue regarding DMA priority between the GPU and CPU; when the user plays with the GUI,
> some small latencies (O(10ms)) raise up.
> Although the question is not directly related to Xenomai, I would be very interested if somebody knows if it possible to give CPU priority against the GPU,
> and how to manage the related DMA controller? Is it possible to configure it ? Or any other hint to avoid this latency ?
> 
> Many thanks in advance for any inputs.

I didn't dig into anything that manages PCI bandwidth yet. I heard that 
something exists, but at that time it was not publicly documented. And it's 
likely highly platform specific (SoC/chipset).

Did you clearly identify that it's DMA contention which increased your latency? 
Do you cache-miss delays increase (PMU should tell you)? Or is there a 
contention between a RT device doing DMA and the GPU?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

