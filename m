MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18406.35139.331488.955183@domain.hid>
Date: Sun, 23 Mar 2008 17:45:55 +0100
In-Reply-To: <47E52BB2.5060709@domain.hid>
References: <47E4196F.2070303@domain.hid>
	<47E52BB2.5060709@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Fwd: Bug#471871: xenomai-runtime: bashism in
 /bin/sh script]
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Roland Stigge wrote:
 > Jan Kiszka wrote:
 > > Maybe someone with idle cycles left could have a look at this.
 > 
 > Idle? Preempted, at most!
 > 
 > Attached is what I will apply to the Debian version. Feel free to do as
 > well...

IMO, making the scripts sh compliant is worth the trouble: we do not
know what shell the users will use, this would give us maximum
compatibility.

-- 


					    Gilles.

