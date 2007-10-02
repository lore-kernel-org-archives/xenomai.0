Message-ID: <2ff1a98a0710020211r15932aafheffb53d55a7d1691@domain.hid>
Date: Tue, 2 Oct 2007 11:11:48 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710020904.l9294G6p027811@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6EB3AFE7F3632E4BA457E506E6DAF4F61451A2@domain.hid>
	<200710020904.l9294G6p027811@domain.hid>
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

On 10/2/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Hi,
>
>
>
> I'm using Xenomai 2.3.4 with 2.6.20 kernel on an ARM PXA270 board.
>
> The installation was executed successfully.
>
>
>
> Now I'm trying to insert a small test module (source code is attached) but the kernel crashes on rt_task_start().
>
> I have tried the same module on another x86 machine and there is no problem.
>
> I have tried with or without rt_task_set_periodic in aperiodic and periodic timer mode but the result is the same.
>
>
>
> Do you have an idea?

Do you observe the same behaviour with the latency test ?

-- 
                                               Gilles Chanteperdrix

