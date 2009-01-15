Message-ID: <496F1EAC.2050801@domain.hid>
Date: Thu, 15 Jan 2009 12:31:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid> <496F1041.20306@domain.hid>
	<496F1745.2000401@domain.hid>
In-Reply-To: <496F1745.2000401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> currently I have the following six patches in my assorted queue
>>> (git://git.kiszka.org/xenomai.git queue/assorted). All have been posted
>>> before, I just rebased them since then a few times. Should I repost
>>> any/all of them (would be no problem), or are some already queued for
>>> potential merge?
>>>
>>> Jan
>>>
>>> (...)
>>> commit a631ab2c531d5e381ba8a0a59bf301a0276d9f99
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>>
>>>     POSIX: Do not auto-shadow main with dlopen enabled
>>>     
>>>     Don't perform auto-shadowing in POSIX skin if we might be loaded via
>>>     dlopen. Otherwise the wrong thread, the undefined dlopen caller, may be
>>>     (re-)shadowed, assigning wrong scheduling settings.
>>>     
>>>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>>  src/skins/posix/init.c |   43 ++++++++++++++++++++++++++++---------------
>>>  1 files changed, 28 insertions(+), 15 deletions(-)
>>>
>>> commit 91ae3da822ca558804bf33be4d164ea4c2667c1b
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>>
>>>     Replace --without-__tread with --enable-dlopen-skins
>>>     
>>>     In practice, you only want to disable __thread support when Xenomai skin
>>>     libraries should be loadable via dlopen. Therefore rename the related
>>>     configure switch accordingly.
>>>     
>>>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>> Nack these two ones: one of the gcc bugs I have found on ARM is related
>> to __thread (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=38815). So,
>> even though I have found a work around for the bug, I am not sure that
>> it works all the time, so disabling __thread on ARM is safer. Especially
>> since __thread does not bring any performance improvement over
>> pthread_(get|set)specific on ARM.
> 
> Actually, I am not opposed to the first, only to the second.

OK, will you or should I apply the do-not-auto-shadow patch?

Regarding the second one: If the option should continue to be named
--without-__thread (because of ARM), then we need at the bare minimum a
documentation of the correlation with dlopen. BTW, any concerns to apply
the "Mark libs nodlopen" fix?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

