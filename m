Message-ID: <49F69924.8070001@domain.hid>
Date: Tue, 28 Apr 2009 07:50:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] xenomai 2.5 rc1 timing computations.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

currently, the situation is this:
- the timing core uses an approximate value of the cpu frequency (using
xnarch_llmulshft) to do conversions between tsc and ns;
- the APIC timer reprogrammation still uses imuldiv, that is a more
exact cpu frequency, coupled with an approximate APIC frequency
(obtained from ipipe_request_tickdev), to do the conversion between tsc
delays and APIC delays;
- the posix skin uses llimd to do conversions between timespec and
timeval structures and tsc values
- the posix and native skins in user-space still use llimd to do
conversions between ns and tsc (only if using tsc in user-space).

These are causes of unprecisions, I think we should fix this, though it
is unlikely to be the cause of the high jitters observed by Vikesh with
2.5-rc1.

Regards.

-- 
					    Gilles.

