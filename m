Message-ID: <6ee4c8380604191042v1e914467k3ce36ffd44843548@domain.hid>
Date: Wed, 19 Apr 2006 13:42:55 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
Subject: Re: [Xenomai-help] General question on Native Skin tasks
In-Reply-To: <444670C9.6050207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
	<4443992C.5000808@domain.hid>
	<6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>
	<44455471.8090001@domain.hid>
	<6ee4c8380604190827q76a1442du59c90b2515f71cdd@domain.hid>
	<444670C9.6050207@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> Yes, but when blocking native services are invoked, the caller has to be
> a native thread again. Only pure non-RT threads with no shared critical
> paths can be plain pthreads. When in doubt, study the native
> documentation regarding allowed contexts. The statement "switches to
> primary mode" indicates that a native thread is required.

So in this case, can I still call the functions from a thread created
using pthread_create (assuming that they may momentarily increase in
priority)?

Can you explain "no shared critical paths"? Would this include
contending for a mutex-protected resource which is also used by a
real-time thread?

All of my non-time-critical threads are doing some form of
communication with real-time threads, either through a queue or
through mutex-protected memory. Can they still be pthread_create
threads?

> Hope I could clarify the situation.

You've been supremely helpful. I apologize for asking so many questions.


>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>
>

