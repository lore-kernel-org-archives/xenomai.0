Message-ID: <4C4FEF61.4090301@domain.hid>
Date: Wed, 28 Jul 2010 10:50:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <638179785.1790459.1280306472842.JavaMail.fmail@domain.hid>
In-Reply-To: <638179785.1790459.1280306472842.JavaMail.fmail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deadlock with interrupt shield activated / Avoid
 mode switches at compile time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus Seemann <International-Asso@domain.hid>
Cc: xenomai@xenomai.org

Markus Seemann wrote:
> Hello,
> 
> a more theoretical question:
> 
> Is it possible to provocate a deadlock while switching a RTTask from
> primary mode to secondary mode when the interrupt shield is
> activated? Perhaps with this kind of scenario: - linux process takes
> semaphore - RTTask switches to secondary mode and also tries to take
> this semaphore - The semaphore would be released in ISR context of
> the linux kernel. But the interrupt shield prevents the execution of
> this isr.
> 
> How realistic is this scenario?

Does not look very realistic, but it is possible. Anyway, the interrupt
shield no longer exists in Xenomai 2.5.

> 
> 
> Another question: Is it possible to avoid mode switches for realtime
> tasks at compile time for a specific task?

No. But we provide a way to detect and act upon them at run-time.

When a switch to secondary mode happens, it is necessary to get the task
to continue running, so, the only way to handle such situation would be
to destroy the task in need for a switch to secondary mode.

-- 
					    Gilles.

