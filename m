Message-ID: <4E1B4438.6030600@domain.hid>
Date: Mon, 11 Jul 2011 20:43:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E16296B.4080209@domain.hid>
In-Reply-To: <4E16296B.4080209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails
 with	ENOSYS)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

On 07/07/2011 11:47 PM, Anders Blomdell wrote:
> When compiling kernel 2.6.37.3 and xenomai 2.5.6 with "gcc version 4.6.0 
> 20110530 (Red Hat 4.6.0-9) (GCC)", programs fail with -ENOSYS in 
> rt_task_shadow. If compiled with "gcc version 4.5.1 20100924 (Red Hat 
> 4.5.1-4) (GCC)" everything works as expected.

I think it is due to the modifications of syscall.h I made to implement
pseudo-signals handling, which implementation was never finished, and
removed in xenomai-head. Could you try xenomai-head to see if you get
the failure? I tried backporting it, but the code evolved too much in
both repositories, the backport needs to spend some time on it, so, I
would like to know whether it is really needed.

-- 
                                                                Gilles.

