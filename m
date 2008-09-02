Message-ID: <48BD4142.5060301@domain.hid>
Date: Tue, 02 Sep 2008 15:36:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid>
In-Reply-To: <48BD409B.8000309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit
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
> Patch 2 of my fast lock series actually also contained an attempt to fix
> a race I spotted in the code that atomically sets the claimed bit. I
> forgot about this fact and even, worse, I only replace the original race
> with another one.
> 
> So here comes a new attempt to fix the issue that the lock owner and/or
> the claimed bit can change between trylock and the cmpxchg under nklock.
> Please have a look and cross-check the logic.
> 
> The patch applies on top of vanilla SVN, so my series has to be rebased
> and the fix has to be ported to native as well - where we just found it
> in the field.

Could you explain the race ?

-- 
                                                 Gilles.

