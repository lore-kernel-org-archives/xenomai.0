MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18047.40395.671989.328415@domain.hid>
Date: Mon, 25 Jun 2007 12:49:47 +0200
In-Reply-To: <467F5CBF.9040108@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid> <1182708919.7044.201.camel@domain.hid>
	<467F5CBF.9040108@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
 > Ok, I think it's time to summarise some results of this thread:
 > 
 >  - xntimers will be of three kinds: real-time absolute, monotonic
 >    absolute, and monotonic relative ones (ie. all POSIX). I'm currently
 >    in favour of passing this property on timer start and not pushing
 >    parts or more of it into timer init.

The posix skin can live without monotonic absolute timers: monotonic
timeout could simply be converted to relative timeouts.

-- 


					    Gilles Chanteperdrix.

