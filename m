Subject: Re: Cobalt Preemption of kernel update_fast_timekeeper can cause
 deadlocks
References: <f4c18591165c4b919c85ac90a756af9f@andritz.com>
 <159d2a96-fb82-b974-7958-79367a00a546@xenomai.org>
 <cdc2d93e-3d5b-0d5b-bf17-1a813e0622e2@siemens.com>
 <70702a6f3a2e47e58a54bc88e8298caf@P10-EX02.3DSystems.Internal>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4aebca73-7231-e92f-2424-0d44ee12e2a8@siemens.com>
Date: Thu, 20 Dec 2018 11:45:25 +0100
MIME-Version: 1.0
In-Reply-To: <70702a6f3a2e47e58a54bc88e8298caf@P10-EX02.3DSystems.Internal>
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
To: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.12.18 19:26, Auel, Kendall via Xenomai wrote:
> Jan,
> 
> I'm very much in favor of providing a way to prevent Xenomai modules from using features which can result in deadlock, if there is a clean way to detect such a situation.
> 
> We used gettimeofday in one of our modules and it mostly worked great. But once in a great while the system would deadlock. Most calls to gettimeofday are benign and appear to work normally, which is why it is especially problematic. It would have saved some debug cycles if there was a kernel log message to warn us of our danger.
> 
> Or perhaps we could collect a blacklist of references which will produce warnings when linking a Xenomai module. All of these things are 'nice to have' but certainly not urgent matters.

We do have the infrastructure and a small use case for such RT traps already: If 
you use --mode-check on xeno-config, any usage of malloc and free from RT 
contexts will be detected and reported. These calls are evil as well because 
they tend no not trigger a syscall in the fast path and only fail on contention 
or empty-pool situations of the userspace allocator.

We could extend that mechanism for gettimeofday & Co. checks, but we need to 
limit that to non-posix applications: with posix, you are already redirected to 
the RT-safe implementations of those functions.

Patches welcome.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

