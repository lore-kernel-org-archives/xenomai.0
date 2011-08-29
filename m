Message-ID: <4E5B98CE.3000200@domain.hid>
Date: Mon, 29 Aug 2011 15:49:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAvA3H_9MbPT+QLgbmVAk-5ZzE2eu0TQo3rzS1mkBV0RtSPcXw@domain.hid>
	<CAAvA3H_rtX_Js5TVHHWDyK-J4vouEY4LxO9MsvdU-y8TjPVoNA@mail.gmail.com>
In-Reply-To: <CAAvA3H_rtX_Js5TVHHWDyK-J4vouEY4LxO9MsvdU-y8TjPVoNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: dynamic loader latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On 08/29/2011 03:26 PM, Jeff Weber wrote:
> Bumping this post again in hopes of eliciting comments ...
> 
> Jeff
> 
> ---------- Forwarded message ----------
> From: Jeff Weber <jwamsc@domain.hid>
> Date: Fri, Aug 26, 2011 at 11:34 AM
> Subject: dynamic loader latencies
> To: Xenomai Help <xenomai@xenomai.org>
> 
> 
> The Linux ELF dynamic linker/loader ld-linux.so uses a "lazy" model by
> default, and defers symbol resolution, shared object resolution to the time
> when the symbol is first referenced.  This sounds like a large latency
> threat to dynamically linked RT applications running in primary mode. Can
> this happen, or is this unlikely?
> 
> If this is a latency risk, the only solutions I know of are:
> 
> 1) Statically link all RT applications
> 
> 2) Invoke all dynamically linked applications with LD_BIND_NOW=1 environment
> to force the dynamic loader to resolve all  symbols  at program startup
> 
> 3) Link dynamic applications with "-z now" GNU ld option to effect same as
> 2) above.
> 
> Comments?

The best way to be sure is to run some benches. I never run such
benches, so, cannot answer.

-- 
					    Gilles.

