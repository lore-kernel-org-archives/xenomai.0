Message-ID: <486A3D87.3070702@domain.hid>
Date: Tue, 01 Jul 2008 16:21:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <176721864.20080701150033@domain.hid>
	<486A3915.7010506@domain.hid>
	<17310289306.20080701161704@domain.hid>
In-Reply-To: <17310289306.20080701161704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and TSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guido Moritz <guido.moritz@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Guido Moritz wrote:
> Thank you for this fast reply.
> 
> So I would like to enable TSC. But unfortunately it seems as if I am
> to stupid to understand the FAQ and what you mean with "selecting the processor
>  in kernel configuration which fits your processor". Please give me a
>  more detailed hint how to solve this. I'm sorry but I'm a newbie...

The kernel configuration proposes you several processor. Instead of 
selecting "Intel 386" or another processor without a TSC, just select 
the procesor you really have (AMD Athlon).

-- 
                                                  Gilles.

