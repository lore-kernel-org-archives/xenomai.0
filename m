Date: Fri, 21 Jul 2006 14:51:59 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Subject: Re: [Xenomai-help] Priority inversion
Message-ID: <20060721145159.5a87453c@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E05B4564@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210E1A@EINT11.einet.ad.eivd.ch>
	<FDBBB5CC70676540B3EF7CFE83FD94E05B4564@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 21 Jul 2006 14:12:47 +0200
"ROSSIER Daniel" <Daniel.Rossier@domain.hid> wrote:

> but it might be at the spin() level.

I have observed that the behaviour of rt_timer_spin() does not fit with
the expected behaviour as described in the doxygened comment: its actual
awakening time do not increase when it is preempted. 

According to the code in timer.c (using 2.1.2) the wakening time seems
to be computed once for all at the beginning of the function call.

Am I right?

	Daniel

-- 
      Daniel SIMON    Projet POP ART  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://pop-art.inrialpes.fr/people/simon/



