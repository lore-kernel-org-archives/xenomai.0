Message-ID: <48F48E2E.2050004@domain.hid>
Date: Tue, 14 Oct 2008 14:18:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46954.6050704@domain.hid> <48F473A2.1050104@domain.hid>
In-Reply-To: <48F473A2.1050104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
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
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> It will always remain orders of magnitude heavier than __thread
>>> variables which are a) inlined and b) should only need two memory
>>> accesses at worst. Moreover, it is clearly the future, while the
>>> importance of pthread_getspecific will decrease over the time. The
>>> __thread storage class is C99 standard (though its implementation
>>> remains a separate topic).
>> You are exagerating a bit: pthread_getspecific is pretty efficient
>> already (from the few things that I have timed on ARM, it is the only
>> one which takes under the microsecond). That you will gain something
>> with __thread is not guaranteed by the C99 standard either: in fact the
>> implementation could use exactly the same functions.
> 
> As long as we do not loose anything (performance or portability),

You loose portability. But I agree that we do not care much.

-- 
                                                 Gilles.

