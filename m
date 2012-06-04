Message-ID: <4FCC87DA.5010201@xenomai.org>
Date: Mon, 04 Jun 2012 12:03:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdbGSKTfoLS013KW4aoO=vs9qBwMWE5RhW5FVi=FmhAs_w@mail.gmail.com>	<8236197CA3DA864F9EF20609D9887263B7F87AF3@rrxchngmbx01.mro.roland-man.biz>	<CALH4Wdbq459W__cBmSsCGhBcE22UzsS1chSCC7xZpLAs--A8eA@mail.gmail.com>
	<4FCC8582.9080008@xenomai.org>
In-Reply-To: <4FCC8582.9080008@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] TCP communication problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 06/04/2012 11:53 AM, Philippe Gerum wrote:
> On 06/04/2012 11:33 AM, Frederik Bayart wrote:
>> Dietmar, thanks for hint. Indeed, I noticed that the number of bytes
>> sent != bytes to send.
>> If I wrap the send in a while lus, the problem is solved.
>>
>> Does anyone have a suggestion how to detect the interrupting signal
>> (SIG_ALL doesn't exist)
>>
> 
> Use strace.
> 
> It's likely SIGWINCH (aka SIGSHADOW for Xenomai), which we use internally.

SIGWINCH handler is normally installed with SA_RESTART flag...

-- 
					    Gilles.

