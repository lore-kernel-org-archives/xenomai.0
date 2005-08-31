From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 15:40:09 +0200
Message-Id: <1125495609.4643.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

I've forward ported
	adeos-linux-2.6.10-ppc-r8c2.patch
	adeos-linux-2.6.12-i386-r13c1.patch
to a fresh 2.6.13 kernel.

The i386 patch port was quite trivial, except for a few code changes.
However, I had to modify the ADEOS_PREEMPT_RT definition to:
+config ADEOS_PREEMPT_RT
+       def_bool PREEMPT_VOLUNTARY || PREEMPT_DESKTOP || PREEMPT_RT
+
(removed the PREEMPT_NONE from the def_bool definition) in order to make
it build on a regular, non PREEMPT_RT kernel (or else the compilation
would fail on a raw_spinlock_t undefined error). I think this problem
exists in the 2.6.12 patch as well.

The ppc patch was a bit more tricky, but I think I got all of it right.
It works ok most of the time (RTAI fusion testsuite passes for example -
on a G4 Powerbook), but it hangs the machine hard sometimes. I am not
sure if the problem is due to the port or if it is present in the 2.6.10
version as well.

The two patches are at:
	http://www.popies.net/tmp/adeos-linux-2.6.13-i386-r13c1.patch
	http://www.popies.net/tmp/adeos-linux-2.6.13-ppc-r8c2.patch

Stelian.
-- 
Stelian Pop <stelian.pop@domain.hid>


