MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18049.25882.613508.970487@domain.hid>
Date: Tue, 26 Jun 2007 21:12:26 +0200
In-Reply-To: <468116FE.4090402@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid>
	<18046.42783.829807.333066@domain.hid>
	<468116FE.4090402@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
 > Gilles Chanteperdrix wrote:
 > > IMO, the only advantage of having absolute timers is to be able to apply
 > > the posix scheme. So, if I followed correctly your discussion, what we
 > > need is:
 > > - an XNTBISOL flag with a service xntbase_isol which set this flag and
 > >   unshare the target timebase if it is shared (IOW, if aperiodic)
 > > - the service xntbase_adjust_time to walk all the absolute timers of the
 > >   non isolated timebases and adjust their expiry date or play their
 > >   handler the posix way.
 > 
 > Two questions came up here regarding item #2:
 > 
 >  - Shouldn't we also adjust the non-monotonic timers of an isolated base
 >    if it asks for wallclock tuning? I think so.
 > 
 >  - We don't have a service to walk the list of all pending timers, do
 >    we? As that touches all of our timer queue variants and I'm not
 >    familiar with their details (except for plain lists...), I would
 >    welcome any support on this.

I am afraid for other things than lists, we will have to define an
xntimerq_iterator which holds a little bit more information than just a
pointer to a holder.

-- 


					    Gilles Chanteperdrix.

