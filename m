Sender: dv@domain.hid
Message-ID: <44AC4058.6ED2CAB8@domain.hid>
Date: Thu, 06 Jul 2006 00:42:32 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
References: <44A3919C.596DFDAE@vollmann.ch>		<1151592402.19389.31.camel@domain.hid>		<44A4C4CB.5F24DA68@domain.hid>		<1151657621.3060.26.camel@domain.hid>		<44A8B191.3DCC39C2@domain.hid>		<44A8BA2E.9090106@domain.hid>		<44A8D7A1.4E4E9D27@domain.hid>		<17577.4096.436840.354535@domain.hid>
	<17577.5372.702355.432641@domain.hid>
	<44AA0E21.3F17401F@vollmann.ch> <44AA76AD.6010804@domain.hid>
	<44AC3DF3.747A5047@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Detlef Vollmann wrote:
> 
> Jan Kiszka wrote:
> > It's this piece of code always running under IRQ-lock?
> No.  ipipe_tune_timer() is a public ipipe interface and can
> be called from everywhere.
Oops, sorry.  I was talking nonsense.
Yes, it is always running under IRQ-lock (and I'm doing the lock
myself).

Sorry for the misinformation
 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

