From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAAvA3H_9MbPT+QLgbmVAk-5ZzE2eu0TQo3rzS1mkBV0RtSPcXw@domain.hid>
References: <CAAvA3H_9MbPT+QLgbmVAk-5ZzE2eu0TQo3rzS1mkBV0RtSPcXw@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Aug 2011 22:32:45 +0200
Message-ID: <1314649965.10447.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] dynamic loader latencies
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

On Fri, 2011-08-26 at 11:34 -0500, Jeff Weber wrote:
> The Linux ELF dynamic linker/loader ld-linux.so uses a "lazy" model by
> default, and defers symbol resolution, shared object resolution to the
> time when the symbol is first referenced.  This sounds like a large
> latency threat to dynamically linked RT applications running in
> primary mode. Can this happen, or is this unlikely?

Good question, I never actually measured this over an application
mapping shared libs which would consist of a large number of routines
called over time.

I would tend to think that ld.so's symbol lookup routine might represent
the highest risk for significant latency, if any, because all the rest,
i.e. GOT, PLT and the code itself should have been read in and processed
at program init, either by ld.so or as a result of mlocking the program.

Running the trampoline code from the PLT and fixing up the GOT with the
indirect jump address after symbol resolution should not entail
significant latency either, so the real issue, if any, might be
introduced by the lookup code actually resolving the symbols. I would
think that all the data is already there, available to ld.so for this
operation, and the ELF format mandates that dynamic symbol names be
hashed for fast retrieval. However, I may be wrong, this needs to be
verified.

> 
> 
> If this is a latency risk, the only solutions I know of are:
> 
> 
> 1) Statically link all RT applications
> 
> 
> 2) Invoke all dynamically linked applications with LD_BIND_NOW=1
> environment to force the dynamic loader to resolve all  symbols  at
> program startup
> 
> 
> 3) Link dynamic applications with "-z now" GNU ld option to effect
> same as 2) above.
> 
> 
> Comments?
> 

In short, my understanding is that we should not see significant extra
latency, unless ld.so does on demand loading of portions of the ELF
tables/sections it needs for symbol resolution, instead of loading these
tables at program init. This seems unlikely though.

> 
> thanks,
> Jeff
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



