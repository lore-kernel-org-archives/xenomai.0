Date: Fri, 7 Nov 2014 10:59:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141107095914.GE6724@sisyphus.hd.free.fr>
References: <20141106160821.GE30908@sisyphus.hd.free.fr>
 <1260200250.109080355.1415353723657.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141107095222.GD6724@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141107095222.GD6724@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: tbultel@free.fr
Cc: xenomai@xenomai.org

On Fri, Nov 07, 2014 at 10:52:22AM +0100, Gilles Chanteperdrix wrote:
> On Fri, Nov 07, 2014 at 10:48:43AM +0100, tbultel@free.fr wrote:
> > 
> > 
> > ----- Mail original -----
> > > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > À: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
> > > Cc: tbultel@free.fr, xenomai@xenomai.org
> > > Envoyé: Jeudi 6 Novembre 2014 17:08:21
> > > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > > 
> > > On Thu, Nov 06, 2014 at 11:04:57AM -0500, Lennart Sorensen wrote:
> > > > On Thu, Nov 06, 2014 at 03:41:47PM +0100, tbultel@free.fr wrote:
> > > > > Gilles, we do not have CONFIG_ARM_ERRATA_754327 enabled
> > > > > It is -not- enabled in the evaluation kernel that is provided by
> > > > > the
> > > > > manufacturer.
> > > > > That errata is said to be for CPU revs < r2p0
> > > > > 
> > > > > I am a little bit puzzled about the naming conventions for the
> > > > > CPU revision,
> > > > > uboot says rev1.2, the kernel says
> > > > > 
> > > > > Processor	: ARMv7 Processor rev 10 (v7l)
> > > > > ...
> > > > > 
> > > > > CPU implementer	: 0x41
> > > > > CPU architecture: 7
> > > > > CPU variant	: 0x2
> > > > > CPU part	: 0xc09
> > > > > CPU revision	: 10
> > > > > 
> > > > > how can I do the matching ?
> > > > > 
> > > > > Meanwhile, we noticed that compared to the evaluation kernel, we
> > > > > were missing
> > > > > CONFIG_ARM_ERRATA_754322 and CONFIG_PL310_ERRATA_769419
> > > > > 
> > > > > Adding them helps a lot, but the freeze still happens on one
> > > > > machine
> > > > > 
> > > > > We are currently trying with 754322 + 769419 + 754327 + 5 nops in
> > > > > fec ...
> > > > > but not sure if we need 754327.
> > > > > 
> > > > > Regards
> > > > > Thierry
> > > > > 
> > > > > PS: Regarding the thermal issue, we have changed our supplier, we
> > > > > now have
> > > > > a dissipator that is big enough (it is the AMOS820 from Via
> > > > > Embedded)
> > > > 
> > > > I am not sure how to read the A9 revision.  I have this on a
> > > > system:
> > > 
> > > I have found the method I gave in ARM documentation. I am pretty
> > > sure this is how it works.
> > > 
> > > --
> > > 					    Gilles.
> > > 
> > 
> > 
> > Gille, 
> > we agree that as we have a r2p10, the 754327 does not apply.

Nothing says that the starvation due to calling mb in a tight loop
is related to errata 754327, it just happens that the workaround for
this erratum triggers this bug, because it results in calling mb in
a tight loop.

-- 
					    Gilles.

