Message-ID: <4933099B.6000906@domain.hid>
Date: Sun, 30 Nov 2008 22:46:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
In-Reply-To: <493306F5.2080605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> I have written the attached test program to cancel Xenomai POSIX
> threads. The "calc_task" does some busy work, which the higher priority
> task "ctrl_task" interrupts and aborts after some time. The program does
> not behave like I expect and it also behaves differently on my PowerPC
> and ARM test system. The "calc_task" continues after calling
> pthread_cancel() in "ctrl_task". On ARM, the behaviour is even more
> wired. Is there anything wrong in my test program or anything else I
> should care of?

Hi Wolfgang,

before I delve into your program, did you read:
http://www.xenomai.org/documentation/trunk/html/api/group__posix__cancel.html
and
http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_09.html#tag_02_09_05
?


-- 
					    Gilles.

