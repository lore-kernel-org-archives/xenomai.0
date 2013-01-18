Message-ID: <50F9056A.2090605@xenomai.org>
Date: Fri, 18 Jan 2013 09:18:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F904C3.3060906@zultron.com>
In-Reply-To: <50F904C3.3060906@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Redhat packaging patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/18/2013 09:16 AM, John Morris wrote:

> Here's a two-liner patch to Makefile.in that disables /dev entry
> creation when 'make NODEVICES=1 install'.


What is wrong with "make install-user" ?

> 
> RedHat packages are built as normal users, and there is no fakeroot
> mechanism like Debian has, so devices must be recreated from a separate
> script run after the rest of the package is unpacked.
> 
> Incorporating this patch into Xenomai makes it a little cleaner for RH
> package maintainers, as we don't have to keep a separate patch in the
> RPM sources.  Unfortunately, we still must continue maintaining the
> %post script to create the devices.  :P


Why not using udev rules like debian?

-- 
                                                                Gilles.

