Message-ID: <47EA14F7.7040004@domain.hid>
Date: Wed, 26 Mar 2008 10:18:47 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <20080325224919.582BD243A7@domain.hid>
In-Reply-To: <20080325224919.582BD243A7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Wolfgang Denk wrote:
>> Is it worth providing a separate xenomai-solo package in Debian right
>> now (considering it being propagated to Debian 5.0 and supported there
>> in this form until ca. 2010), or should we wait until Xenomai/SOLO is
>> integrated into Xenomai mainline?
> 
> Integration into Xenomai mainline means waiting for Xenomai 3, which
> seems still a pretty long way to go.
> 
> On the other hand, you need a PREEMPT_RT enhanced  Linux  kernel  for
> Xenomai/SOLO  to provide real-time behaviour which is probably needed
> in most cases when you try and emulate a RTOS.  This  is  probably  a
> bigger hurdle?

I think an RT-patched kernel is quite common, at least if I consider the
realtime conscious Debian user community. For other realtime
applications such as JACK (though in a completely different application
domain), the respective kernels are also often presumed.

So if we are talking about Xenomai 3 in the order of years, Xenomai/SOLO
as a separate package seems worth considering if it matures reasonably.

The other "desktop suitable" approach is the simulator. Both
Xenomai/SOLO and the simulator are good candidates for inclusion in the
OS distribution since (apart from certain kernel requirements) they can
be provided as universal binary packages in userspace.

The problem with xenosim is its dependency upon gcc-2.95.6 sources.
Since Debian packages must provide the complete sources for building the
binary packages or alternatively/additionally have build dependencies
satisfied by other (binary) Debian packages in the distribution, this is
not an easy task (without gcc 2.95.x being in Debian anymore). One way
to go could be utilizing a newer GCC (4.x) instead of 2.95.x, but that
doesn't work with current xenosim. Is it worth it to put porting effort
into this spot?

Thanks!

bye,
  Roland

