Date: Mon, 1 Aug 2016 16:05:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160801140555.7wtzxtbqnd7iecd6@hermes.click-hack.org>
References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
 <20160801123510.jxujyigrecnbpkiy@hermes.click-hack.org>
 <64e9fed7-ae79-b7fc-04f7-0e74ef1c9239@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e9fed7-ae79-b7fc-04f7-0e74ef1c9239@siemens.com>
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Aug 01, 2016 at 02:58:54PM +0200, Jan Kiszka wrote:
> On 2016-08-01 14:35, Gilles Chanteperdrix wrote:
> > On Mon, Aug 01, 2016 at 01:29:46PM +0200, Henning Schild wrote:
> >> Hey Gilles,
> >>
> >> i just checked out the new release, which came as a surprise. Thanks
> >> for publishing that!
> >>
> >> Some of the patches prepare for kernel 4.0+ but one specifically makes
> >> sure the combination 4.0+ and 2.6.5 wont work.
> >>
> >> Am Sat, 9 Jul 2016 15:29:49 +0200
> >> schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> >>
> >> ...
> >>>       hal/x86: forbid compilation with Linux 4.0+
> >> ...
> >>
> >> Could you please provide details on how the FPU support is broken. I am
> >> successfully using xenomai 2.6 with 4.1.18 for some time now. I am not
> >> sure whether the applications on top use the FPU and if so, if there
> >> are multiple FPU-users per core.
> > 
> > The FPU support is broken in the way it detects that Linux was using
> > FPU in kernel-space (for RAID, or memcpy on oldish AMD processors,
> > geode, K6, etc...) when Linux gets preempted. We can no longer rely
> > on checking the bit TS in CR0, and need instead to use an accessor
> > that was added in the I-pipe patch to know that. For details, see
> > the changes that were made to FPU support for x86 in Xenomai 3.x.
> > 
> 
> Are we doing eager switching there already? Would allow to use things
> as-is (i.e. without having to trap FPU accesses) on CPUs that are recent
> enough to do this switching lazily in hardware.

The problem has nothing to do with trapping FPU accesses or eager
switching. Xenomai has always done eager switching. Xenomai 3 traps
fpu access in order to arm the XNFPU bit on first fpu use and then
does eager switching as usual.

-- 
					    Gilles.

