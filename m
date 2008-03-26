Message-ID: <47EA9D6F.2030808@domain.hid>
Date: Wed, 26 Mar 2008 15:01:03 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <20080325224919.582BD243A7@domain.hid>	<47EA14F7.7040004@domain.hid>
	<47EA4F65.7050600@domain.hid> <47EA9022.7010504@domain.hid>
In-Reply-To: <47EA9022.7010504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> But obviously, the co-kernel mode based on the I-pipe is here to stay, and the
> purpose of Xenomai 3 is to allow the emulators to be usable on top of both
> real-time cores (i.e. PREEMPT_RT, or I-pipe + nucleus), using a simple
> recompilation. SOLO is an intermediate step, before both approaches are
> reconciled with a common emulator code base in Xenomai 3. In other words: two
> real-time cores, one set of emulators. Well, that's the plan.
>
> I will send a roadmap to Xenomai 3 asap (take this literally, because of hectic
> schedule here), to explain where we are heading to.
>
>   
Thanks for the clarification - I was not sure of the intent for SOLO,
but now it makes sense.  I'm glad that IPIPE is not going away, as my
application will need hard real time.

    Steve


