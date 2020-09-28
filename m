Date: Mon, 28 Sep 2020 22:21:38 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH] Multi-library support with core suffix in soname
Message-ID: <20200928192138.bqvkjwi45eedfni5@altlinux.org>
References: <20200920192808.13637-1-vt@altlinux.org>
 <c6014ee5-f2dd-5107-3b7b-ca45f4544c7e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <c6014ee5-f2dd-5107-3b7b-ca45f4544c7e@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Jan,

On Mon, Sep 28, 2020 at 06:37:45PM +0200, Jan Kiszka wrote:
> On 20.09.20 21:28, Vitaly Chikunov wrote:
> > @@ -898,6 +903,8 @@ AC_SUBST(XENO_TEST_DIR)
> >  AC_SUBST(XENO_DEMO_DIR)
> >  AC_SUBST(XENO_BUILD_COMPILER)
> >  AC_SUBST(XENO_BUILD_ARGS)
> > +AC_SUBST(XENO_BUILD_ARGS)
> 
> Duplication. Did you intended something else?

Accidental.

> Ok, so this renames things for mercury unconditionally. If I merged that
> into master, which is still == stable 3.1, it would break current users
> because their dependencies would suddently be renamed.

OK, I will add some option, like --so-suffix.

Thanks,

> 
> Would it makes sense to do the renaming as opt-in for now? We could
> change that for 3.2.
> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

