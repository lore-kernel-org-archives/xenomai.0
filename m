Message-ID: <48241C06.4040105@domain.hid>
Date: Fri, 09 May 2008 11:40:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4824197E.90709@domain.hid>
	<2ff1a98a0805090235t2f3c46a2vb19a4ccc7c2157b@domain.hid>
In-Reply-To: <2ff1a98a0805090235t2f3c46a2vb19a4ccc7c2157b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged target
	exits
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
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Fri, May 9, 2008 at 11:29 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> +       if (xnthread_test_info(thread, XNDEBUG))
>> +               unlock_timers();
>> +
> 
> Will this work if several threads are currently being debugged ?

Not better or worse than with the current code. The whole approach is
not fixed by this patch, just some collateral damage is reduced.

Well, maybe some counter should be used to track the number of XNDEBUG
bits in the system and unfreeze the timers when that becomes zero. Will
look into this.

Jan

