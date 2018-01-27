References: <c9443b76-da71-9885-82a4-9e524b460998@xenomai.org>
 <11bce118-b19b-fc07-8a2d-03f4d618d5d4@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <afe62c97-fdef-d9fa-84d4-4aa1e81e6b11@xenomai.org>
Date: Sat, 27 Jan 2018 12:31:00 +0100
MIME-Version: 1.0
In-Reply-To: <11bce118-b19b-fc07-8a2d-03f4d618d5d4@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] FOSDEM meeting agenda
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild <henning.schild@siemens.com>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>, Jan Leupold <leupold@rsi-elektrotechnik.de>, Jorge Ramirez <jro@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>
Cc: Steven Seeger <steven.seeger@nasa.gov>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 01/26/2018 07:49 PM, Jan Kiszka wrote:
> 
> Then testing. I would also not go into too much details, but it would be
> good to understand what exist(ed) and what could be done easily to
> improve it.

That I can answer quickly: over the years, we went from manual testing I
was carrying out over a couple of boards for each of the supported
architectures, to a home-made CI system Gilles had developed, which was
hosted on his server.

That system did automated nightly build tests for every architectures,
and latency measurements under stress periodically, for a few ARM SoCs
of the common ARM architectures back then (armv4, armv5, then later
armv7), generating latency reports. x86(32/64) testing was shared
between Gilles (early atom-based board) and I (i5 and atom). Other CPU
architectures were on my plate (e.g. ppc(32|64), blackfin - ia64, nios2
and sh4 when Xenomai was still supporting them).

Since we lost Gilles, no CI system has been available. We once had plans
to rehost our CI from the home-made infrastructure to a publicly
available automation server, but could not pursue mainly due to a lack
of time for putting the pieces together.

Today, I'm generally able to do proper testing on ARM* SoCs (armv7,
armv8 exclusively though) and x86, because this matches the target
architectures of some of my contract work.

-- 
Philippe.

