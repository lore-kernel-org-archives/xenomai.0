Message-ID: <4D23BEF7.9080301@domain.hid>
Date: Wed, 05 Jan 2011 01:44:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>	<4D1F4BA4.6090000@domain.hid>	<AANLkTik-H5J-Wp=6Oc8ne_G+m=qzWyUTDTNdUiLjUJPt@domain.hid>	<4D1FA645.1000101@domain.hid>	<AANLkTim1wpPyNNUFWot0KRVZoQTz1fwxuyP259VrkHiU@mail.gmail.com>	<1294068560.1837.72.camel@domain.hid>	<1294069047.1837.79.camel@domain.hid>	<AANLkTinfZLuYCBuqiUZLBoRYagwu0S6q9DSESouWFZrP@mail.gmail.com>	<4D222F88.9000905@domain.hid>
	<AANLkTi=9y6c=pmS1jg3xNTbzygUjMDBJOfoudhLTTAtw@domain.hid>
In-Reply-To: <AANLkTi=9y6c=pmS1jg3xNTbzygUjMDBJOfoudhLTTAtw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with Installation. Error message in
 xeno-test: "Xenomai: /dev/rtheap is missing".
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexandre Oliveira <alexandrenagy@domain.hid>
Cc: xenomai@xenomai.org

Alexandre Oliveira wrote:
> Well, I did some changes and the problem still remain. I'm posting for
> updating.
> I choosed Pentium 4 processor.

Good.

> 
> CONFIG_APM disable.
> CONFIG_ACPI_PROCESSOR disable.
> CONFIG_CPU_FREQ disable.
> CONFIG_INPUT_PCSPKR disable.
> SMI disable (like before).

Please try the default setting for SMI (only detection), you are
supposed to be only try disabling SMIs if you have unexplained latency
issues with Xenomai, so, it is premature to enable it while Xenomai is
not even starting.

> 
> The difference between the later ones is:
> Before, I disabled all ACPI. Now, I just disabled that ones at the FAQ.

That is precisely the thing that I found was wrong in your
configuration, and I had hope that enabling the ACPI would allow the cpu
frequency to be detected correctly. Note that I do not even know how cpu
frequency is detected on x86.


> CONFIG_CPU_FREQ was disabled.
> 
> So, when I boot the new kernel, the /proc/cpuinfo returns 0.00 of CPU
> Frequency again...
> 
> The problem is the error at identifying the processor.
> The new /proc/cpuinfo returns only one processor... not the both nucleus,
> like that one up here.

You mean the two cores? That is probably because you disabled
CONFIG_SMP. If CONFIG_SMP is not disabled, please post the full kernel log.

What you can try is with exactly the same configuration which fails with
Xenomai (if it still fails when not disabling SMIs), is use this same
configuration, only disable CONFIG_XENOMAI and CONFIG_IPIPE and tell us
whether the frequency is right.

NB: on Xenomai mailing lists, we are more used to the traditional usenet
way of quoting the relevant part of the mail we answer and answering
under, than the MS-outlook style top-posting.

-- 
                                                                Gilles.

