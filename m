From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17611.24301.996280.888596@domain.hid>
Date: Sat, 29 Jul 2006 15:13:17 +0200
Subject: Re: [Xenomai-core] cpu_set_t and friends undefined
In-Reply-To: <44CB4A1D.1090109@domain.hid>
References: <44CB312E.8090409@domain.hid> <44CB3685.6090006@domain.hid>
	<44CB4A1D.1090109@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Jan Kiszka wrote:
 > > Wolfgang Grandegger wrote:
 > >> Hello,
 > >>
 > >> with todays SVN version of Xenomai, the testsuite program
 > >> switchtest/switch.c does not compile because cpu_set_t and friends
 > >> (CPU_SET, ...) are not undefined. I'm using kernel version 2.4.25.
 > >>
 > >> Any idea what goes wrong. I haven't found where cpu_set_t is declared,
 > >> not even in Linux 2.4.17.7.
 > > 
 > > That's user-space stuff, in /usr/include/bits/sched.h on my box. Maybe
 > > some #ifndef __cpu_set_t_defined + local definition is required here.
 > > What glibc version do you use?
 > 
 > Ah, OK. The problem is with gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9),
 > which does not have cpu_set_t, indeed. The configure script already 
 > deals with different implementations of setaffinity. The attached patch 
 > fixes the problem. It removes CONFIG_SMP, which is not known to user 
 > space applications anyhow. Well, it might get defined in 
 > "src/include/xeno_config.h" somehow but I don't know how this could work 
 > properly without knowing the configured kernel tree.

The configure script has a --enable-smp option that set CONFIG_SMP in
xeno_config.h. sched_setaffinity is unneeded when not running over SMP
machine, so I thought it would be simpler to completely avoid
sched_setaffinity over UP machines.

The proper fix is to also define cpu_set_t when CONFIG_SMP is not set.
I will fix this.

-- 


					    Gilles Chanteperdrix.

