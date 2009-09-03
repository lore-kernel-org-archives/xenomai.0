Message-ID: <4A9FBE16.4080703@domain.hid>
Date: Thu, 03 Sep 2009 15:01:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909030551xbda7cb3kf600e8094606625@domain.hid>
In-Reply-To: <7a15153d0909030551xbda7cb3kf600e8094606625@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Soft float point
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
> Hi,
> 
> I'm having some problems to compile with -msoft-float. I'm using xenomai
> in a PXA270 processor.
> So to get a task with 5ms resolution for example, e need to compile with
> -msoft-float parameter right?
> 
> My toolchain must be prebuilt to use a soft float point ?
> Should i recompile xenomai with -msoft-float ?

Yes hard floats are not implemented on PXA. You MUST recompile Xenomai
user-space with -msoft-float. Normally toolchains allow generating
soft-floats. But, because there is always a but:

If you do not use EABI, the whole root filesystem must be compiled with
-msoft-float. Including the glibc. With EABI, on the other hand, you can
mix soft floats and hard float code.

A lot of people use CodeSourcery toolchains on ARM. Normally, with
Xenomai 2.4.9, the latest one should work.

-- 
                                          Gilles


