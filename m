Message-ID: <4D5D8F72.4010904@domain.hid>
Date: Thu, 17 Feb 2011 22:13:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <592273.9623.qm@domain.hid>
In-Reply-To: <592273.9623.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] valgrind and modprobe xeno_posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

> Spam detection software, running on the system "xenomai.org", has 
> identified this incoming email as possible spam. (...)

Please avoid HTML messages.

Franz Engel wrote:
> O.k. This is a quite helpfull information. I tried to make dynamic
> librarys and glue them with QT to my whole project. But, how I say,
> I'm a newbie with makefiles. I tried to trim the satch-example. This
> is my makefile: APPLICATION = demoLib XENO?=/usr/xenomai 
> XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
> 2>/dev/null) CC=$(shell $(XENOCONFIG) --cc) CFLAGS=$(shell
> $(XENOCONFIG) --posix-cflags) $(APP_CFLAGS) LDFLAGS=$(shell
> $(XENOCONFIG) --posix-ldflags) $(APP_LDFLAGS) LDFLAGS+=Xlinker -rpath
> -Xlinker $(shell $(XENOCONFIG) --libdir)
> 
> all:: $(APPLICATIONS) clean:: $(RM) $(APPLICATIONS) *.o
> 
> The demoLib works fine, but of course, it is no lib. What I have to
> change to make a lib? Did I understand it right that the xeno-config
> is a skript that gives support to get the *FLAGS easier? But where is
> the compiling comand?

Well, it is a bit off-topic, what you are asking is how to compile
libraries for Linux on your target. See for instance:

http://www.yolinux.com/TUTORIALS/LibraryArchives-StaticAndDynamic.html


-- 
                                                                Gilles.

