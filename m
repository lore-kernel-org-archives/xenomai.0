Resent-Message-ID: <20141005143200.GA14975@sisyphus.hd.free.fr>
Resent-To: xenomai@xenomai.org
Date: Sun, 5 Oct 2014 15:52:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141005135208.GC20179@sisyphus.hd.free.fr>
References: <20141004125236.655cdb65@warrawoona.sti>
 <20141004111706.GA7596@sisyphus.hd.free.fr>
 <20141005120601.112acc4e@warrawoona.sti>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141005120601.112acc4e@warrawoona.sti>
Subject: Re: [Xenomai] Porting ipipe to vendor specific kernel. Newbie
 question.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>

On Sun, Oct 05, 2014 at 12:06:01PM +0600, Alexey Shaposhnikov wrote:
> On Sat, 4 Oct 2014 13:17:06 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> > > 1) How to port core patch on newer (than 3.4.6) kernel? Just run
> > > genpatches.sh give errors "unknown architecture for driver" and
> > > incomplete patch.
> > You have to modify genpatches.sh to add the architecture of the
> > missing files. This may be easier with versions of genpatches.sh for
> > newer kernel versions (the last I-pipe version supported is 3.14.17).
>
> Already tried this. But in result the script parse every driver code change
> since 3.4.6 and make over four hundreds errors about missing architecture for
> files like usb/serial/whiteheat.c

That is because genpatches.sh uses the stable kernel as a base for the
patch by default. You have to pass as argument to genpatches.sh the
hash of the commit you want it to use as base if you do not want
that default behaviour.

--
					    Gilles.

