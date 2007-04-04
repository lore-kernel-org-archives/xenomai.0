Subject: Re: [Xenomai-core] missing native/ppd.h header
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200704042334.13738.paul_c@domain.hid>
References: <200704042334.13738.paul_c@domain.hid>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 00:42:31 +0200
Message-Id: <1175726551.26385.7.camel@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2007-04-04 at 23:34 +0100, Paul wrote:
> Hi Philippe
> 
>  Just tried to compile from r2361 in trunk, but `make dist` is failing due to 
> include/native/ppd.h not present - Perusing the change logs, I see ppd.h was 
> included in several native sources in r2361.. Should the reference be to 
> nucleus/ppd.h or was the header missed out during a commit ?

Gasp. Forgotting to commit new files is one of my favourite jokes. Ok,
fixed now...

> 
> 
> Regards, Paul.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



