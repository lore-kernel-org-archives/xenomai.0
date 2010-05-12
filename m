From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
References: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
Date: Wed, 12 May 2010 17:29:38 +0200
Message-Id: <20100512152938.08812C67D4E@gemini.denx.de>
Subject: Re: [Xenomai-help] xenomai test problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico lolli <federicololli@domain.hid>
Cc: xenomai@xenomai.org

Dear federico lolli,

In message <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid> you wrote:
>
>  Hi all,I'm trying to install Xenomai on ARM sam9g20.
...
> crosscompiling Xenomai with these commands:
>
> fede@domain.hid$ ./configure --host=arm-linux-gnueabi --enable-arm-eabi --enable-arm-mach=at91sam9 --disable-arm-tsc --enable-static
> make DESTDIR=/home/fede/foxg20/kernel/l/ install

Hm... I see you running "make", but where to you tell it to use a
cross compiler?

> ./latency
> -sh: ./latency:not found

Try running "file ./latency" and verify that this actually an ARM
binary - I guess you used the native compilers, and your ARM system
refuses to run x86 binaries.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Karl's version of Parkinson's Law: Work expands to  exceed  the  time
alloted it.

