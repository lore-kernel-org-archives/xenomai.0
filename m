Message-ID: <7744935bc7440a4f31dfb4fae3c6bad3.squirrel@www.xenomai.org>
In-Reply-To: <01e701ce6d1a$1704f060$450ed120$@z9.com>
References: <01e701ce6d1a$1704f060$450ed120$@z9.com>
Date: Thu, 20 Jun 2013 15:31:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] 3.8 versions for ARM ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <gpontis@z9.com>
Cc: xenomai@xenomai.org


George Pontis wrote:
> I'm working with an ARM ( MX53 ) and kernel 3.8.2, using a custom ipipe
> patch. Also a Xenomai from git, as I don't think that Xenomai 2.6.2.1
> worked
> with that kernel and ipipe patch. Now there is an official
> ipipe-core-3.8-arm-1.patch, and I'd like to use it. My question is about
> what version of kernel and tools to use with this.

The patch in xenomai repository is for Linux 3.8, not Linux 3.8.13.

>
> What about the version of gcc to build ? I have been using 4.7.2 and did
> not
> have any problems with that. Is there another version that is favored ?

Any version working for compiling the Linux kernel should work for
compiling xenomai.

-- 
                    Gilles.


