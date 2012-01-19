Message-ID: <4F187F9B.4070203@domain.hid>
Date: Thu, 19 Jan 2012 21:39:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
	<4F173B1C.3000300@domain.hid>
	<CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
In-Reply-To: <CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "Inappropriate ioctl for device" with
 xeno_16550A on Xenomai 2.6, not Xenomai 2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manuel Vonthron <manuel.vonthron@domain.hid>
Cc: xenomai@xenomai.org

On 01/18/2012 10:56 PM, Manuel Vonthron wrote:
> "-fno-omit-frame-pointer" doesn't fix the problem but gcc versions are
> indeed different:
>   - gcc 4.3.2 on the "working" machine
>   - gcc 4.6.2 on the other

gcc 4.6.2 definitely needs -fno-omit-frame-pointer. Stupid suggestion:
if you re-used the same build directory for xenomai user-space, did you
think about running "make clean" after reconfiguring?


-- 
                                                                Gilles.

