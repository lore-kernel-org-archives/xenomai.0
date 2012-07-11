Message-ID: <4FFDAF59.9010000@xenomai.org>
Date: Wed, 11 Jul 2012 18:52:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
In-Reply-To: <4FFDA171.3010201@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 07/11/2012 05:53 PM, Jeff Webb wrote:
> On 07/10/2012 03:00 PM, Gilles Chanteperdrix wrote:
>> At long last, please find Xenomai 2.6.1 at the following URL:
>> http://download.gna.org/xenomai/stable/xenomai-2.6.1.tar.bz2
> 
> Wonderful!  I have been looking forward to this release.  I have been 
> using a version I checked out from the Xenomai-2.6 git repository around 
> April 20th.
> 
> In the process of building a new set of debian packages for 2.6.1, I was 
> painfully reminded of an issue I discovered back in April, but failed to 
> report.  When I issue the 'debuild -uc -us' command in the xenomai-2.6.1 
> directory, I eventually get an error that says:
> 
> cp: cannot stat `debian/tmp/usr/share/xenomai': No such file or directory
> dh_install: cp -a debian/tmp/usr/share/xenomai 
> debian/xenomai-runtime//usr/share/ returned exit code 1
> make: *** [install] Error 2
> dpkg-buildpackage: error: fakeroot debian/rules binary gave error exit 
> status 2
> 
> If I remove the 'usr/share/xenomai' line from 
> xenomai-2.6.1/debian/xenomai-runtime.install, the error goes away.
> 
> I am building on ubuntu-12.04, if that makes any difference.  I 
> apologize for not reporting this earlier, so a fix could be included in 
> this point release.  Let me know if there is any more information I can 
> provide to help this get fixed for future releases.

Well, maybe we should, from time to time, import the changes which are
done by the debian maintainers. Or forget the debian directory
altogether, as there is one correctly maintained by the debian
maintainer. I do not really know what to think of this as I do not use
the debian packaging. As a user of debian packaging, what do you think?

-- 
					    Gilles.

