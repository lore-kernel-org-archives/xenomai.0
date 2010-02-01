Message-ID: <4B675733.3040902@domain.hid>
Date: Mon, 01 Feb 2010 23:35:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c31001260616wf2194d3t193de281af1318ad@domain.hid>
In-Reply-To: <b88603c31001260616wf2194d3t193de281af1318ad@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.0: rt_task_shadow fails when
 libnative is statically linked.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hi all,
> 
> I get segmentation fault when calling rt_task_shadow. Actually
> somewhere in the pthread library called from sigshadow_install_once();
> 
> This only happens on Xenomai 2.5 when libnative is statically linked.
> Tested ok on 2.4.10 both dynamically and statically linked. I use
> kernel version 2.6.30.10, xenomai 2.5.0 on x86.
> 
> Any idea what is wrong?
> 
> Reproduced it with basic app that is attached to this email. Compiled with:
> gcc -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
> -I/usr/xenomai/include tst_basic.c -o tst_basic
> /usr/xenomai/lib/libnative.a -lpthread
> 
> Segfailt in dmesg on xenomai 2.5.0:
> tst_basic_2.5[1351]: segfault at 0 ip b7ff5a54 sp bfc9b46c error 4 in
> libpthread-2.9.so[b7feb000+13000]

Ok. Reproduced here. It looks like xeno_sigshadow_install and
xeno_sigshadow_installed have no address. I am on it.

-- 
					    Gilles.

