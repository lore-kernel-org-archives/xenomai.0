References: <5734A9F8.10305@siemens.com>
 <20160512163142.GC18298@hermes.click-hack.org> <5734B43B.4040001@siemens.com>
 <20160512165904.GF18298@hermes.click-hack.org>
 <20160512171246.GG18298@hermes.click-hack.org> <5734BA9B.1030503@siemens.com>
 <20160512182049.GQ13285@hermes.click-hack.org> <5734CA76.5000606@siemens.com>
 <5734CCF8.5090508@xenomai.org> <5734CE80.60707@siemens.com>
 <5734D4B9.4070900@xenomai.org> <5734D92F.1000206@siemens.com>
 <57350331.1020302@xenomai.org> <57356C0E.6080205@siemens.com>
 <5735D8E0.3040202@xenomai.org> <5735F39A.8050204@siemens.com>
 <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57603B1C.6070301@siemens.com>
Date: Tue, 14 Jun 2016 19:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-06-14 17:23, Philippe Gerum wrote:
> Restoring the original behavior unconditionally would not be a fix but
> only a work-around for your own issue. Finding a better way acceptable
> to all parties is on my todo list for the upcoming 3.0.3.

An alternative design to a plain revert of the current->conforming
switch could be to enhance conforming to take the scheduling class into
account: SCHED_WEAK and SCHED_OTHER should have a NRT as conforming
domain while real-time scheduling classes obviously target RT. But I
didn't check yet what side effects that may have, nor if there could be
relevant impact on syscall performance (unlikely, though).

Jan


