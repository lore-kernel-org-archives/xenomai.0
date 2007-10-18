From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01638A0D@esealmw118.eemea.ericsson.se>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
	<1192714042.5884.20.camel@domain.hid> <1192715021.5884.32.camel@domain.hid>
	<1192716605.5884.35.camel@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E01638A0D@esealmw118.eemea.ericsson.se>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 18:12:33 +0200
Message-Id: <1192723953.5884.55.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3	to2.4
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-10-18 at 17:58 +0200, Thomas Necker wrote:
> > > > The only difference compared to your current approach is that
> > > Xenomai
> > > > will have processed the incoming tick before calling your hook, so
> > > you
> > > > don't need to forward the tick anymore. Sidenote: this only works
> > > with
> > > > periodic timebases so far.
> > > > 
> > > 
> > > Actually, I now think we should rather implement to the traditional 
> > > "daisy-chain" pattern here, with the user-defined hook 
> > being called in 
> > > replacement of the genuine tick processing code, and the 
> > hook expected 
> > > to call into xntbase_tick() to signal the incoming tick 
> > when it sees 
> > > fit. This would allow the skin to implement time slowdowns etc.
> > > 
> > > Thomas, I'm going to send a patch asap to this end. Please 
> > rely on the 
> > > common behaviour (i.e. daisy-chain) you would expect from pSOS.
> > 
> > Here we are. This patch is against 2.4-rc4, and allows to 
> > implement a daisy-chain of tick handlers.
> 
> Thanks for the quick fix. We were just discussing if (and if yes what
> kind of) implications it has when the housekeeping is done afterwards.
> It currently relies on being called before the nucleus gets the tick.

Yeah, I suspected your timer handlers were depending on the action
performed by the hook, e.g. to setup some global environment before the
application code proceeds. It's not that pretty, but a fairly common
pattern with traditional RTOS though.

> But of course I'm happy when the behaviour stays 2.3-like.
> In the course of this discussion we thought about rewriting our code
> so that we don't need the hook anymore. This could be possible with
> moderate effort if there were some global variable available that
> just counts the ticks and that could be read by the application. Is
> there something like that available?
> 

xntbase_get_jiffies(psos_tbase) would do the trick. This said, the
hook-based internal interface will always be provided by Xenomai; it's a
requirement for skins which define a user interface to interpose on the
global tick (e.g. VxWorks's sysClkConnect()).

> Btw:
> ksrc/skins/psos+ needs an EXPORT_SYMBOL(psos_tbase) added at the
> end for the patch to work.

Ack.

> 
> Thanks again,
> Thomas
-- 
Philippe.



