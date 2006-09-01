From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17656.6803.336300.445867@domain.hid>
Date: Fri, 1 Sep 2006 13:33:39 +0200
Subject: Re: [Xenomai-core] v2.2.x broken (r1534)
In-Reply-To: <44F814F2.8070402@domain.hid>
References: <44F80898.3030203@domain.hid>
	<44F814F2.8070402@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Ignacio Garc~a P~rez wrote:
 > > Hi,
 > > 
 > > I just did a fresh checkout of the v2.2.x and it does not compile:
 > > 
 > > gcc: pthread_create: No such file or directory
 > > gcc: pthread_detach: No such file or directory
 > > gcc: pthread_setschedparam: No such file or directory
 > > gcc: pthread_getschedparam: No such file or directory
 > > gcc: pthread_yield: No such file or directory
 > > gcc: sched_yield: No such file or directory
 > > gcc: sem_init: No such file or directory
 > > gcc: sem_destroy: No such file or directory
 > > gcc: sem_post: No such file or directory
 > > ...
 > > 
 > > 
 > > Any idea of what's broken?
 > > 
 > 
 > Confirmed. Looks the me like the backport of the @file posix wrapping is
 > broken (rev #1525). If you want to dig deeper, compare with SVN head.

Looks like the autotools files needed to be re-generated. It should be
fixed by commit 1536.

-- 


					    Gilles Chanteperdrix.

