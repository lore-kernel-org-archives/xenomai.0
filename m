From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B8407B5.10109@domain.hid>
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>
	<4B76C045.2070602@domain.hid>
	<1266140329.27019.17.camel@domain.hid>
	<4B8407B5.10109@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 18:46:03 +0100
Message-ID: <1266947163.26785.300.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
> Hi,
> 
> Am 14.02.2010 10:38, schrieb Philippe Gerum:
> > 
> > <snip>
> > In the future, maybe we could simply provide a wrapper script accepting
> > sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
> > into /usr/bin by distros, which would hide the actual location of those
> > binaries?
> >
> > In any case, thanks for your work so far. We probably need to discuss
> > the packaging issues on this list, so that we get both consistency and
> > usability in the future.
> > 
> > Gilles and Roland, if this is fine with you, I'll handle the liaison
> > role with upstream packagers, so please CC me explicitly on those mails.
> > We'll sort out this issue, it doesn't look that bad anyway.
> 
> Roland added a xeno wrapper to the debian.org xenomai package 2.5.1-3.
> 
> I synced now the debian/ directories from debian.org and xenomai.org:
>  - For debian.org I sent patches to the Debian bugtracker [1] [2].
>    Another patch for dpkg-cross support [3] I sent to Roland privately.
>  - For xenomai.org I attached patches to this mail (against -2.5.git).
> 
> If both parties apply the patches the debian directories are in sync,
> except some minor differences in the debian/control file, see patch
> do-not-commit-please.patch. I would like to keep these changes out so
> that the xenomai.org packages are compatible with Debian 5.0 Lenny.
> The debian.org packages are for Debian 6.0 Squeeze.
> 

Merged into my queue (except the last one as mentioned). This will be
pushed upstream to Gilles for 2.5.2. Thanks.

> Thanks
> kisda
> 
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=571099
> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=571104
> [3] http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=5bcd18f714f4cbeaaac0cc4a08e6c9f375aa3b77


-- 
Philippe.



