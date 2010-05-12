Message-ID: <4BEAD311.7060003@domain.hid>
Date: Wed, 12 May 2010 18:10:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid>
	<20100512152938.08812C67D4E@gemini.denx.de>
In-Reply-To: <20100512152938.08812C67D4E@gemini.denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Denk wrote:
> Dear federico lolli,
> 
> In message <SNT119-W494F38A017E8C5258B4B21B0FB0@domain.hid> you wrote:
>>  Hi all,I'm trying to install Xenomai on ARM sam9g20.
> ...
>> crosscompiling Xenomai with these commands:
>>
>> fede@domain.hid$ ./configure --host=arm-linux-gnueabi --enable-arm-eabi --enable-arm-mach=at91sam9 --disable-arm-tsc --enable-static
>> make DESTDIR=/home/fede/foxg20/kernel/l/ install
> 
> Hm... I see you running "make", but where to you tell it to use a
> cross compiler?

The --host argument passed to configure is used as a compiler prefix.


-- 
					    Gilles.

