From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
Date: Fri, 26 May 2006 20:03:47 +0200
References: <446F852B.7090400@domain.hid>
	<200605261944.18514.niklaus.giger@domain.hid>
	<17527.16296.557740.403770@domain.hid>
In-Reply-To: <17527.16296.557740.403770@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262003.47584.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Freitag, 26. Mai 2006 19:49 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Do you have any clue? (Doubling the stack in vm/thread.cc didn't help.)
>
> Automatic re-building does not work for the simulator. So, in case of
> segmentation fault, try:
>
> make clean all check
Yes, I noticed this as I was looking for a compile of thread.cc. Therefore I 
did a clean rebuild (but a little bit different than your receipt). After 
rebuilding using "make clean all check" under sim and 
sim/skin/posix/testsuite, I still get the same failure.

Regards
-- 
Niklaus Giger

