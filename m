MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17616.44823.974769.874372@domain.hid>
Date: Wed, 2 Aug 2006 15:56:39 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA
In-Reply-To: <1154525585.9559.22.camel@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

Bart Jonkers wrote:
 > > When looking at the ipipe_enable_pipeline function, we see that
 > > interrupts management routines are all intercepted by the I-pipe, so the
 > > cascaded interrupts management routines should be automatically
 > > intercepted. 
 > > 
 > > In order to have a better understanding of the issue, it would be
 > > interesting if you could trace the functions that are called on the path
 > > from the interrupt to the execution of the final handler.
 > 
 > I have tracked and solved the issue. I have looked to the i.MX21 port
 > and they added some code to the GPIO interrupt handler of the i.MX21.
 > When IPIPE is active they unmask the interrupt for the GPIO pins at the
 > end of the handler. I did the same for PXA and my GPIO interrupt problem
 > is solved. I think that the same is needed for SA-1100.

Could you send us an updated pxa-sa1100 patch ?

 > > 
 > > Re-reading the patch I sent, I also realised that an important part of
 > > the work is missing: the function gettimeoffset should be changed by the
 > > patch too. I would be surprised if your problem was related to this,
 > > though.
 > What need to be changed in the function gettimeoffset?

The function need to return the offset since the last Linux timer
tick. With the additionnal constraint that the value returned by
gettimeofday should be increasing over time. 

For example, a probably naive approach is to store the value of OSCR as
the last timer tick date in a global variable in pxa_timer_interrupt,
and to substract the current value of OSCR from this global variable in
gettimeoffset.

-- 


					    Gilles Chanteperdrix.

