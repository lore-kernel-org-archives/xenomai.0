Message-ID: <47838B7C.8010704@domain.hid>
Date: Tue, 08 Jan 2008 15:41:00 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>	<14854214.1199776626079.JavaMail.ngmail@domain.hid>	<24653876.1199792394399.JavaMail.ngmail@domain.hid>	<478370D6.8080605@domain.hid>	<2ff1a98a0801080518k8970391kc2f0a4166adfe393@domain.hid>	<47837E28.5040406@domain.hid>	<2ff1a98a0801080546x16d91744uf21d25c8dc198651@domain.hid>
	<47838178.2010208@domain.hid>
In-Reply-To: <47838178.2010208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix functions for real time and non real time
Reply-To: philippe.gerum@domain.hid
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
Cc: xenomai@xenomai.org, "M. Koehrer" <mathias_koehrer@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> On Jan 8, 2008 2:44 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Gilles Chanteperdrix wrote:
>>>> When you try to mix up real-time and non real-time threads, it all
>>>> becomes very complicated. You do not need your complication: just make
>>>> all your tasks real-time tasks (using priority 0 for low priority
>>>> tasks) and forget about __real_* calls.
>>> That can be inefficient in large applications: You don't need the
>>> (average-case) overhead of Xenomai IPC for pure non-RT interaction. And
>>> IPC object creation is precisely the critical point, because their type
>>> cannot be told apart by the wrapping layer based on generic parameters.
>> The point is that you usually do not care.
>>
> 
> My customer does. :)
> 
> E.g. note that Xenomai IPC does not scale on SMP like glibc/futux-based
> stuff does (repeating once again: in the average case).
> 

You mean in the non contended case.

-- 
Philippe.

