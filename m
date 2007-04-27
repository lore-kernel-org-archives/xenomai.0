Message-ID: <4632148D.4060401@domain.hid>
Date: Fri, 27 Apr 2007 17:19:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0704270747g122b5c84p1c4decbd31e2e4fe@domain.hid>
	<463211B8.7060509@domain.hid> <46321237.6080509@domain.hid>
In-Reply-To: <46321237.6080509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Benchmark for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Perrine Martignoni wrote:
>>
>>>Hello,
>>>
>>>I would like to know if you have a list of benchmark for the board
>>>CSB637 or a board with an ARM9.
>>
>>I sent a mail last week about some latencies result on the CSB637.
>>https://mail.gna.org/public/adeos-main/2007-04/msg00058.html
>>
>>
>>>I want to test performances of Xenomai with API Posix and I don't know
>>>how to begin.
>>
>>A starting point would be to compile Xenomai for your CSB637 board, and
>>run the "xeno-test" script. Among the tests run by the xeno-test script,
>>cyclictest uses the POSIX API and is equivalent to the native API
>>latency test. If you want other results than latency, I am afraid you
>>will have to write the tests yourself. But if you do so, we will be
>>pleased to add them to Xenomai.
> 
> 
> Here is some potential source for further benchmarks:
> 
> http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/
> 
> They were written for -rt Linux, but should (in theory) work for
> Xenomai's POSIX skin as well (haven't looked nor tried yet) -- except
> for tests that may use silly signals.

And for a little help on how to compile POSIX programs for Xenomai POSIX
skin, read:

http://svn.gna.org/viewcvs/xenomai/trunk/doc/txt/pse51-skin.txt?rev=&view=auto

-- 
                                                 Gilles Chanteperdrix

