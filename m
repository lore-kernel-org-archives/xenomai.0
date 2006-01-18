From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.1996.293519.413160@domain.hid>
Date: Wed, 18 Jan 2006 10:18:04 +0100
Subject: Re: [Xenomai-core] Scheduling while atomic
In-Reply-To: <fd6a47a90601171559x13acf2c2m@domain.hid>
References: <fd6a47a90601171559x13acf2c2m@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jeroen Van den Keybus wrote:
 > Gilles,
 > 
 > 
 > I cannot reproduce those messages after turning nucleus debugging on.
 > Instead, I now either get relatively more failing mutexes or even hard
 > lockups with the test program I sent to you. If the computer didn't crash,
 > dmesg contains 3 Xenomai messages relating to a task being movend to
 > secondary domain after exception #14. As when the computer crashes: I have
 > written the last kernel panic message on a paper. Please tell if you want
 > also the addresses or (part of) the call stack.

Could you try adding a call to mlockall(MCL_CURRENT|MCL_FUTURE) ? 

Also note that you do not need protecting accesses to file descriptor
with rt_mutexes. stdio file descriptor are protected with pthread
mutexes, and pthread mutexes functions cause threads migration to
secondary mode. And unix file descriptor are passed to system calls,
which also cause migration to secondary mode.

-- 


					    Gilles Chanteperdrix.

