Message-ID: <2ff1a98a0710030114n2389e555m463ca62aec7a53fd@domain.hid>
Date: Wed, 3 Oct 2007 10:14:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710030752.l937qGqj004222@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710030022k3227b0b4g577085f802658e2a@domain.hid>
	<200710030752.l937qGqj004222@domain.hid>
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
Cc: Xenomai <xenomai@xenomai.org>

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
> Ok, but where is the tick handler?

ksrc/nucleus/intr.c, function xnintr_clock_handler.

-- 
                                               Gilles Chanteperdrix

