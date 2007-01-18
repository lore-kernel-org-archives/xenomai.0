Message-ID: <45AF45D2.3010504@domain.hid>
Date: Thu, 18 Jan 2007 11:02:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] special glibc support for Xenomai?
References: <45AE059C.9050605@domain.hid>		<1169033628.17493.35.camel@domain.hid>
	<45AE0C86.9080101@domain.hid>	<1169036056.17493.43.camel@domain.hid>
	<45AE1E91.8050900@domain.hid> <45AE25D2.5070706@domain.hid>
	<45AF44A1.6060509@domain.hid>
In-Reply-To: <45AF44A1.6060509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Ah. Thanks! Passing these flags seems to work now.
> But I had to copy and paste it from your mail since when I run ./xeno-config
> --posix-ldflags I get
> 
> POSIX support is not available
> 
> ???
> 
> How is that?

These flags are stored in the posix.wrappers file. xeno-config has to
find it. So, if you installed Xenomai with DESTDIR set to a non null
value you should set DESTDIR to the same value in xeno-config environment.

-- 
                                                 Gilles Chanteperdrix

