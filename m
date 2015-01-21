Message-ID: <c38d2ac86c6078926fbb8faf3dc2b370.squirrel@xenomai.org>
In-Reply-To: <6773858.JgE1vlCdur@soho>
References: <6773858.JgE1vlCdur@soho>
Date: Wed, 21 Jan 2015 14:28:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiling xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Leopold Palomo-Avellaneda wrote:
> Hi,
>
> I'm trying to compile xenomai-3.x series using next branch from git.
>
> I'm trying to use the "debian" method to build the kernel, using the
> make-kpkg
> and the instructions proposed in the web page. However, I got with an
> strange
> problem not found in 2.x.
>
> make[2]: Entering directory '/srv/packages/xenomai/linux-3.16'
> scripts/kconfig/conf --oldconfig Kconfig
> init/Kconfig:1926: can't open file "arch/x86_64/xenomai/Kconfig"

the ARCH variable is probably defined in the environment to x86_64, but
for compiling the kernel, ARCH should be x86 (there as not been an
arch/x86_64
directory since sometime early in the 2.6 branch).


-- 
                    Gilles.


