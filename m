Message-ID: <3D361D89.EE39DC2B@opersys.com>
Date: Wed, 17 Jul 2002 21:44:41 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: Realtime on top of Adeos (Was: Re: [Adeos-main] [ANNOUNCE] Adeos M2)
References: <OFF782B728.BFF318FC-ON85256BF9.00772E1C-85256BF9.007B8E4C@LocalDomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Timothy_J_Massey/TheModernMerchant@domain.hid
Cc: Philippe Gerum <rpm@xenomai.org>, adeos-main@gna.org

Timothy_J_Massey/TheModernMerchant@domain.hid wrote:
> Quick question:  how does Adeos affect real-time response?  Wouldn't Adeos have to be real-time itself, and wouldn't the (guaranteed) latency of
> Adeos be added to the latency of the upper level RTOS?

Adeos doesn't know anything about real-time. All it sees are hardware
resources that client OSes need to share. Currently, Adeos allows the
most basic resource required to run OSes, interrupts, to be shared.
As is done in many nanokernels before it (see Exokernel paper), Adeos
provides for an orderly delivery of hardware resources.

If an RTOS is indeed running on top of Adeos, then it certainly does
have to contend with the fact that Adeos' code will always run before
the RTOS' interrupt handler. This code delivers the interrupts in the
order of domains found in the interrupt pipeline, which is pretty
much up to the system designer. If Linux is first, then it gets it
first. If a kernel debugger is first, then it gets it first. If an
RTOS is first, then it gets if first.

If we are talking about real-time on conceptual grounds, however, note
that "real-time" is not so much an issue of speed as it is an issue of
guaranteed deterministic behavior.

I had some interesting discussions at the OLS with Daniel Phillips about
Adeos. He was pointing out that one interesting application for Adeos
was to run 2 RTOSes side-by-side, each responsible for tasks running at
a different resolution. For example, the first RTOS in the pipeline
would be responsible for tasks that need microsecond resolution, while
the second RTOS in the pipeline would be responsible for tasks that
need millisecond resolution.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

