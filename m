From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D4CAE9.9000800@domain.hid>
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid>  <44D4CAE9.9000800@domain.hid>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 19:25:35 +0200
Message-Id: <1154798736.4330.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
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
Cc: xenomai@xenomai.org

On Sat, 2006-08-05 at 18:44 +0200, Jan Kiszka wrote:
> > 
> > Thanks a lot for your time. I'm going to provide a revised patch a.s.a.p.
> 
> Again, the naming should be resolved, but then I think we could merge.
> Philippe, ok for you as well?
> 

Yes.

> > 
> > A few other issues:
> > 
> > Till now I do not use rt_owner. Is it necessary?
> 
> That's for locking the driver module against removal. I guess this is
> not needed for RTCAN if you can unregister a device at any time, maybe
> just by spinning on the reference counter release.
> 
> Jan
> 
-- 
Philippe.



