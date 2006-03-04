From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.56427.921076.682990@domain.hid>
Date: Sat, 4 Mar 2006 19:28:59 +0100
Subject: Re: [Xenomai-core] Xenomai v2.1-rc4
In-Reply-To: <4409B56B.4000501@domain.hid>
References: <4409B56B.4000501@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
 > 
 > This time, the merge window is closed for good; no kidding. This said, too many 
 > changes since -rc3 have taken place for releasing v2.1 without one more -rc 
 > iteration, so here is -rc4. Major updates are as follows:
 > 
 > - scalable timer management using non-linear access (Gilles)
 > - shared real-time interrupt support (Dmitry)
 > - POSIX updates (Gilles)

These updates broke POSIX message queues support. Repository revision
659 fixes it.

-- 


					    Gilles Chanteperdrix.

