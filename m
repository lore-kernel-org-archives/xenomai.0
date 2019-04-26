Subject: Re: __ipipe_root_sync
References: <2053542.YF2tJfiQcj@omoikane>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e4e117ae-9db6-4570-8159-d6cbe4765fe8@xenomai.org>
Date: Fri, 26 Apr 2019 20:11:30 +0200
MIME-Version: 1.0
In-Reply-To: <2053542.YF2tJfiQcj@omoikane>
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
To: Steven Seeger <steven.seeger@flightsystems.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/26/19 7:07 PM, Steven Seeger via Xenomai wrote:
> Why was __ipipe_root_sync moved out of kernel/ipipe/core.c? I see it now in 
> arch/arm/kernel/ipipe.c. It is the same exact code I had in the PPC branch in 
> kernel/ipipe/core.c. I can move it to the arch-specific code, but was wondering 
> why.
> 

There is a trend in mainline to rewrite the syscall entry code in C,
instead of assembly. Syncing the pipeline is done directly from the
common (C) entry code in that case. x86 and arm64 did that conversion
already.

__ipipe_root_sync was originally meant to be invoked from asm call
sites, so the decision was made to make this code local to the two archs
we support which still do the syscall entry the old fashioned way (arm
and ppc32), anticipating on a future conversion of their entry code.

However, __ipipe_root_sync() is 100% redundant with sync_root_irqs(),
which we need in the generic pipelined syscall handling callable from C.
So the situation is a bit silly ATM. Let's rename sync_root_irqs() to
__ipipe_root_sync() in -noarch, and drop any arch-local equivalent.

-- 
Philippe.

