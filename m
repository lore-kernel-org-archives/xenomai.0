Message-ID: <4B7324FB.8030600@domain.hid>
Date: Wed, 10 Feb 2010 22:28:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid> <4B7323D5.1040804@domain.hid>
In-Reply-To: <4B7323D5.1040804@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> If xnarch_init_timeconv shall be executed unconditionally, I will
> happily make it static inline again and call it from xeno_bind_skin_opt
> (which would imply retrieving sysinfo as well).

It is executed unconditionally, but needs to be available to kernel
space as well.


-- 
					    Gilles.

