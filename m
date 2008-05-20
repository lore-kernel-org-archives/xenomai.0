Message-ID: <48330D79.4060100@domain.hid>
Date: Tue, 20 May 2008 19:42:17 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>	<12036.62.39.72.60.1211212126.squirrel@domain.hid>	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<2ff1a98a0805200823w2694b107rf2bfd418ccda7ab8@domain.hid>
In-Reply-To: <2ff1a98a0805200823w2694b107rf2bfd418ccda7ab8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Fabien MAHOT <fabien.mahot@domain.hid>

Gilles Chanteperdrix wrote:
> On Tue, May 20, 2008 at 4:30 PM, Fabien MAHOT
> <fabien.mahot@domain.hid> wrote:
>> Thank you,
>>
>> I tried to use rt_fprintf(stderr) or rt_printf(), but there is no debug
>> traces on my Screen. But when I used fprintf(stderr) or printf(), there is
>> no problem, I ve got traces on my screen.
>> Compilation is good, I don't know why it doesn't work.
> 
> Neither do I. I am not very familiar with rt_printf.
Did you call 'rt_print_auto_init(1)'

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

