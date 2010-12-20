Message-ID: <4D0FC9B3.5080805@domain.hid>
Date: Mon, 20 Dec 2010 22:25:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <613800.93095.qm@domain.hid>	<1292853709.2007.7.camel@domain.hid>	<957881.73468.qm@domain.hid>	<20101220154545.6E814CDE29A@gemini.denx.de>
	<326910.40840.qm@domain.hid>
In-Reply-To: <326910.40840.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting on ARM-11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Usama Masood <mirza.usama@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

Usama Masood wrote:
> thanks i will reply with some solid reasons .....
> my prcessor is S3C6410 (samsung) ARM1176

Ok. First of all, here we talk about Xenomai, we do not talk about RTAI.
If you are interested in running RTAI on this processor, you are asking
the wrong list. For some (admittedly biased) opinions on the Xenomai vs
RTAI question, see FAQ:
http://www.xenomai.org/index.php/FAQs#What_are_the_differences_between_Xenomai_and_RTAI.3F
This FAQ does not mention RTAI vs Xenomai on ARM, but..., well, I am
biased, so, I shut up.

Second, your question is an FAQ. This is FAQ #2:
http://www.xenomai.org/index.php/FAQs#Is_my_embedded_setup_supported_by_Xenomai.3F

Third, about porting the I-pipe patch on ARM, the architecture revision
(ARMv4, ARMv5, ARMv6, ARMv7) and the actual core (ARM920T, ARM926EJS,
ARM1136, or Cortex-A8) does not really matter, the terms ARM9, ARM11,
are even more meaningless, what really matters is the particular SOC for
which you want support, because the actual things that need be
integrated into the I-pipe patch are support for the hardware timer, and
GPIO demuxer if any, and these are not standard, neither for an
architecture revision, nor for an ARM core, these are SOC specific, or
if you are lucky, SOC family specific.

So, we have support for S3C24XX, if the support for the S3C SOC family
is sufficiently factored in the kernel code, chances are that it will be
easy to get it running on S3C6410. If not, then see the Howto which URL
is given in answer to FAQ #2. This howto is a bit outdated, especially
regarding GPIO demuxing. But if you get the timer running and post your
code, we will help you with the rest.

-- 
                                                                Gilles.

