From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17428.19764.670152.736415@domain.hid>
Date: Sun, 12 Mar 2006 17:32:52 +0100
Subject: Re: [Xenomai-core] PRNG not seeded on AMD K7
In-Reply-To: <17428.17217.209048.769283@domain.hid>
References: <fd6a47a90603120709k2dcc2a4h@domain.hid>
	<17428.17217.209048.769283@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
 > Jeroen Van den Keybus wrote:
 >  > When I try to open an ssh connection to or from a PC running Xenomai, I get
 >  > a 'PRNG not seeded' error. However, it only occurs when an RT application is
 >  > running (such as 'latency'). The computer on which this occurs is an AMD
 >  > K7-650. I've tested on a Pentium III 500 as well (nearly same .config) and
 >  > this error doesn't show up then.
 >  > 
 >  > Any idea of where I should start debugging ? I assume that PRNG stands
 >  > for 'Programmable Random Number Generator' or something like that.
 > 
 > See in kernel configuration if you have the CONFIG_HW_RANDOM option
 > enabled, if the module is loaded when the error occurs, and if
 > /dev/urandom exists.

CONFIG_HW_RANDOM is for the /dev/hwrandom device, and libssl uses
/dev/random or /dev/urandom. /dev/urandom is seeded at boot-time
by a script (/etc/init.d/urandom on Debian).

So FPU hardware, as mentioned by Philippe, is a better candidate.

-- 


					    Gilles Chanteperdrix.

