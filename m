Message-ID: <2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
Date: Thu, 9 Aug 2007 11:42:45 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: xenomai@xenomai.org

On 8/9/07, andy motten <andy.motten@domain.hid> wrote:
> There seems to be a difference between the 2 versions (Xenomai: POSIX:
> destroyed thread), Is this normal or part of the problem ?

No, this is normal, this message is harmless, it only appears if you
select posix skin debugging.

> Is there a possibility that this is a bug in Xenomai or in the ipipe patch?
> Using the Xenomai 2.2.x branch is not an option since we need the RT can
> drivers provided in the Xenomai 2.3.x branch.

There is certainly a bug somewhere. Could you enable Linux debugs, its
NMI watchdog (by adding nmi_watchdog=1 on the kernel command line), as
well as Xenomai debugs ? In order to find where the lock-up occurs.

-- 
                                               Gilles Chanteperdrix

