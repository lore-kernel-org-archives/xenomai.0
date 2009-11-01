Message-ID: <4AED744E.7000306@domain.hid>
Date: Sun, 01 Nov 2009 12:43:10 +0100
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

According to the strace trace you sent me, mmap fails with an -ENODEV
error. Could you post your kernel configuration here?

And please stop sending mail in private.

-- 
					    Gilles.

