Message-ID: <4F3E161A.2060106@domain.hid>
Date: Fri, 17 Feb 2012 09:55:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOx7Giq4tKYk-5KgKAUJ7CPCx5KtRO_fDfEQZ+KBLHLZtPaSZA@mail.gmail.com>
In-Reply-To: <CAOx7Giq4tKYk-5KgKAUJ7CPCx5KtRO_fDfEQZ+KBLHLZtPaSZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] porting of xenomai on on arm board(pandaomap4430)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramarao mundru <ramarao.mundru@domain.hid>
Cc: xenomai@xenomai.org

On 02/17/2012 05:59 AM, ramarao mundru wrote:
> 
> hi can any one  can help me,here i want to make uImage for pandaboard
> omap4430 while i am executing comand for uImage i am getting the error
> ,i am using the linux-2.6.37.6 with xenomai 2.6.0
> 
> 
>  CC      kernel/xenomai/arch/generic/hal.o
> In file included from kernel/xenomai/arch/generic/hal.c:45:
> /usr/local/arm/linux-2.6.37.6/arch/arm/include/asm/xenomai/hal.h:91:
> error: #error "Unsupported ARM machine"
> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> make[3]: *** [kernel/xenomai/arch/generic] Error 2
> make[2]: *** [kernel/xenomai/arch] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2

Please post your .config

-- 
                                                                Gilles.

