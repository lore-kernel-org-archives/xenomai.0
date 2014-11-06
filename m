Date: Thu, 6 Nov 2014 17:08:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141106160821.GE30908@sisyphus.hd.free.fr>
References: <20141106125217.GC29228@sisyphus.hd.free.fr>
 <2121666186.108134765.1415284907675.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141106160457.GP24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141106160457.GP24110@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: tbultel@free.fr, xenomai@xenomai.org

On Thu, Nov 06, 2014 at 11:04:57AM -0500, Lennart Sorensen wrote:
> On Thu, Nov 06, 2014 at 03:41:47PM +0100, tbultel@free.fr wrote:
> > Gilles, we do not have CONFIG_ARM_ERRATA_754327 enabled
> > It is -not- enabled in the evaluation kernel that is provided by the 
> > manufacturer.
> > That errata is said to be for CPU revs < r2p0
> > 
> > I am a little bit puzzled about the naming conventions for the CPU revision,
> > uboot says rev1.2, the kernel says
> > 
> > Processor	: ARMv7 Processor rev 10 (v7l)
> > ...
> > 
> > CPU implementer	: 0x41
> > CPU architecture: 7
> > CPU variant	: 0x2
> > CPU part	: 0xc09
> > CPU revision	: 10
> > 
> > how can I do the matching ?
> > 
> > Meanwhile, we noticed that compared to the evaluation kernel, we were missing
> > CONFIG_ARM_ERRATA_754322 and CONFIG_PL310_ERRATA_769419
> > 
> > Adding them helps a lot, but the freeze still happens on one machine
> > 
> > We are currently trying with 754322 + 769419 + 754327 + 5 nops in fec ... 
> > but not sure if we need 754327.
> > 
> > Regards
> > Thierry
> > 
> > PS: Regarding the thermal issue, we have changed our supplier, we now have
> > a dissipator that is big enough (it is the AMOS820 from Via Embedded)
> 
> I am not sure how to read the A9 revision.  I have this on a system:

I have found the method I gave in ARM documentation. I am pretty
sure this is how it works.

-- 
					    Gilles.

