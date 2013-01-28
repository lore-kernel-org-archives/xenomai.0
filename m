Message-ID: <510636B8.9010600@xenomai.org>
Date: Mon, 28 Jan 2013 09:28:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5102FC88.1070000@xenomai.org>
In-Reply-To: <5102FC88.1070000@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 01/25/2013 10:43 PM, Gilles Chanteperdrix wrote:

> Hi,
> 
> After "a few" issues in the 2.6.2 release, please find Xenomai 2.6.2.1 at 
> the following address:
> http://download.gna.org/xenomai/stable/xenomai-2.6.2.1.tar.bz2


The packages for the Debian stable distribution for the x86
architectures are available by adding the following line to your
sources.list:

deb http://www.xenomai.org/debian squeeze main

And installing the packages:
xenomai-keyring
xenomai-runtime
libxenomai1-dev
linux-image-3.5.7-xenomai-2.6.2.1-amd64 on x86_64
linux-image-3.5.7-xenomai-2.6.2.1-686 on i386

We could provide a -486 version if someone needs it.

-- 
                                                                Gilles.

