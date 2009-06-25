Message-ID: <4A4392F7.4050600@domain.hid>
Date: Thu, 25 Jun 2009 17:08:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1245226350.3614.10.camel@domain.hid>
	<4A38AD4D.9090802@domain.hid>
	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>
	<4A43820B.2020701@domain.hid>
	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E66@domain.hid>
In-Reply-To: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E66@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RE : RE :  problem with gtk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: LEMARCHAND Ludovic <Ludovic.LEMARCHAND@tech.viveris.com>
Cc: xenomai@xenomai.org

LEMARCHAND Ludovic wrote:
> Hello
> 
> I use Xenomai 2.4.7 with the ipipe patch for 2.6.26 because I should use a 2.6.26 Debian kernel.

Well, this version of the I-pipe patch is known to be broken on SMP
machines. It was fixed but in later patches (the earliest version fixed
is 2.6.26 I think).

And you can compile Xenomai as a debian package without resorting to the
xenomai repository, see:

http://www.xenomai.org/index.php/Building_Debian_packages

Well, I am afraid these instructions are a bit out-dated since they are
refering to svn. So, please use git-buildpackage instead of
svn-buildpackage (the url of xenomai git repository is available on
xenomai main page at http://www.xenomai.org).

Besides, I am having SATA controller problems with the latest 2.6.26
kernel from debian (unpatched I mean), so I would recommend to stay away
from it.

-- 
                                          Gilles


