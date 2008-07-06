Message-ID: <4870D327.9030707@domain.hid>
Date: Sun, 06 Jul 2008 16:13:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6132061f0807021209t1489f66cscac1e7f8be50bff5@domain.hid>
In-Reply-To: <6132061f0807021209t1489f66cscac1e7f8be50bff5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pipe.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Breno Carneiro Pinheiro wrote:
> Hi all, I'm trying to compile and then run the pipe.c example on my MPC5200
> board but I got so many errors on cross-compiling process.  The code has two
> parts (user and kernel space). Firstly I separated the kernel space to get
> the kernel module .
> The Makefile and code used are attached. If anyone have already tried, let
> me know. I'm  missing something likely.

This line of your makefile is completely wrong:
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai
-I$(KSRC)/include/xenomai/posix -I/home/
breno/ELDK/ppc_6xx/usr/include $(ADD_CFLAGS)

Since you are using the native skin, and not the posix skin, what you
should pass is -I$(KSRC)/include/xenomai/native.

Passing a path to user-space headers is also plain wrong, do not do it.

-- 


					    Gilles.

