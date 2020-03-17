Subject: Re: RT thread seems blocked
References: <bb4f7cd9487f411daa1f5d948761aa65@boschrexroth.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b2a97400-db79-c156-2775-d2b67ea7ccf7@siemens.com>
Date: Tue, 17 Mar 2020 11:45:15 +0100
MIME-Version: 1.0
In-Reply-To: <bb4f7cd9487f411daa1f5d948761aa65@boschrexroth.nl>
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
To: "Bradley Valdenebro Peter (DC-AE/ESW52)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 17.03.20 11:22, Bradley Valdenebro Peter (DC-AE/ESW52) via Xenomai wrote:
> Hello Xenomai team,
> 
> We are running a Xenomai/Linux setup on a Zynq Z-7020 SoC (We run Linux on CPU0 and Xenomai on CPU1):
>   - Linux version 4.4.0-xilinx (gcc version 8.3.0 (Buildroot 2019.02-00080-gc31d48e) ) #1 SMP PREEMPT
>   - ipipe ARM patch #8
>   - Xenomai 3.0.10
> 
> Lately we have been experiencing that our highest priority real time Xenomai thread halts for around 1ms every now and then. We see it happening during different points in our thread.
> 
> This thread is triggered by an interrupt generated from the Zynq fpga logic every 125us. We have an fpga counter which is incremented every time an interrupt is generated.
> We can see in our logging that we can miss up to 4 counts (~1ms) and we do not know what is going on during that time.
> 
> We have tried using the ipipe-tracer but that gives some overhead and the issue isn't reproducible.
> The same with ftrace.
> 
> Switching from Xenomai 3.0.10 to 3.1 we see the number of occurrences decrease but still we see them.
> It is quite difficult to reproduce. It happens around once every 24 hours.
> 
> Have you got any ideas?
> Are there any known Xenomai/ipipe bugs that could explain this behaviour?
> 

Already tried ipipe-4.4.y-cip head? I can't promise it helps, but it 
does contain quite a few fixes, compared to your baseline.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

