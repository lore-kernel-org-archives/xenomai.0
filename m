From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070629172907.698f9586@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid> <20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid> <20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid> <20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid> <20070629164326.15579570@domain.hid>
	<46851E97.7030402@domain.hid> <20070629172907.698f9586@domain.hid>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 17:47:52 +0200
Message-Id: <1183132072.6574.84.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] measuring tasks execution time
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2007-06-29 at 17:29 +0200, Daniel Simon wrote:
> On Fri, 29 Jun 2007 17:00:39 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
> 
> > Exectime is only updated on task switches. So you are not obtaining the true
> > value when requesting your own data. Use the same formula for both cases.
> 
> yes, but like that the fraction of time spent in the current execution is not
> accounted, which might be sometimes useful (e.g. to integrate the cost of a
> feedback scheduler in the total control budget)
> 
> another potentially useful feature would be also accounting the execution time
> spent in secondary mode... no idea on how to do that. 

Xenomai-wise, secondary mode starts for an emerging thread in
xnshadow_map(), then stops when exiting xnshadow_harden(), then resumes
when exiting xnshadow_relax(). All routines are defined in
nucleus/shadow.c.

> BTW, Posix defines an optional CLOCK_THREAD_CPUTIME which is assumed to provide
> this measure ?
> 
> 	Daniel
> 
-- 
Philippe.



