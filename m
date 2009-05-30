From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D80348DF91@domain.hid>
References: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid>
	<1242219577.26544.952.camel@domain.hid>  <4A0AC81A.7050000@domain.hid>
	<1242221456.26544.960.camel@domain.hid>  <4A0ACC6A.3010205@domain.hid>
	<1242222147.26544.964.camel@domain.hid>
	<4B2EEE69E41E524EB7FCDC62A15D68D80348DF91@domain.hid>
Content-Type: text/plain
Date: Sat, 30 May 2009 17:32:33 +0200
Message-Id: <1243697553.27443.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Periodic threads not scheduled
 anymore during debug session
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-05-27 at 11:23 +0200, thomas.debes@domain.hid wrote:
> > 
> > For the rest, we would have to reverse the current logic and tag
> > blockable timers instead of non-blockable one. The shadow code would
> > then have to tag the ptimer/rtimer of the ptraced thread as blockable,
> > leaving all other timers as unblockable by default.
> > 
> > >
> 
> Do you know when this will be implemented? 
> 

No idea, yet. This is certainly something to work on at some point
though.

> We have a kernel watchdog service running (Xenomai task) which always restarts our system while debugging (because the watchdog is not triggered anymore). I assume that this problem is related to the one above.
> 
> Thanks
> Thomas
> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
-- 
Philippe.



