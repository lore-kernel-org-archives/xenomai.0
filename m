From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17593.4142.482000.586615@domain.hid>
Date: Sat, 15 Jul 2006 17:56:30 +0200
Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
In-Reply-To: <44B8D412.1080002@domain.hid>
References: <44B62AE7.8080503@domain.hid> <1152930271.5027.69.camel@domain.hid>
	<44B8A1E9.7080004@domain.hid> <44B8D412.1080002@domain.hid>
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
 > Jan Kiszka wrote:
 > > ...
 > > Ok, I will rework this patch.
 > > 
 > 
 > And here is -v2 (for post 2.2 trunk). It keeps the ABI but changes the
 > API wrt __xeno_mux_code. As this change gets widely caught by
 > xeno_user_skin_init, the modifications are limited.
 > 
 > At this chance I also converted the rtdm library to the generic
 > initialisation code. I tweaked nucleus/bind.h a bit so that one can
 > control via XENO_DISABLE_MLOCKALL_DETECTION if the related code gets
 > built into the lib. This appeared to be reasonable to me because librtdm
 > doesn't create its own RT threads, thus the check should be better left
 > to those skins who do so. Anyone any better idea, or is this acceptable?
 > If a separate patch is preferred, I will break out this change.

Another reason why rtdm did not use the generic initialization code is
that RTDM did not call exit upon failure to bind, and let a later call
to open fail. I do not know if it was desirable, but it was a feature of
the previous implementation.

-- 


					    Gilles Chanteperdrix.

