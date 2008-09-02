Message-ID: <48BD5D26.4010807@domain.hid>
Date: Tue, 02 Sep 2008 17:35:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid> <48BD4577.3000307@domain.hid>
	<48BD4CE2.4020406@domain.hid> <48BD5180.4080509@domain.hid>
	<48BD54FE.8010406@domain.hid> <48BD5BC3.4040903@domain.hid>
In-Reply-To: <48BD5BC3.4040903@domain.hid>
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
> OTOH, we can safe some text size which is precious as well. So I'm
> convinced to go your way (with a modification):

My approach sucks: we get a silly atomic_cmpxchg if the mutex is already
claimed, which is as least as much a common case as a currently
unclaimed mutex. Need to think a bit. But I think a good solution is to
re-read only if the mutex has been seen as already claimed.

-- 
                                                 Gilles.

