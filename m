Message-ID: <4B73ED7A.9090803@domain.hid>
Date: Thu, 11 Feb 2010 12:43:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02581002110136x481f99cby7edbb811af7f905b@domain.hid>
In-Reply-To: <1f3e02581002110136x481f99cby7edbb811af7f905b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [ARM-MV88F6290] Xenomai 2.5.1 latency test
 results (still negative and huge)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey Didenko <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Sergey Didenko wrote:
> Hello
> 
> As a unit:
> 1) Board MV88F6290
> 2) Linux Kernel 2.6.29
> 3) Xenomai version 2.5.1
> 
> I have new latency test results for Xenomai 2.5.1!
> 
> I adjusted /proc/xenomai/latency value for kernel mode from 9503 to 5099
> (making minimum latency more close to 0)
> And there is a big difference (in comparission with xenomai 2.4.9 version)
> in case of user-mode, with xenomai 2.4.9, adjusted value was 4400, but with
> xenomai 2.5.1 I have to set it to 44300 (! 10 times bigger) to get the
> minimum latency very close to 0.
> All test for user mode I did with value /proc/xenomai/latency = 0
> All test for kernel mode I did with value /proc/xenomai/latency = 5100

I can confirm that Xenomai is working well on other ARM platforms. So,
this issue is specific to your platform. Look for the bug in your code.


-- 
					    Gilles.

