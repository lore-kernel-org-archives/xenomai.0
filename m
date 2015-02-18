Message-ID: <54E4D14E.1060104@siemens.com>
Date: Wed, 18 Feb 2015 18:52:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] arm: Late delivery of pending Linux signals?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Gilles,

I noticed on ARM (AM335 TI board) that the SIGDEBUG if the related test
apparently only gets delivered to the receiver after it invokes a
syscall, not on return from its secondary mode migration. Therefore the
page fault test of the sigdebug smokey test fails (tested with Xenomai
3), and I bet the watchdog test as well. Is this a known limitation?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

