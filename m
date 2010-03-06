Message-ID: <4B923F16.7010105@domain.hid>
Date: Sat, 06 Mar 2010 12:40:06 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B9236DD.2030900@domain.hid> <4B923AC8.3070109@domain.hid>
In-Reply-To: <4B923AC8.3070109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai/asm/xenomai/syscall.h is not c99 aware
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Daniele Nicolodi wrote:
>> Hello. I'm compiling my programs with the -std=c99 switch. However the
>> inclusion of pthread.h from xenomai distribution causes the compilation
>> to fail with syntax errors.

> What version of Xenomai, what platforms? Chances are that Xenomai
> headers contain inline assembly code and things like that which are
> definitely not ansi, and we even use GNU extensions. I am afraid you
> will have to compile with -std=gnu99.

Sorry. Forgot to include those informations. Xenomai version 2.5.1 on a
debian unstable x86 box with gcc 4.4.3.

> It probably can be made to work. But... do you realy need -std=c99 ?

I didn't know about -std=gnu99. I can certainly use this extension.

Thanks. Cheers,
-- 
Daniele


