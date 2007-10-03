Message-ID: <2ff1a98a0710030022k3227b0b4g577085f802658e2a@domain.hid>
Date: Wed, 3 Oct 2007 09:22:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710030658.l936wbwS020794@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710020529y44e79653id63ad9cf0419ceb9@domain.hid>
	<200710030658.l936wbwS020794@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
>
> No I have not a JTAG probe.
>
> But I found that the system crashes when the xnlock_put_irqrestore function
> is called in the task.c file at (in rt_task_create function).

Ok, next step is to put a printk (or better a printascii) in the tick
handler to check if the timer interrupt is ticking ?

-- 
                                               Gilles Chanteperdrix

