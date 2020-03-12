Subject: Re: [RFC][PATCH 4.19] x86/ipipe: Protect TLB flushing against context
 switch by head domain
References: <266b8c4f-ffec-d04e-ab83-9ae4cbf3486f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4e5c245a-e3fe-d535-b099-3099daf28a5a@xenomai.org>
Date: Thu, 12 Mar 2020 16:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <266b8c4f-ffec-d04e-ab83-9ae4cbf3486f@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 3/12/20 2:48 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> A Xenomai application is very rarely triggering
> 
> WARNING: CPU: 0 PID: 1997 at arch/x86/mm/tlb.c:560 [...]
> (local_tlb_gen > mm_tlb_gen)
> 
> This could be triggered by loaded_mm and loaded_mm_asid becoming out of
> sync when flush_tlb_func_common is interrupted by the head domain to
> switch a real-time task right between the retrieval of both values, or
> maybe even after that but before writing mm_tlb_gen back to
> cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen.
> 
> Avoid that case by making the retrieval atomic while keeping the TLB
> flush interruptible. Now, there could still be interrupt during the
> flush. To avoid writing back to the wrong context, we first atomically
> check after the flush if nothing changed and only write if that is the
> case. That may mean another TLB flush is triggered needlessly, but
> that's rare and acceptable.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Due to the rare nature of this issue, we are not yet confident to have 
> truly fixed it this way.
> 
> Philippe, I'm seeing some similar attempt in dovetail but it appears to 
> me it's missing some cases.

Not "some cases", but the last one in your patch specifically if I read
it correctly, which I assumed was not applicable, at least not the way I
read your change, when I worked on this a year ago. This explains why
that particular change is not present in the commit (3aa2fc2fb4c) you
seem to have cherry picked from dovetail for the 5.x kernel series. This
said, these are tricky issues, so as you hinted in your commit log,
there is likely room for improvement in any case, and I may have
overlooked things.

> Too bad that development was forking here 
> and information isn't flowing smoothly yet.

You just demonstrated that the information is there, and that anyone can
access it freely by looking at the EVL development tree. I'm sorry to
hear that forking my own code for the most part in order to find a
better approach for others to benefit from in the long run can be a
problem. I did not find any other way to go back to the drawing board as
required by the technical goals I'm pursuing with EVL, which differ from
Xenomai's.

-- 
Philippe.

