From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100922131418.C9A25B7480C@mail3-117.sinamail.sina.com.cn>
References: <20100922131418.C9A25B7480C@mail3-117.sinamail.sina.com.cn>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Sep 2010 16:12:31 +0200
Message-ID: <1285164751.1661.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Failed to build simulator xenosim-2.4.7
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gwysu@domain.hid
Cc: Xenomai-help@domain.hid

On Wed, 2010-09-22 at 21:14 +0800, gwysu@domain.hid wrote:
> Hi All,
> 
> I built the xenosim-2.4.7 using on ubuntu, but failed. Does anyone
> have a idea about the problem as follow:

A recent bison release probably needs --yacc to parse this antique
grammar file properly. Beyond that, the simulator direly needs a lot of
work to cope with current toolchains (i.e. more recent than debian
woody...).

In short, either build it over an oldish distro using an ancient
toolchain (typically over qemu), or forget about it.

> 
> cd cp && make ../../../gcc-2.95.3/gcc/cp/parse.c
> make[4]: Entering directory
> `/home/wygao/workspace/project/xenomai-2.5.4/sim_builddir/gcic/gcc-build/gcc/cp'
> expect 30 shift/reduce conflicts and 42 reduce/reduce conflicts.
> cd ../../../gcc-2.95.3/gcc/cp; bison -d -o parse.c parse.y
> parse.y:747.19-20: $$ for the midrule at $4 of
> `constructor_declarator' has no declared type
> parse.y:755.19-20: $$ for the midrule at $5 of
> `constructor_declarator' has no declared type
> parse.y:763.19-20: $$ for the midrule at $4 of
> `constructor_declarator' has no declared type
> parse.y:771.19-20: $$ for the midrule at $5 of
> `constructor_declarator' has no declared type
> make[4]: *** [../../../gcc-2.95.3/gcc/cp/parse.c] Error 1
> make[4]: Leaving directory
> `/home/wygao/workspace/project/xenomai-2.5.4/sim_builddir/gcic/gcc-build/gcc/cp'
> make[3]: *** [../../gcc-2.95.3/gcc/cp/parse.c] Error 2
> make[3]: Leaving directory
> `/home/wygao/workspace/project/xenomai-2.5.4/sim_builddir/gcic/gcc-build/gcc'
> make[2]: *** [all-gcc] Error 2
> make[2]: Leaving directory
> `/home/wygao/workspace/project/xenomai-2.5.4/sim_builddir/gcic/gcc-build'
> make[1]: *** [gcc-build/.gcic-built] Error 2
> make[1]: Leaving directory
> `/home/wygao/workspace/project/xenomai-2.5.4/sim_builddir/gcic'
> make: *** [install-recursive] Error 1
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



