Message-ID: <4D80BADD.9090301@domain.hid>
Date: Wed, 16 Mar 2011 14:27:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FA526D37A62FA141B5D2D8700F5167C83D79AE3E1A@ICTS-S-EXC4-CA.luna.kuleuven.be>
In-Reply-To: <FA526D37A62FA141B5D2D8700F5167C83D79AE3E1A@ICTS-S-EXC4-CA.luna.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [solved]:  Xenomai Posix skin init,
 device or resource busy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lin Zhang <Lin.Zhang@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Lin Zhang wrote:
> Dear all,
> 
> Last week I had "Device or resource busy" error when I run my
> program, yesterday I found a solution. (Only for my application,but
> could be helpful for someone else..).
> 
> When building xenomai, I used "./configure --enable-dlopen-skins ..",
> which is not necessary for my application. So I just rebuilt xenomai
> without this option.
> 
> Thanks again for Gilles' warm help. :)

Ok. Thanks for telling us. Maybe you could have answered my last answer
and we could have helped you solve this issue faster?

Anyway, standard tests such as latency, at least, should work with
--enable-dlopen-skins. So, it seems we have a bug to fix.

Regards.

-- 
					    Gilles.

