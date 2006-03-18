From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17436.15610.520266.321408@domain.hid>
Date: Sat, 18 Mar 2006 18:01:46 +0100
Subject: Re: [Xenomai-core] get the simulator running...
In-Reply-To: <441C2574.4030901@domain.hid>
References: <441C2574.4030901@domain.hid>
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
 > Philippe,
 > 
 > here are some patches and comments on the simulator "quick"-start
 > process. I guess the patches are due to latest changes in trunk, and I
 > cannot guarantee that they are clean - but the simulator compiles now.
 > 
 > Regarding the rest of its build and start process: There are two hidden
 > requirements, namely gcc < 4 (due to -fwritable-strings) and gdb 5.x. A
 > note in sim/README about them would be great. Or do you have a fix for
 > those issues scheduled?

which version of gdb did you try ? version 6.3 works here.

-- 


					    Gilles Chanteperdrix.

