Message-ID: <4B167B4B.3010804@domain.hid>
Date: Wed, 02 Dec 2009 15:35:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid> <4B166A5B.6030400@domain.hid>
	<4B166EFB.8050309@domain.hid> <4B16769A.9060700@domain.hid>
	<4B167A55.8080407@domain.hid>
In-Reply-To: <4B167A55.8080407@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Mauerer <wm@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Why? It delivers us the core mechanism we need for the rest as well -
> and it does not require fancy I-pipe hooks.

Because relying on the vdso/vsyscall only works on x86. Whereas
implementing clock slew down/acceleration at nucleus level and simply
sharing data between kernel and user through the the global sem heap,
works for all architectures.

-- 
                                          Gilles


