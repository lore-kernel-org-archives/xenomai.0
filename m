Message-ID: <2ff1a98a0805050912m60cf9d03o308bec827236b10a@domain.hid>
Date: Mon, 5 May 2008 18:12:43 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <481F3110.1050407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <481F2B6A.802@domain.hid> <481F3110.1050407@domain.hid>
Subject: Re: [Xenomai-core] Houston, we have a circular problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

On Mon, May 5, 2008 at 6:08 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>  do_schedule_event() is the culprit when it reads the pending signals on the
>  shared queue (XNDEBUG check for rearming the timers),

A stupid suggestion: if we know that the spinlock is always locked
when calling do_schedule_event, maybe we can simply avoid the lock
there ?

-- 
 Gilles

