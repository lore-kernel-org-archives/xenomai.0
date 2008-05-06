Message-ID: <48200D41.3060002@domain.hid>
Date: Tue, 06 May 2008 09:48:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0805060930140.26449@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0805060930140.26449@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] -ETIMEDOUT return value not described in
 rt_cond_wait API documentation?
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: Xenomai-core@domain.hid

Klaas Gadeyne wrote:
> Hi,
> 
> it seems -ETIMEDOUT is not mentioned as a possible return value of
> rt_cond_wait() in the API docs [1], although it *is* returned in case
> of the timeout having expired [2]?
>

Indeed. Applied, thanks.

> Attached patch tries to solve this against the 2.4 branch.
> 
> regards,
> 
> Klaas
> 
> ps.  This seems to apply to 2.3, 2.4 and trunk.
> 
> [1]
> <http://www.xenomai.org/documentation/trunk/html/api/group__cond.html#g3aa51073817be2ffb2a880a7393502e8>
> 
> [2]
> <http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/cond.c#493>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

