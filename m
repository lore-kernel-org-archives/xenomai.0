Subject: Re: [Xenomai-core] x86_64 - Initial results.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702251842.25248.paul_c@domain.hid>
References: <200702241526.22786.paul_c@domain.hid>
	<200702251557.19205.paul_c@domain.hid> <45E1B345.4050304@domain.hid>
	<200702251842.25248.paul_c@domain.hid>
Content-Type: text/plain
Date: Sun, 25 Feb 2007 23:00:30 +0100
Message-Id: <1172440830.12230.56.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Sun, 2007-02-25 at 18:42 +0000, Paul wrote:

> Results are still the same - Latency goes to pot and hangs as soon as X starts 
> up. Quite likely the offending trace isn't getting logged..
> 

Just for the purpose of digging the issue further, does this particular
problem persist when MTRRs are switched off from the kernel config?

-- 
Philippe.



