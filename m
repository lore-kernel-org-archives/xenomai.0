Subject: Re: urcu/lttng (Userspace) and Xenomai
References: <VI1PR05MB5917D0B45F7CB253F10197B5F64E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5718dcc6-9af6-03f8-3e44-b91805f403e2@siemens.com>
Date: Thu, 21 Nov 2019 14:45:50 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917D0B45F7CB253F10197B5F64E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 21.11.19 11:26, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I am trying to figure out if Xenomai would work correctly with Lttng. Currently I haven’t figured out how the system manages buffers,
> but I am checking if this would be generally applicable to Xenomai.
> 
> I’d like to know if anyone has already used Lttng UST with xenomai threads,
> and if there is any need to compile lttng/liburcu for xenomai or using some patches.
> (I haven’t seen anything that indicates it would not work).
> 
> ## urcu flavours
> This has a few variants, lttng uses the bulletproof one. Most others should be
> faster on average – but all of them might unlock a futex with a raw syscall.
> 
> Other flavours like qsbr could likely be faster if the futex sycall would be replaced with a cobalt mutex
> (it’s very unlikely this path is executed). Would need some work to get this done (and lttng to use it).
> 
> ## sys_membarrier
> recent kernels and liburcu versions support this syscall, which supposedly
> allows removal of reader memory barriers.
> The syscall will somehow interrupt the threads (all *running threads* of the process), which implicitly causes a barrier for readers.
> 
> Q: I guess this will *not* interrupt xenomai threads, as their shadow linux thread is not *running*?
> Q: x86_64 accesses are strictly ordered, do you actually need membarriers at all?
> 

I didn't look into details of enabling userspace lttng yet, but I had a 
chat with Mathieu about this, maybe a year ago. He said back then that 
there is also a polling mode where a data collection thread is simply 
trying to obtain the trace output time-driven. Then the producer 
(including cobalt threads) would not need any syscall at all. As I said, 
that was just a conceptual discussion. None of us actually looked into 
the implementation.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

