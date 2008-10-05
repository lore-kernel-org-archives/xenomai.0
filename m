Message-ID: <48E8B5E5.8040602@domain.hid>
Date: Sun, 05 Oct 2008 14:41:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid> <48E8AFB4.4040208@domain.hid>
	<48E8B29D.5040705@domain.hid>
In-Reply-To: <48E8B29D.5040705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:	ChangeLog
 src/skins/native/task.c
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

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Author: gch
>>> Date: Sat Oct  4 23:11:09 2008
>>> New Revision: 4210
>>>
>>> URL: http://svn.gna.org/viewcvs/xenomai?rev=4210&view=rev
>>> Log:
>>> Call __real_pthread_setschedparam in order to inform the libc of the scheduling parameters change.
>> Well, I dropped this idea after realizing that it will kick us out of
>> primary mode in all cases. This change is an improvement (/wrt Linux
>> scheduling accuracy) for borderline threads, but it will cause
>> regressions for primary-only threads. I have no idea right now how to
>> make both happy, at least without explicit pthread_setschedparam
>> invocations by the user application.
> 
> Well, we discussed this on the xenomai mailing list, you did not answer,
> so we assumed you agreed.

I meant xenomai-core.
https://mail.gna.org/public/xenomai-core/2008-10/msg00005.html

-- 
					    Gilles.

