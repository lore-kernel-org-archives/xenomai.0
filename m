Message-ID: <4A5EE47E.5000507@domain.hid>
Date: Thu, 16 Jul 2009 10:27:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>	
	<4A5CC870.3030208@domain.hid>
	<b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>
In-Reply-To: <b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> The Xenomai applications (cyclictest, latency) result in a hangup of the system.
> 
> I did a complete rebuild of the openembedded Angstrom console-image
> distribution, compiled this time with the CodeSourcery 2007q3
> cross-compile environment. This is a gcc 4.2.1 version. But has the
> same hangup behaviour as the default 4.3.3 version.
> 
> I build the xenomai userspace with:
> ./configure --build=i686-pc-linux-gnu
> --host=arm-angstrom-linux-gnueabi --enable-arm-mach=at91sam926x
> --enable-arm-eabi

I can not tell you if --enable-arm-eabi is correct, it depends on how
you configured the kernel.

-- 
                                          Gilles


