Message-ID: <47ECC5C1.8040405@domain.hid>
Date: Fri, 28 Mar 2008 11:17:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080325224919.582BD243A7@domain.hid>
	<47EA14F7.7040004@domain.hid>
In-Reply-To: <47EA14F7.7040004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
> 
> So if we are talking about Xenomai 3 in the order of years, Xenomai/SOLO
> as a separate package seems worth considering if it matures reasonably.
>

It is not in the order of years, but likely weeks, to get the four traditional
RTOS emulators currently available from 2.x running on top of the SOLO core
(Btw, I've just committed the early version of the pSOS emulator to the GIT tree
which still needs heavy testing though).

Before packaging this, I would recommend to wait for significant test suites to
be available for all of them; I guess this should be the case by the end of May,
if the current pace can be sustained.

> The other "desktop suitable" approach is the simulator. Both
> Xenomai/SOLO and the simulator are good candidates for inclusion in the
> OS distribution since (apart from certain kernel requirements) they can
> be provided as universal binary packages in userspace.
> 
> The problem with xenosim is its dependency upon gcc-2.95.6 sources.
> Since Debian packages must provide the complete sources for building the
> binary packages or alternatively/additionally have build dependencies
> satisfied by other (binary) Debian packages in the distribution, this is
> not an easy task (without gcc 2.95.x being in Debian anymore). One way
> to go could be utilizing a newer GCC (4.x) instead of 2.95.x, but that
> doesn't work with current xenosim. Is it worth it to put porting effort
> into this spot?
> 

The simulator is really a nice tool, but its code instrumenter was written ten
years ago as a patch against egcs-1.0, then subsequently upgraded a number of
times, up to 2.95.3. Unfortunately, upgrading this patch to gcc 3.x or even 4.x
would be a very significant work, because I hooked the instrumentation engine
right into the C/C++ parser stage, and this area of code has been very deeply
refactored over the years (actually, even replaced IIRC).

To my knowledge, only two people "officially" use the simulator, specifically
for debugging the Xenomai core, i.e. Gilles and myself, so there is not much
traction on this side. We just grab some outdated box on which we can rebuild
xenosim, and we live with it this way.

I feel it's sort of a shame, since IMHO, event-driven simulation is just the
ultimate way for efficient debugging and modelling real-time behaviour, but
well, it would really be a project on its own to revamp it, and lack of time
bites everyone.

-- 
Philippe.

