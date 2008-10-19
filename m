Message-ID: <48FB17BD.7010904@domain.hid>
Date: Sun, 19 Oct 2008 13:19:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid> <48FB15A8.30703@domain.hid>
In-Reply-To: <48FB15A8.30703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger priority
	change in user-space.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> I wonder if we shouldn't switch the signal hooking strategy: So far we
> install the handler at shadow thread creation time, saving a potentially
> installed handler of the application for redirection of
> Xenomai-unrelated events. But that only works if the application
> installed the handler before it creates the first shadow thread, right?
> If the app decides to install/change the SIGWINCH handler later on
> (without taking care of our handler), we will loose.
> 
> Suggestion: As this is fragile and cannot be solved transparently, lets
> document this signal requirement of Xenomai, e.g. in all task/thread
> creation functions of the skins. Tell the user that Xenomai will install
> a custom SIGWINCH handler and that, if the app wants to override it, it
> has to make sure to _first_ call into a Xenomai-provided handler and
> check if that one wants to handle the event. I'm thinking of something
> like int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt),
> where the return code is non-zero in case the signal was processed.
> 
> With this policy in place, we can switch the signal handler installation
> above to __attribute__ ((construtor)) and save us all the changes
> regarding sigshadow_install below.

You mean to push the burden of identifying the signal source and calling
the proper handler on the user. With the current approach we take care
of that burden, I think it is better. But I agree that this should be
documented somewhere.

> One question currently remains open for me, both regarding your approach
> as well as my suggestion: What happens if some app links against more
> than onw skin library? I think your approach will cause multiple
> sigshadow_handler invocations (as the stack up due to library-local
> pthread_once), while mine suffers from multiple xeno_sigwinch_handler
> symbols. The latter might be solvable with __attribute__ ((weak)), correct?

Yes, the pthread_once_t should be global with __attribute__((weak)), and
 we would get the proper behaviour for the proposed implementation too.

-- 
					    Gilles.

