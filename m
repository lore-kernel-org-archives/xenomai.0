Message-ID: <4A2669AA.60600@domain.hid>
Date: Wed, 03 Jun 2009 14:16:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <103585745.148571244020625685.JavaMail.root@domain.hid>
In-Reply-To: <103585745.148571244020625685.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to chose between xenomai and preempt RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LECOINTRE <adrien20@domain.hid>
Cc: xenomai@xenomai.org

Adrien LECOINTRE wrote:
> I read a lot of things about PREEMPT_RT not providing hard real-time
> but I coudn't find any test case which shows that. My loads are
> probably not good enough but it shouldn't be so difficult to find a
> way to cause a significant latency on a supposed non-hard-real-time
> OS.

I can not leave this unanswered. This is a question of code coverage.
Only when you have tested most of the code paths in the Linux kernel can
you state that you have made a proper test. The only way to do this
found so far (by the preempt_rt people, I believe) is to run LTP, the
Linux Testing Project. And even though you do not test all the drivers
in your system (except the most current ones such as ethernet and ATA).

-- 
					    Gilles.

