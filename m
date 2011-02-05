Message-ID: <4D4DD669.5040009@domain.hid>
Date: Sat, 05 Feb 2011 23:59:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.9723.1296855625.10284.xenomai@xenomai.org>		<000001cbc4b0$03297d50$097c77f0$@de>	<1296858744.2087.44.camel@domain.hid>
	<000001cbc56a$e6237600$b26a6200$@de>
In-Reply-To: <000001cbc56a$e6237600$b26a6200$@de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
 code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

Franz Engel wrote:
> Then I get the following message:
> patching file arch/x86/kernel/process.c
> Hunk #1 succeeded at 550 with fuzz 1 (offset -87 lines).
> Hunk #2 FAILED at 657.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/x86/kernel/process.c.rej
> 
> Did I do something wrong?

Yes, you probably saved the patch to disk by a mean which replaced the
tab character with spaces and causes patch to fail.
To avoid trouble, you should save the mail containing the patch verbatim
to disk.

Please do not top-post.

-- 
                                                                Gilles.

