Message-ID: <53D52D7C.1050807@xenomai.org>
Date: Sun, 27 Jul 2014 18:49:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53D0AC77.8070606@ma-info.de>
 <20140724135603.GD17765@csclub.uwaterloo.ca>
In-Reply-To: <20140724135603.GD17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to use Xenomai in Eclipse
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Frede Florian <florian.frede@ma-info.de>
Cc: xenomai@xenomai.org

On 07/24/2014 03:56 PM, Lennart Sorensen wrote:
> CFLAGS += $(shell pkg-config --cflags libxenomai_native)
> LIBS += $(shell pkg-config --libs libxenomai_native)
> 
> I can't remember the syntax for using pkg-config for cross compiling at
> the moment, but I remember there is one.  I almost never cross compile
> so I don't remember it.
> 

In order to use pkg-config for cross-compiling, you have to use some
environment variables.

I use:
	PKG_CONFIG_LIBDIR=$(staging)/usr/lib/pkgconfig:$(staging)/usr/share/pkgconfig \
	PKG_CONFIG_SYSROOT_DIR=$(staging) \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=y \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=y

Where $(staging) is the directory passed to the DESTDIR variable when
installing xenomai.


-- 
                                                                Gilles.

