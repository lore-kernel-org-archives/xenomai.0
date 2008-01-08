Message-ID: <47838178.2010208@domain.hid>
Date: Tue, 08 Jan 2008 14:58:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>	<14854214.1199776626079.JavaMail.ngmail@domain.hid>	<24653876.1199792394399.JavaMail.ngmail@domain.hid>	<478370D6.8080605@domain.hid>	<2ff1a98a0801080518k8970391kc2f0a4166adfe393@domain.hid>	<47837E28.5040406@domain.hid>
	<2ff1a98a0801080546x16d91744uf21d25c8dc198651@domain.hid>
In-Reply-To: <2ff1a98a0801080546x16d91744uf21d25c8dc198651@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix functions for real time and non real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, "M. Koehrer" <mathias_koehrer@domain.hid>

Gilles Chanteperdrix wrote:
> On Jan 8, 2008 2:44 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> When you try to mix up real-time and non real-time threads, it all
>>> becomes very complicated. You do not need your complication: just make
>>> all your tasks real-time tasks (using priority 0 for low priority
>>> tasks) and forget about __real_* calls.
>> That can be inefficient in large applications: You don't need the
>> (average-case) overhead of Xenomai IPC for pure non-RT interaction. And
>> IPC object creation is precisely the critical point, because their type
>> cannot be told apart by the wrapping layer based on generic parameters.
> 
> The point is that you usually do not care.
> 

My customer does. :)

E.g. note that Xenomai IPC does not scale on SMP like glibc/futux-based
stuff does (repeating once again: in the average case).

What I forgot:
> That said, I will probably create the __xn_pthread_* calls aliases to
> __wrap_pthread_* calls, but for an entirely different reason: to let
> user applications use --wrap if they need to.

Just for aesthetic reasons: Can we avoid the leading "__" for this
welcomed alternative?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

