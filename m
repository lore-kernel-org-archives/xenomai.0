Message-ID: <4AA80095.50502@domain.hid>
Date: Wed, 09 Sep 2009 21:23:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>	<4AA6BC5D.8020704@domain.hid>	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>	<4AA7C4F7.6000903@domain.hid>
	<7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>
In-Reply-To: <7a15153d0909091206y5d16ffcck32d0c8cc3c120f6c@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> i applied the adeos path that comes with xenomai 2.4.9.1 overriding the old
> one that I was using, is that a problem ?

Yes, please start from scratch. And I suspect you may not be running the
kernel you think you are running since it is a 2.6.27, and there is no
I-pipe patch for Linux 2.6.27 in xenomai 2.4.9.1.

> 
> the result is :
> 
> root@domain.hid:~$ cat /proc/ipipe/version
> 1.12-02

xenomai 2.4.9.1 ships with the following I-pipe patches for ARM:
adeos-ipipe-2.6.28-arm-1.12-05
adeos-ipipe-2.6.29-arm-1.13-03
adeos-ipipe-2.6.30-arm-1.14-02

-- 
					    Gilles.

