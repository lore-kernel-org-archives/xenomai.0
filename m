Message-ID: <4C90B49C.4000704@domain.hid>
Date: Wed, 15 Sep 2010 13:57:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>	<1284478817.2345.5.camel@domain.hid>	<76E258664B189C4CBEF125491CA11ECC945B6553D5@domain.hid>	<4C9092BE.4050206@domain.hid>	<76E258664B189C4CBEF125491CA11ECC945B6553D6@domain.hid>
	<AANLkTinHWE01hmvM_zAEbcYX_ccyoVchB4YoUeAGYZAo@domain.hid>
In-Reply-To: <AANLkTinHWE01hmvM_zAEbcYX_ccyoVchB4YoUeAGYZAo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
 CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Zafar Iqbal <Zafar.Iqbal2@domain.hid>

Willy Lambert wrote:
> As a suggestion this is what I use :
> 
> 
> Power management and ACPI Options ---> disable all options, including 
> into CPU Frequency scaly (disable the first line CPU Frequency Scaling)

This is a bad advice. You should not disable ACPI. Only ACPI_PROCESSOR
is dangerous.

The options to be disabled are explicitely mentioned in the error
messages...

-- 
					    Gilles.

