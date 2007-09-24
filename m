MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18168.1587.763871.556961@domain.hid>
Date: Mon, 24 Sep 2007 20:47:15 +0200
In-Reply-To: <46F7F868.2050904@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
	<46F7F868.2050904@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Richard Cochran wrote:
 > > I know that this is a bit off topic, yet perhaps some on this list
 > > have interest or knowledge in this area. I am also posting this idea
 > > to the linux-arm-kernel list.
 > > 
 > > I would like to implement the ARM FCSE under Linux, using the Intel
 > > IXP425 board. Before I start, I would like to ask:
 > > 
 > > 1. Has any work already been done in this area?
 > > 
 > > 2. Is there something about the current Linux MM that would make this
 > >    impractical?
 > 
 > Nothing is impossible (specifically as FASS proves its feasibility),
 > it's just a question how much work it is to implement it AND maintain it
 > or merge it into standard Linux. And I cannot imagine ARM or its
 > licensees dropping this feature without an acceptable alternative once
 > Linux started to use it broadly...

The feature was already dropped, it is deprecated in ARMv6.

-- 


					    Gilles Chanteperdrix.

