Message-ID: <2ff1a98a0805150246n39d989d4p346d8959b76b8b3b@domain.hid>
Date: Thu, 15 May 2008 11:46:59 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0805150221o5df6f9a2reb49dad9c5e1fe59@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1164134085@domain.hid>
	<2ff1a98a0805150221o5df6f9a2reb49dad9c5e1fe59@domain.hid>
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa2001@domain.hid
Cc: xenomai@xenomai.org

On Thu, May 15, 2008 at 11:21 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, May 15, 2008 at 10:36 AM,  <Paradoxxa2001@domain.hid> wrote:
>> It says me that the files memory.h and asm/param.h couldn't be found.
>> Im wondering why? I also tried it like the example in the README.INSTALL 2.6 Building for ARM
>> but with the same result. Do anyone know how to fix this?
>
> It looks like a toolchain issue. Are you sure your toolchain is
> properly installed ? Is there a memory.h or sys/mman.h in the
> toolchain include dir ?

I routinely compile Xenomai with the two following toolchains for ARM:
- Snapgear 2005 toolchain:
http://ftp.snapgear.org/pub/snapgear/tools/arm-linux/arm-linux-tools-20051123.tar.gz
- CodeSourcery 2007q3 toolchain (no longer available, the current
toolchain is 2008q1):
http://www.codesourcery.com/gnu_toolchains/arm/download.html

-- 
 Gilles

