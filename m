Date: Sat, 6 Feb 2016 14:46:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160206134652.GI11143@hermes.click-hack.org>
References: <1019176459.3312173.1454670838251.JavaMail.yahoo.ref@mail.yahoo.com>
 <1019176459.3312173.1454670838251.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1019176459.3312173.1454670838251.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] ipipe tracer call trace during boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 05, 2016 at 11:13:56AM +0000, Frederik Bayart wrote:
> I have build an 3.18.20 kernel with xenomai 2.6.4 git latest with ipipe-core-3.18.20-x86-4.patch on debian jessie amd64 (64bit).
> 
> I try to build an version with ipipe tracer.
> 
> If I try to boot, I get a call trace : in __ipipe_init_tracer :
> 
> RIP __ipipe_tracer_hrclock_initialized


Hi,

the problem is probably the commit you found. Will try your
configuration soon.

Regards.

-- 
					    Gilles.
https://click-hack.org

