Message-ID: <3D0DD94D.EE781A5E@opersys.com>
Date: Mon, 17 Jun 2002 12:42:53 +0000
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
References: <20020617120652.36799.qmail@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: My first tests with adeos!!!
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
To: mohan kumar <mohan_knb@domain.hid>, Adeos <adeos-main@gna.org>
Cc: rtai@domain.hid

Hello Mohan,

Cool testdrive ... ;)

BTW, there's an Adeos mailing list here: adeos-main@gna.org
That's the best place to send your mails to.

mohan kumar wrote:
> Now, i changed the way timer interrupt(0) is hanlded
> using the adeos_control_irq call. My understanding is
> that "it can control weather the interrupt is
> dispatched to lower priority domains" So i set my
> domains priority higher to linux and then made adeos
> not to send linux the interrrupts. I did this because
> i programmed the 8254 for more grannular interrupts
> and was going to dispatch the timer interrupt to linux
> only after 10ms.

Did you write the dispatching code? If you didn't then that's what's
hanging your system for sure.

> I tried with more interrupts down the line (2,3,..9)
> and see the same scenario happening.

In the example test case we provide, all interrupts are fed to
all the domains in the ipipe. Of course, if you start telling
Adeos not to pass interrupts to Linux, then you must have a
way to handle them.

I think the best way to get some help would be to post the code
you wrote for your domain. Otherwise, we can only guess, but not
much more ...

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

