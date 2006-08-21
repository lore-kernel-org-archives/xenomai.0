Date: Mon, 21 Aug 2006 09:25:09 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Subject: Re: [Xenomai-core] ksrc/driver refactoring
In-Reply-To: <1155916850.4326.118.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0608210922010.19485@domain.hid>
References: <Pine.LNX.4.64.0608161603176.7349@domain.hid>
	<1155916850.4326.118.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 18 Aug 2006, Philippe Gerum wrote:
> On Wed, 2006-08-16 at 16:14 +0200, Klaas Gadeyne wrote:
>>> I just wanted to drop a note that I did some refactoring on the
>>> drivers directory (16550A->serial) and the config menus. If anything is
>>> broken, shoot me.
>>
>> I don't think this is related, but 2 students of mine got stuck on a linker
>> error this morning trying to compile xenomai-trunk on a i386 target
>> (2.4.33 kernel with the adeos-ipipe-2.4.32-i386-1.2-06.patch (applied
>> with a few minor hunks), gcc 3.3.6 from Debian).

[...]

>> The "quick-fix" solution was to disable the magic_sysrq_key option
>> from the kernel.  I first thought the problem was due to a missing
>> dependency in the the kernel and not at all xenomai-related (and since
>> the quick hack worked, they didn't search any further), but now that
>> I've read your mail I started to doubt if it might be related.

[...]

> There seems to be a few "generic" 2.4 kernel issues in the same area.
> For instance, building the kernel without CONFIG_VT causes
> handle_scancode to be undefined, since driver/char/Makefile does not
> build keyboard.c in such a case, albeit it's used by the input
> subsystem. In any case, this is not related to Adeos/Xenomai.

Indeed, that's what they've concluded too, the vanilla kernel suffers
from the same problem.  They should have posted this themselves a
couple of day ago, but they seem to have some trouble getting started
with the ML :-)

thx,

Klaas

