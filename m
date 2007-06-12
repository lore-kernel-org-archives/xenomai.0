From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:36:46 +0200
Message-Id: <1181630207.7354.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai configure --enable-smp vs. SMP
	kernel	configuration
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
> Hi everybody,
> 
> I want to know why the --enable-smp option for "configure" of Xenomai is used when there
> is already the corresponding option selected with the kernel configuration?

--enable-smp is only used when you want the user-space side to _require_
SMP support to be present into the running kernel; i.e. for some (weird)
reason, your application really needs this. Xenomai libraries don't care
whether SMP support is enabled or not, they are not sensitive to that
issue (see the "weak" status of this option in README.INSTALL)

I agree that this could be a bit confusing, I guess that the
documentation needs an update to clarify this point.

> In other words:
> Isn't it possible to get the value from the kernel configuration to configure Xenomai itself properly?

No, we cannot anymore since v2.1, at least not at build time. The point
is that we have totally decoupled the build processes between kernel and
user-space supports. Having no build-time dependencies from the
user-space libs on the internal structures we use in kernel space is
what allows you to run older application binaries on newer Xenomai
releases, unless we had to change the syscall ABI for some very good
reason (which is seldom).

The point is that we try hard to be friendly to people deploying Xenomai
installs in the field, so that they don't have to always rebuild the
whole stuff would they want to only upgrade part of their setup. There
is a built-in ABI revision value dynamically shared between the kernel
and user-space code at application startup to trap potential mismatches.

> Or: What effects could result from a wrongly configured Xenomai (e.g. kernel with SMP,
> Xenomai configured without --enable-smp)?

None, it would work, provided your application code does not depend on
the SMP feature in some tricky ways it would be the only one to know
about (again, Xenomai libs just don't care, there are no build-time
dependencies on the kernel support here).

> 
> Thanks for any answers on that questions.
> 
> Regards
> 
> Mathias
> 
> 
-- 
Philippe.



