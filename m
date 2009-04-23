Message-ID: <49F05891.8040408@domain.hid>
Date: Thu, 23 Apr 2009 14:01:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
In-Reply-To: <1240482629.7599.45.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] adeos patch 2.6.28.9-x86-2.2-07 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vikesh Rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Vikesh Rambaran wrote:
> I am going to test with CONFIG_NO_HERTZ and ACPI_PROCESSOR disabled
> as per Gilles suggestions on other emails.

Yes, you should disable ACPI_PROCESSOR. I am surprised that it is not
already done, because it is (or should be) written everywhere.

As for CONFIG_NO_HZ, CONFIG_NO_HZ works correctly with Xenomai, it had a
bug on ARM on 2.6.26, but the bug was specific to ARM (actually specific
to architectures with unlocked context switches), I was only asking
Martin to test this because his bug looked like the NO_HZ bug on ARM,
but Martin's problem turned out to be with CONFIG_X86_PM_TIMER, so is
completely unrelated to NO_HZ.

-- 
                                                 Gilles.

