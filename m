Message-ID: <48F878DF.2030207@domain.hid>
Date: Fri, 17 Oct 2008 13:37:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.644116499@domain.hid>	<48F7A064.20404@domain.hid>
	<48F7C5D1.3010500@domain.hid>	<48F855DB.3070300@domain.hid>
	<48F86F6A.1010801@domain.hid> <48F86FED.2010409@domain.hid>
	<48F8738E.8070709@domain.hid> <48F8753C.5000901@domain.hid>
In-Reply-To: <48F8753C.5000901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 08/12] Use fast xnsynch with native skin
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

Jan Kiszka wrote:
> But that is what cond_wait is about: releasing the associated lock to
> whoever gets it - either directly or via lock-stealing. I see no problem
> here. Moreover, lockcnt is never used (and must not!) as an indication
> if a lock is free. It is a pure helper for the lock owner to track
> recursion. And it is also no longer consistent between kernel and user
> side, another reason to allow only the lock owner to play with it.

Right.

-- 
                                                 Gilles.

