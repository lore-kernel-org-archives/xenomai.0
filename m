Message-ID: <4B1028F2.9000005@domain.hid>
Date: Fri, 27 Nov 2009 20:30:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200911271703.53872.anisha.kaul@domain.hid>
In-Reply-To: <200911271703.53872.anisha.kaul@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rs232 hard-real time driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai@xenomai.org

Anisha Kaul wrote:
> hi,
> 
> i have been able to successfully send the data from 'computer A'  to 'computer 
> B' using driver files namely '16550A.c' and user space file 
> namely 'rt_serial_uprog.c'.
> 
> When I use minicom to transfer data from 'computer B' to 'computer A', nothing 
> seems to be working ! 'dmesg' doesn't show anything !!

Have you recompiled minicom to use the real-time serial driver?

-- 
					    Gilles.

