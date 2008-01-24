Message-ID: <2ff1a98a0801240828q5eb24503ve5a04b8f844eca22@domain.hid>
Date: Thu, 24 Jan 2008 17:28:22 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801240819r34179b2av7f92a17e8d6277a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801240819r34179b2av7f92a17e8d6277a@domain.hid>
Subject: Re: [Xenomai-core] TASK SCHEDULING E PRIORITY
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 24, 2008 5:19 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> you answer me this:
>
> > Hi,
> >
> > i'm testing xenomai but i have a problem:
> >
> > i try to run 2 TASKS with the same PRIORITY that never exit out of the
> cycle
> > ( down there is the code of task )
> > and never SLEEP
>
> 1. This will not work. Xenomai relies on Linux, so Xenomai tasks must let
> Linux run from time to time.
>
> but i see with the oscilloscope that the second task never
> > execute.
> >
> > I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0
> > ), and xnpod_activate_rr( LATCH ) kernel side.
> >
> > Which is the problem for you ?
>
>  2. If you use Xenomai in one-shot mode, round-robin is not implemented.
>  You have to switch Xenomai timer to periodic mode.
>
>
> But if i use periodic mode ( second point ) i can do the first point or it's
> the same impossibile ?

When you reply to a mail, please hit the "reply" button, so that mail
clients (as well as the mailing list archive) nicely put the reply in
the same thread as the mail you reply to.

And since you are at it, please avoid uppercase, uppercase is
equivalent to shouting on usenet. We hear you, there is no need to
shout.

Now, to answer your question, independently on the timer mode, your
system will not run if you never let Linux run.

-- 
                                               Gilles Chanteperdrix

