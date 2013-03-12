Message-ID: <513F96BA.4030309@xenomai.org>
Date: Tue, 12 Mar 2013 21:57:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de>
In-Reply-To: <5136F3A6.8090400@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2013 08:43 AM, Roland Stigge wrote:

> Hi,
> 
> On 06/03/13 04:36, Tom Z wrote:
>> I noticed that Debian and Ubuntu desktop distro's have included Xenomai, 
>> and I can "install" Xenomai through the software center in these 
>> distro's.
> 
> I can only speak for Debian here. We deliberately don't promote it as
> "desktop distro". Rather as "Universal OS", to underline its use in the
> Server, Embedded, Realtime areas, etc.
> 
>> But after I "installed" Xenomai in Ubuntu, executing  "dmesg | grep xenomai" showed nothing, so I am wondering if I still need to 
>> patch and compile the kernels before using the Xenomai features? If so, 
>> what benefits does it have to include Xenomai in these distro's.
> 
> First, you still have to compile the Xenomai-enabled kernel yourself
> (but this might change in the future).


Roland, at some point I lost track of what your intentions were. In the
following mail:
http://www.xenomai.org/pipermail/xenomai/2012-July/000473.html

You seemed to agree to take care of the debian directory in xenomai
sources, asking me to simply warn you before a release.
Which I did before the 2.6.2 release in the following mail:

http://www.xenomai.org/pipermail/xenomai/2012-December/027051.html

With a list of things which could be changed in the debian/rules file,
inviting you to do what I had understood you had agreed to do.

In this answer:
http://www.xenomai.org/pipermail/xenomai/2012-December/027052.html
You simply told me that you did not even try debian/rules, following
this, Leopold sent a post with a patch to fix the issue before the
release, but your reply could be interpreted as the fact that the patch
was actually broken, you did not send a fixed patch for the update, and
as a result 2.6.2 was released with a broken debian directory.

Which is why, for the 2.6.2.1 release, I did not warn you (since it had
proved useless anyway) and took the liberty to do the changes to
debian/rules myself, as, according to what I had said many times on this
list, I started to set-up a debian repository (following your advices on
the way to do it, use reprepro), and so needed a working debian/rules.
The aim of this was to avoid the kind of questions "Tom Z" is asking.

Now, since I did the Debian packages following your advice, and
basically did the work that you did not want to do, I do not really
understand why you keep ignoring the fact that we have not one but two
sources of up to date pre-buid debian kernel packages for Debian
squeeze, and continue to give answers to "Tom Z" misguiding him in
compiling the Xenomai package from the tarball, not even from the debian
directory.

Regards.


-- 
                                                                Gilles.

