Message-ID: <51122E82.6050209@siemens.com>
Date: Wed, 06 Feb 2013 11:20:50 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] i8253 clocksource vs. rthal_get_8254_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Gilles,

I just realized that there is now a 8253 clocksource in core-3.4+. How
does this work together with Xenomai's TSC emulation via the 8254 in the
x86 hal_32? Xenomai reprograms the PIT in rthal_setup_8254_tsc - is this
harmless?

I came across this while trying to get rid of Xenomai's "depends on
!INPUT_PCSPKR" to avoid that circular Kbuild dependency.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

