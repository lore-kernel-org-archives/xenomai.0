Message-ID: <4AEC1A8C.5030809@domain.hid>
Date: Sat, 31 Oct 2009 12:07:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <64f64b850910310221v2148ed6dqc4a05ccd8ec7030f@domain.hid>
In-Reply-To: <64f64b850910310221v2148ed6dqc4a05ccd8ec7030f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] queue on the uclinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Romannikov <rom2006@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Romannikov wrote:
> Hello!
> I've have problem with queues on the uclinux. queue was created without
> errors (returned zero) (queue was created in the kernel space), but I cannot
> bind it in user space (always returned -12 - cannot allocate memory). the
> same story with heap.
> I use uClinux 2009R1, bf537 and xenomai 2.4.7.
> best regards,
> Dmitry Romannikov.

rt_heap_bind and rt_queue_bind both use the mmap call which is probably
not available under uclinux. Maybe we could fix the code to use directly
the kernel-space address in user-space, this should work with uclinux?

-- 
					    Gilles.

