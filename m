Date: Sat, 18 Apr 2009 22:15:51 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E87CB1.9070604@domain.hid>
Message-ID: <Pine.LNX.4.64.0904182205490.9176@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<49E87CB1.9070604@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
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
Cc: xenomai@xenomai.org


On Fri, 17 Apr 2009, Gilles Chanteperdrix wrote:
>>...
>> Correct me if I am wrong, but turning on the NMI watchdog appears to
>> be contingent on having local APIC, which the processor that I am
>> using (an ancient AMD Athlon), doesn't seem to have.
>
> Last time I used an Athlon, it had a local APIC and IO-APIC. Only, the
> Linux kernel disables them by default, so, you have to pass a special
> option for them to be enabled (see TROUBLESHOOTING). The IO-APIC is
> buggy and caused hard lockups, but the local APIC seemed to run fine.

Yes, you are correct. I have been using lapic=1 all along, but what I
needed to do to get "make menuconfig" to let me select the NMI
watchdog, was first enable the "Local APIC support on uniprocessors"
option, and I wasn't doing that. Tonight I tried this, and then
selected the kconfig option to turn on the NMI watchdog, but when I
then compiled the kernel, gcc got upset, saying:

   arch/x86/xenomai/hal_32.c:139: warning: passing argument 1 of 'die_nmi' from incompatible pointer type
   arch/x86/xenomai/hal_32.c:139: warning: passing argument 2 of 'die_nmi' from incompatible pointer type
   arch/x86/xenomai/hal_32.c:139: error: too few arguments to function 'die_nmi'
   make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
   make: *** [arch/x86/xenomai] Error 2

Looking at the code, I found that there were two definitions of the
die_nmi() function, with completely different arguments. Rather than
try to figure out why, and fix this, I've decided to have a go with
the 2.5 release candidate, since I notice that in that version, the
above code has been removed.

Martin

