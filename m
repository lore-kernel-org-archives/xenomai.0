Message-ID: <4DB3CD6F.5050008@domain.hid>
Date: Sun, 24 Apr 2011 09:12:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimm_1HqM0tg9YL=y7ZKQBNH1=YgxA@mail.gmail.com>	<4DB3C542.7030700@domain.hid>
	<BANLkTi=dNEnxnBPO7T8rbJYhh040FQv-gw@domain.hid>
In-Reply-To: <BANLkTi=dNEnxnBPO7T8rbJYhh040FQv-gw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] apt-get mmap() error after upgrading to Xenomai
 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

at91_enthus wrote:
> On Sun, Apr 24, 2011 at 1:37 AM, Gilles Chanteperdrix
>> What FCSE options have you configured?
>>
> 
> FCSE mode (guaranteed)

That is probably the issue then. In guaranteed mode, a process can not
have an address space larger than 32MB. apt-get probably wants more than
that. If you enable CONFIG_ARM_FCSE_MESSAGES and this is indeed your
issue, you should see some message in the kernel logs (FCSE: process
%u(%s) VM would exceed the 32MB limit)

If this is the case, check the stack-size with ulimit -s and see if it
is still 1MB.

Please no private mails.

-- 
                                                                Gilles.

