From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <573204D1.4060202@siemens.com>
Date: Tue, 10 May 2016 17:57:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Resuming nanosleep & Co. after ignored signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

originally, this effect was only reported for debugged applications, but
I think it affects more:

clock_nanosleep (as well as nanosleep and sleep) should return -EINTR if
they were interrupted by signal while sleeping. OK. But what if that
signal was SIGSTOP, maybe even related to ptrace? Right now the function
just bails out, and applications behave differently from native Linux.
There we resume the sleep transparently if the signal is not delivered
to some handler (or actually terminates the process).

How could we model this properly with Xenomai? And could there be more
services affected than clock_nanosleep?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

