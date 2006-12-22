From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9386881.1166783234553.JavaMail.ngmail@domain.hid>
References: <458BB057.9090009@domain.hid> <458ACFDA.8070300@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
	<9386881.1166783234553.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 12:20:37 +0100
Message-Id: <1166786437.4960.180.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
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

On Fri, 2006-12-22 at 11:27 +0100, M. Koehrer wrote:
> Hi Gilles,
> 
> > fault_vm is safe to use only if you are calling fork at a time when
> > there is only one thread. So, if your application is forking at init, it
> > should be OK.
> Do you mean there must be only one real time thread? 
> That means, when I have an application that creates multiple real time threads,
> I can not rely on fault_vm() ?
> In this case I have to do the "hard" way by using a different (non real time)
> context to do the forks and system() calls.
> As this is hard to understand, I strongly recommend that there is Xenomai support
> for this! I.e. a Xenomai API that can be called with a (callback-)function pointer and
> a user data pointer. 
> When a (realtime) thread calls this function, the real time thread is blocked. 
> The callback function is then called from a safe context and
> after exit of the callback function the real time thread is resumed.
> 

Sorry, but no, no way, I won't merge anything like this, ever. This is
the wrong way to go. The right way is to fix the COW issue at kernel
level - probably the I-pipe has to provide the required support -
because this is where those dirty details belong to. This is definitely
not an API issue, because you just cannot tell application developers to
care about arch-specific VM issues when using a so-called generic API
that has to work the same way on all archs (e.g. MMU-less platforms
don't care about this, others would). What could be considered as a
bearable limitation right now must not have any impact on long-term
principles, and the API stuff belongs to that category of issues.

> Regards
> 
> Mathias
> 
> 
> 
> 
-- 
Philippe.



