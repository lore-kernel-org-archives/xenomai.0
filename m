Message-ID: <2ff1a98a0706290856w73b98524x7c7adda7f4e87ae5@domain.hid>
Date: Fri, 29 Jun 2007 17:56:21 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1183132072.6574.84.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<46693B6B.1010201@domain.hid> <20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid> <20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid> <20070629164326.15579570@domain.hid>
	<46851E97.7030402@domain.hid> <20070629172907.698f9586@domain.hid>
	<1183132072.6574.84.camel@domain.hid>
Subject: Re: [Xenomai-core] measuring tasks execution time
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On 6/29/07, Philippe Gerum <rpm@xenomai.org> wrote:
> On Fri, 2007-06-29 at 17:29 +0200, Daniel Simon wrote:
> > On Fri, 29 Jun 2007 17:00:39 +0200
> > Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >
> > > Exectime is only updated on task switches. So you are not obtaining the true
> > > value when requesting your own data. Use the same formula for both cases.
> >
> > yes, but like that the fraction of time spent in the current execution is not
> > accounted, which might be sometimes useful (e.g. to integrate the cost of a
> > feedback scheduler in the total control budget)
> >
> > another potentially useful feature would be also accounting the execution time
> > spent in secondary mode... no idea on how to do that.
>
> Xenomai-wise, secondary mode starts for an emerging thread in
> xnshadow_map(), then stops when exiting xnshadow_harden(), then resumes
> when exiting xnshadow_relax(). All routines are defined in
> nucleus/shadow.c.

Additionnaly when a task is suspended by Linux, the function
do_schedule_event is triggered by Adeos.

-- 
                                               Gilles Chanteperdrix

