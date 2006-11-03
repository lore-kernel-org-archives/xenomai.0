Message-ID: <454B7AC1.9010305@domain.hid>
Date: Fri, 03 Nov 2006 11:22:09 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid> <4548F8BE.90809@domain.hid>
	<454901B6.80606@domain.hid> <454B0FA0.9080307@domain.hid>
	<454B1363.8080805@domain.hid> <454B15C5.1050803@domain.hid>
	<454B17A1.7000805@domain.hid> <454B345A.9050606@domain.hid>
In-Reply-To: <454B345A.9050606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
>>>>> I found the reason: "3-dimensional" memcpy (__memcpy3d/_mmx_memcpy)
> ... 
> True.
> 
> This patch fixes the issue for me.

Works for me as well on my Athlon64 X2 machine.

Many thanks for hunting this down, Jan.

-Jeff


