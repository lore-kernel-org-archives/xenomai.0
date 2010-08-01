Message-ID: <4C5579F3.4000000@domain.hid>
Date: Sun, 01 Aug 2010 15:43:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001b01cb1e9c$54ddbae0$fe9930a0$@com>	<4C35CC27.1000407@domain.hid>
	<loom.20100713T211010-119@domain.hid>
In-Reply-To: <loom.20100713T211010-119@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fatal: error xeno_nucleus not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jmf <xeno.nonono@domain.hid>
Cc: xenomai@xenomai.org

jmf wrote:
> FATAL: Module xeno_nucleus not found.
> FATAL: Error running install command for xeno_nucleus

Hi, I had a look into this issues, and these are harmless.

> sudo: /usr/bin/latency: command not found

That is the true error.

This should be fixed by commit 5c76da92cd3a4d1097abcbc61801f6359d98d94c
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=5c76da92cd3a4d1097abcbc61801f6359d98d94c


-- 
					    Gilles.

