Message-ID: <4B951426.9040404@domain.hid>
Date: Mon, 08 Mar 2010 16:13:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201003021527.30130.sinisa.denic@domain.hid>
	<201003080858.11552.sinisa.denic@domain.hid>
	<4B950116.1020307@domain.hid>
	<201003081559.56967.sinisa.denic@domain.hid>
In-Reply-To: <201003081559.56967.sinisa.denic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM cached,non-cached memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sinisa Denic <sinisa.denic@domain.hid>
Cc: xenomai@xenomai.org

Sinisa Denic wrote:
> On Monday 08 March 2010 14:52:22 you wrote:
>> "write-combining does not guarantee that
>>
>>> the combination of writes and reads is done in the correct order"
> 
> 
> No, I've briefly read general description on wikipedia. :), so I don't know 
> wether it has impact on ARM arch.

As this is used by the kernel for its mapping (when you create aliases,
i.e. map the same area several times in the same address space), it must
work reliably. Anyway, what I am interested in is a quick test with your
application, measuring performances, so that we know whether
implementing this feature completely is worth the trouble, and in that
case, we will investigate further these issues.

-- 
					    Gilles.

