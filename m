Message-ID: <4B19A1AE.9090603@domain.hid>
Date: Sat, 05 Dec 2009 00:56:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460CFD20DE@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460CFD20DE@exchserver.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-config --xeno-ldflags does not add -lnative
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> When I run the command mentioned in the subject, it does not include a
> switch for -lnative.  I have to add this to the LDFLAGS in my Makefile
> manually in order to link.  Is this expected or do I just have something
> configured wrong?  The output I get is:
>  
> "-L/usr/xenomai/lib -lpthread"
>  
> I am using the xeno-config that comes with Xenomai 2.4.10.

It is expected. These flags work for all skins, not only the native
skin, so you have to add the proper -l for the skin you want to use.
Only the posix skin has dedicated xeno_config options, because of the
peculiar values of the flags it requires.

-- 
					    Gilles.

