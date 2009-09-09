Message-ID: <4AA820D4.8000302@domain.hid>
Date: Wed, 09 Sep 2009 23:40:36 +0200
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
> 
> the result is :
> 
> root@domain.hid:~$ cat /proc/ipipe/version
> 1.12-02
> 
> 
> On Wed, Sep 9, 2009 at 12:08 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Felipe Castro wrote:
>>> Yes , i compiled with msoft-float , anyway  I downloaded xenomai 2.4.9.1
>>> and recompile my kernel,
>>>
>>> During the startup it was ok ,
>>>
>>> [    1.340935] NetWinder Floating Point Emulator V0.97 (double precision)

By the way, you should disable the floating point emulator, this way you
would be sure that the user-space code is actually using soft-floats.

-- 
					    Gilles.

