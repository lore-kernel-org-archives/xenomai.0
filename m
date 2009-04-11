Message-ID: <49E0F887.40805@domain.hid>
Date: Sat, 11 Apr 2009 22:07:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904111233180.32647@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> On Sat, 11 Apr 2009, Gilles Chanteperdrix wrote:
>> ...
>> So, in the mean time, you should not load the drivers and let xeno-test
>> load them once at a time when needed.
> 
> Thanks. This did indeed resolve the problem, and allowed all of the
> latency tests to run. Unfortunately the subsequent switchtest step
> appears to have completely hung the PC, but that could be a memory
> error, since I'm temporarily experimenting with Xenomai on an
> 8-year-old PC, and memtest86 occasionally flags a couple of marginal
> bytes of RAM on this PC. I'll receive a new computer in a couple of
> weeks.

We have just discovered that FPU handling on x86 had a few bugs, one of
them involving CPUs without fxsr (check /proc/cpuinfo). You can try and
apply commit 3a23967f3cc8d6881d8e3280130bbc431195aa31 from the for-head
branch of the git://git.xenomai.org/xenomai-gch repository. This is
fairly recent stuff, this is why it is not in any release.

-- 
					    Gilles.

