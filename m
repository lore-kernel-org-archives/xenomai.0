Message-ID: <459A5E92.6030504@domain.hid>
Date: Tue, 02 Jan 2007 14:30:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>
In-Reply-To: <1167744149.30347.2.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: SVN checkin #2010
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
> 
>>Hi all - and happy new year,
>>
>>I haven't looked at all the new code yet, only the commit messages. I
>>found something similar to my fast-forward-on-timer-overrun patch in
>>#2010 and wondered if Gilles' original concerns on side effects for the
>>POSIX skin were addressed [1]. I recalled that my own final summary on
>>this was "leave it as it is" [2].
>>
> 
> 
> The best approach is to update the POSIX skin so that it does not rely
> on the timer code to act in a sub-optimal way; that's why this patch
> found its way in. Scheduling and processing timer shots uselessly is a
> bug, not a feature in this case.

There is some work to be done on the posix skin anyway, this will all be
at once. By the way, I tested the trunk on ARM, and I still get a lockup
when the latency period is too low. I wonder if we should not compare to
"now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "now".

-- 
                                                 Gilles Chanteperdrix

