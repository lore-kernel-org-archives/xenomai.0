From: "George Pontis" <gpontis@z9.com>
References: <01e701ce6d1a$1704f060$450ed120$@z9.com>
	<7744935bc7440a4f31dfb4fae3c6bad3.squirrel@www.xenomai.org>
In-Reply-To: <7744935bc7440a4f31dfb4fae3c6bad3.squirrel@www.xenomai.org>
Date: Thu, 20 Jun 2013 12:41:45 -0700
Message-ID: <001f01ce6dee$32a85620$97f90260$@z9.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] 3.8 versions for ARM ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, June 20, 2013 6:31 AM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] 3.8 versions for ARM ?
> 
> 
> George Pontis wrote:
> > I'm working with an ARM ( MX53 ) and kernel 3.8.2, using a custom
> > ipipe patch. Also a Xenomai from git, as I don't think that Xenomai
> > 2.6.2.1 worked with that kernel and ipipe patch. Now there is an
> > official ipipe-core-3.8-arm-1.patch, and I'd like to use it. My
> > question is about what version of kernel and tools to use with this.
> 
> The patch in xenomai repository is for Linux 3.8, not Linux 3.8.13.

It is not too hard to port these patches to a closely related 3.8.x kernel.
Is it practical for the average user to test the resulting kernel and have
some confidence that nothing was subtly broken ?

> ...
> --
>                     Gilles.




