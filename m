Date: Wed, 25 Sep 2002 10:17:00 +0200
From: Pavel Machek <pavel@domain.hid>
Message-ID: <20020925081700.GA4778@domain.hid>
References: <3D8E8371.D2070D87@domain.hid> <20020922045907.C35@domain.hid> <3D90D388.746D0C0D@opersys.com> <20020924220607.GD1496@domain.hid> <3D90F3AC.84AFDE93@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90F3AC.84AFDE93@domain.hid>
Subject: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Karim Yaghmour <karim@domain.hid>
Cc: linux-kernel <linux-kernel@domain.hid>, Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Hi!

> > You can't
> > run two copies of linux, because they would fight over memory; right?
> 
> Currently we can't, you're right. But I've already detailed how to do
> this in a paper I wrote last july on how to obtain Linux SMP clusters
> with as few modifications to the kernel as possible. The paper is
> available on the web:
> http://opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
> (If you stil can't access the web as said in the other email, I can
> send you a copy off-list if you want.)

Its okay now, thanx.

> > Do you have something that can run alongside linux?
> 
> Certainly. According to some reports it's already used in some commercial
> systems and, as today's RTAI announcement reads, it will be the basis
> for the next release of RTAI.

Ok. Good luck pushing it through linus ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


