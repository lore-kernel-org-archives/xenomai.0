Message-ID: <466EDC2C.3020200@domain.hid>
Date: Tue, 12 Jun 2007 19:47:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
	<1181630207.7354.20.camel@domain.hid> <466ED96E.4050806@domain.hid>
In-Reply-To: <466ED96E.4050806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CONFIG_SMP in switchtest
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
> Philippe Gerum wrote:
> 
>>On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
>>
>>>Hi everybody,
>>>
>>>I want to know why the --enable-smp option for "configure" of Xenomai is used when there
>>>is already the corresponding option selected with the kernel configuration?
>>
>>--enable-smp is only used when you want the user-space side to _require_
>>SMP support to be present into the running kernel; i.e. for some (weird)
>>reason, your application really needs this. Xenomai libraries don't care
>>whether SMP support is enabled or not, they are not sensitive to that
>>issue (see the "weak" status of this option in README.INSTALL)
> 
> 
> Switchtest bases some compile-time decisions on CONFIG_SMP. Nitpicking,
> OK, but I wonder if this is required. Gilles?

If you do not enable the smp option, switchtest will only use one cpu.
The reason why I made this is that, on some UP machine, (probably arm,
but I do no longer remember) sysconf(_SC_NPROCESSORS_ONLN) did not work.

-- 
                                                 Gilles Chanteperdrix

