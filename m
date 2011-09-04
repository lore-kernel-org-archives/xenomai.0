Message-ID: <4E63CCFD.4090800@domain.hid>
Date: Sun, 04 Sep 2011 21:09:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsCOSWYjHqGv0L+9ip+wkegMiV3GJBsGWtRjV2W=BsdOQw@domain.hid>
In-Reply-To: <CAPRPZsCOSWYjHqGv0L+9ip+wkegMiV3GJBsGWtRjV2W=BsdOQw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Build issue Linux kernel 2.6.38.8 - Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

On 09/04/2011 09:05 PM, Jeroen Van den Keybus wrote:
> Variant 2 (reason: kernel seems to be built with -O2 -fomit-frame-pointer
> (unsure where to verify though), but no effect):
> - ./configure --enable-x86-sep --enable-smp CFLAGS="-m32 -O2
> -fomit-frame-pointer" LDFLAGS="-m32"
> 
> Since kernel compiles are a very time-costly way of debugging and I also do
> not fully understand what I'm really doing when fiddling with gcc options,
> it seems that help is now much appreciated.

You need to compile with -fno-omit-frame-pointer, that is precisely the
contrary of -fomit-frame-pointer

-- 
                                                                Gilles.

