Date: Fri, 29 Apr 2016 22:03:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429200358.GR1881@hermes.click-hack.org>
References: <b17bf8bd-ee40-4976-9abf-801619a48fcc.john.zhang@motrotech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b17bf8bd-ee40-4976-9abf-801619a48fcc.john.zhang@motrotech.com>
Subject: Re: [Xenomai] the huge drift in Intel J1900
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "John.zhang" <john.zhang@motrotech.com>
Cc: xenomai <xenomai@xenomai.org>

On Fri, Apr 29, 2016 at 11:18:17AM +0800, John.zhang wrote:
> Dear all We have a project using xenomai 2.6.4 with Linux 3.14.17,
> the application needs to synchronize with extra clock. But we
> found that the clock drift is about 1600us/s, and we tests many
> company 's j1900 board, have the same problem and the same drift.
> =A0But i3/i5 cpu didn't have this problem.I guess J1900 doesn't
> support functions for xenomai, but I not sure.So could you please
> give us some suggestions about this problem.

I am not sure what you mean by "extra clock". If you mean Linux
clock corrected by NTP, then sorry, no, Xenomai clock and Linux
clock are not synchronized. The only way to get them synchronized is
to run clock_settime periodically, to realign Xenomai clock with
Linux clock, but note that the time jumps may have an effect on your
application if it uses Xenomai's CLOCK_REALTIME.

If Linux clock is not corrected with NTP, another issue which may
happen, asssuming that J1900 is an x86 is that Linux refines the TSC
frequency at the very end of the boot, a very long time after
Xenomai has used Linux frequency. If this is the case, you can avoid
this problem by using Xenomai HAL cpufreq and clockfreq parameters
(hardcoding the right value at boot time). There may be a way to
force the Linux kernel to compute the tsc frequency right away,
instead of refining it later, but I did not find it when I looked
for this issue. The clock_settime trick works too.

If you do not care of the desynchronization and want to read the
Linux clock from a thread running in primary mode, you can use the
CLOCK_HOST_REALTIME identifier with clock_gettime.

Regards.

--=20
					    Gilles.
https://click-hack.org

