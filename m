Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BA5177.4050000@domain.hid>
References: <44B62AE7.8080503@domain.hid>	<1152930271.5027.69.camel@domain.hid>
	<44B8A1E9.7080004@domain.hid>	<44B8D412.1080002@domain.hid>
	<17593.4142.482000.586615@domain.hid> <44BA0A33.6060606@domain.hid>
	<44BA5177.4050000@domain.hid>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 11:25:20 +0200
Message-Id: <1153301120.5026.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2006-07-16 at 16:47 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > Based on this conversion is the optimisation patch -v4. There was
> > another quirk hidden in libpthread_rt which binds to RTDM "manually".
> > That's now also covered by the patch.
> 
> Grr, missing run-quilt-refresh-before-post.
> 

Applied, thanks.

> Jan
-- 
Philippe.



