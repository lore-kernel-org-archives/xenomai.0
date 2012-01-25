Message-ID: <4F203353.8030302@domain.hid>
Date: Wed, 25 Jan 2012 17:52:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F202C11.70908@domain.hid> <4F202F4E.6000708@domain.hid>
	<4F203237.2010102@domain.hid>
In-Reply-To: <4F203237.2010102@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On 2012-01-25 17:47, Jan Kiszka wrote:
> On 2012-01-25 17:35, Gilles Chanteperdrix wrote:
>> On 01/25/2012 05:21 PM, Jan Kiszka wrote:
>>> We had two regressions in this code recently. So test all 6 possible
>>> SIGDEBUG reasons, or 5 if the watchdog is not available.
>>
>> Ok for this test, with a few remarks:
>> - this is a regression test, so should go to
>> src/testsuite/regression(/native), and should be added to the
>> xeno-regression-test
> 
> What are unit test for (as they are defined here)? Looks a bit inconsistent.
> 
>> - we already have a regression test for the watchdog called mayday.c,
>> which tests the second watchdog action, please merge mayday.c with
>> sigdebug.c (mayday.c also allows checking the disassembly of the code in
>> the mayday page, a nice feature)
> 
> It seems to have failed in that important last discipline. Need to check
> why.

Because it didn't check the page content for correctness. But that's now
done via the new watchdog test. I can keep the debug output, but the
watchdog test of mayday looks obsolete to me. Am I missing something?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

