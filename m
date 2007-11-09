Message-ID: <47348EE0.5020007@domain.hid>
Date: Fri, 09 Nov 2007 17:46:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>
	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>
	<473006D8.4080808@domain.hid> <47302D55.9050808@domain.hid>
	<47339C53.5010700@domain.hid> <4734677E.6010904@domain.hid>
In-Reply-To: <4734677E.6010904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Jan Kiszka wrote:

> Well, this is practically your original version. I still don't see why
> we want debug code in production setups (WARN_ON, e.g., doesn't work
> this way either),

Do you actually leave CONFIG_IPIPE_DEBUG on in production setups?

> and I still don't understand why you want to report
> user faults as kernel bugs.
>

This is a red herring: we are currently in a situation where such
messages would be actual kernel issues because some APIs are sloppy wrt
kernel/user copies, this is the point.

> If you want to spot skin issues, just grep for __xn_copy_to/from_user or
> __xn_strncpy_from_user and check for missing return code evaluations.
> Really, that's nothing we need runtime checks in I-pipe for.
>

It's a _debug_ tool until everything is fixed, because we have loads of
APIs to fix for untested copy_from/to_user, and anything out-of-tree
code may have used the same way. It's merely a conditional and passive
check, far away from the hot path, which is there "just in case". The
same way you may run with the domain context checker enabled although
you may be reasonably confident that having some context mismatch still
hiding in the Xenomai core is currently unlikely -- but you know nothing
about what may be going on out-of-tree.

This feature is mainly aimed at API writers, not users. Additionally,
not everyone is going to switch to 2.4 with the ironed kernel/user copy
code overnight, so we want this code in 2.6.20/x86 too, so that at
least, we may tell people to upgrade their I-pipe patch if need be, then
switch CONFIG_IPIPE_DEBUG on to trap those trivial issues, including
over past 2.3.x releases. At least, we could tell them how and where to
fix their code.

At worst, the message will never trigger because all bugous spots will
have been addressed within the skins during the next stable releases:
fine. Otherwise, we will have more information to chase such kind of bugs.

-- 
Philippe.



