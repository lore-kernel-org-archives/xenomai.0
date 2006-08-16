From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
Date: Wed, 16 Aug 2006 19:37:08 +0200
References: <200608150949.30029.niklaus.giger@domain.hid>
	<200608152056.51541.niklaus.giger@domain.hid>
	<17635.7248.269603.523155@domain.hid>
In-Reply-To: <17635.7248.269603.523155@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161937.10372.niklaus.giger@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Am Mittwoch, 16. August 2006 15:23 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Am Dienstag, 15. August 2006 20:14 schrieb Jan Kiszka:
>  > > Niklaus Giger wrote:
>  > > > Hi
> Will try to improve this... I also have a small remark: I think
> htmlified logs would be easier to read if it was possible to jump from
> error to error. The following bash snippet allow to create such a
> browsable log file from the plain text log file. Attached an example of
Yes, I remember that you suggested this approach a while ago. Unfortunatly 
buildbot up to the current version 0.7.3 has no facility to present a build 
log in any other way as a text file (HTML escaped).
In the buildbot trunk there are now possiblities to add a LogObserver. I will 
give it a try as soon as I have some spare hours.

Nice to find the simulator testsuite working fine again!

Best regards

-- 
Niklaus Giger

