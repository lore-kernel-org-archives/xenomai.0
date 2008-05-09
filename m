Message-ID: <48241DA5.2030504@domain.hid>
Date: Fri, 09 May 2008 11:47:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4824197E.90709@domain.hid>
	<2ff1a98a0805090235t2f3c46a2vb19a4ccc7c2157b@domain.hid>
In-Reply-To: <2ff1a98a0805090235t2f3c46a2vb19a4ccc7c2157b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged
	target	exits
Reply-To: rpm@xenomai.org
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Fri, May 9, 2008 at 11:29 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> +       if (xnthread_test_info(thread, XNDEBUG))
>> +               unlock_timers();
>> +
> 
> Will this work if several threads are currently being debugged ?
> 

Yes, because we freeze timers when a thread receives a ptracing signal, so any
remaining thread entering a breakpoint/stepping next will trigger a freeze anew.

-- 
Philippe.

