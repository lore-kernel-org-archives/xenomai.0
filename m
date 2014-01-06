Message-ID: <52CB17A9.6080901@xenomai.org>
Date: Mon, 06 Jan 2014 21:52:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52CB0DA1.9080302@zultron.com>
In-Reply-To: <52CB0DA1.9080302@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Red Hat packaging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On 01/06/2014 09:10 PM, John Morris wrote:
> Here are the packaging materials I've been using on Red Hat Enterprise
> Linux clones for some time now, also recently updated for Fedora.
> 
> https://github.com/zultron/xenomai-rpm
> 
> The packaging is pretty straightforward, and follows the Debian
> packaging for the xenomai-devel subpackage.
> 
> A significant addition is the 'xenomai-gid-ctl' script for configuring
> non-root access to Xenomai services, plus sysv and systemd boot init
> scripts.

Are these specific to Red Hat, or can we put them in the set of files
installed by default?

  I'd appreciate comments on the control script's correctness
> and the init scripts' utility.

You do not need to pass --enable-x86-tsc as it is enabled by default
now. As for building the doc, xenomai sources contain generated
documentation, so if you do not enable any option, you will have some
documentation installed. If you still want to generate the doxygen
documentation, what is the problem with --enable-dox-doc?


-- 
                                                                Gilles.

