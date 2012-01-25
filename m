Message-ID: <4F202F4E.6000708@domain.hid>
Date: Wed, 25 Jan 2012 17:35:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F202C11.70908@domain.hid>
In-Reply-To: <4F202C11.70908@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add sigdebug unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 01/25/2012 05:21 PM, Jan Kiszka wrote:
> We had two regressions in this code recently. So test all 6 possible
> SIGDEBUG reasons, or 5 if the watchdog is not available.

Ok for this test, with a few remarks:
- this is a regression test, so should go to
src/testsuite/regression(/native), and should be added to the
xeno-regression-test
- we already have a regression test for the watchdog called mayday.c,
which tests the second watchdog action, please merge mayday.c with
sigdebug.c (mayday.c also allows checking the disassembly of the code in
the mayday page, a nice feature)
- please make the watchdog test mandatory by default (adding a command
line option to skip it for instance), the test should fail if the
watchdog is not enabled, because otherwise, it will be easy to forget
testing this feature. The wathdog is enabled by default with xenomai 2.6
anyway.

-- 
					    Gilles.

