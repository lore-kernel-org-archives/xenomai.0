Message-ID: <4915CF4A.9030805@domain.hid>
Date: Sat, 08 Nov 2008 18:41:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>
In-Reply-To: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SegFault on all demo apps!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Cristian Axenie wrote:
> WHAT AM I MISSING, I SEE PLENTY OF No such file or directory !! WHERE SHOULD
> I FOUND THOSE MISSING FILES, SIMLINKS....

No need to shout, we hear you.

The error you are seeing are errors that comes from ld.so looking for
libs at various places before actually finding them. This is normal, and
certainly not what causes segmentation faults.

What could cause segmentation faults is the fact that the kernel you are
running would not really be patched with Xenomai. To know this, try
cat /proc/xenomai/version
on your board. If there is no such file, then you are not running Xenomai.

Another cause of problems could be that you enabled a problematic option.

In fact, to know really where the fault happens, you should be using
gdb, not strace.



-- 
					    Gilles.

