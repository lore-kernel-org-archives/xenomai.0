Date: Mon, 6 Mar 2017 18:04:51 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170306180451.2ca3fd04@md1em3qc>
In-Reply-To: <9eefa102-ada8-9395-4962-998714f822b4@xenomai.org>
References: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
 <20170306140049.23493-1-henning.schild@siemens.com>
 <9eefa102-ada8-9395-4962-998714f822b4@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] cobalt: fix for incorrect assert wrappers
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Mon, 6 Mar 2017 17:18:23 +0100
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 03/06/2017 03:00 PM, Henning Schild wrote:
> 
> > -XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'"
> > -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld"
> > +XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'"
> > -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld
> > $XENO_ASSERT_WRAPPERS" AC_SUBST(XENO_AUTOINIT_LDFLAGS) 
> 
> XENO_AUTOINIT_LDFLAGS is only used internally, inside the Xenomai tree
> for building utilities and test programs which may want the
> auto-bootstrap feature on. Is this the intent?

Honestly, i am not sure where to best put that. And i do not know what
the auto-bootstrap feature is. It does solve build problems in the tree
i.e. for latency and smokey_net_server.
The process of coming up with this version was a lot of looking at "make
V=1" and pattern matching to where the flags came from.

The build issues can be seen when applying 2/2 from this series on top
of current master 027898e4732cb5de.

After all the CXXAbi patch should have never come with those dummies. I
just put them in because of the above build-problems assuming they would
be natural for C-code and that weak symbols could not hurt.
Both those assumption where wrong ...

Would be nice if you could look at the problems and suggest a better
place for the adjusted LDFLGAS.

regards,
Henning

