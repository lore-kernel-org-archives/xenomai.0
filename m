Date: Wed, 31 Jul 2019 10:22:37 +0200
From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: Re: Fwd: Building Xenomai 3 , Kernel 4 ... for BeagleBone Black
Message-ID: <20190731082237.ccmhpfgda4fdd3nr@jholzmayr.localdomain>
References: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
 <9a2d7001-a0d7-b87c-be89-c4cad2051273@siemens.com>
 <CAEmXcAwpe3dVcriUjFYdvsQB0Kra13nY+yLtCDCyzoeCww+xCA@mail.gmail.com>
 <CAEmXcAzc2Z1J0LTEtFXZ3TrXC767Z=6DSOCpicVHPO3yFh98_Q@mail.gmail.com>
 <20190731070153.tp5c5naflbv3nmdw@jholzmayr.localdomain>
 <CAEmXcAx1ehvtUSR9fMPfV21ts3kcGPHnHYOfAZf82hJwb=wCQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmXcAx1ehvtUSR9fMPfV21ts3kcGPHnHYOfAZf82hJwb=wCQA@mail.gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jul 31, 2019 at 09:59:41AM +0200, danwe wrote:
> Thanks for the setup. Sorry for asking but as I am new to that topic I
> don't understand how to use that site u sent me. Do I have to download
> Xenomai 3 first and then copy/paste the files on your site? I don't really
> understand the readme file.
> For example: In the readme file I see the following:
> 
> 
> 
> After adding meta-core and a BSP layer (right now there's only meta-beaglebone
> available, so probably that one!), build the xenomai-test-image.
> 
> 
> So now I ask myself. Where should I add meta-core and meta-beaglebone to
> and how can I build the xenomai-test-image then?
> I don't understand the dependencies.

Its a completely generic OpenEmbedded build setup. If you're not used to
doing so, just go to readme item IV: Using kas. Then it essentially
boils down to the three commands given there verbatim, just needing
docker to be available as well as quite some HD space and CPU cycles.

> 
> Thanks.
> 
> Daniel
> 
> Am Mi., 31. Juli 2019 um 09:01 Uhr schrieb Josef Holzmayr <
> holzmayr@rsi-elektrotechnik.de>:
> 
> > On Wed, Jul 31, 2019 at 08:50:18AM +0200, danwe via Xenomai wrote:
> > > Thanks for your response. Maybe it was a bit unclear from my side:
> > > I need to build the Kernel and Xenomai 3. So I do neither want to build
> > the
> > > kernel and userland tools on top of an existing image nor building
> > anything
> > > on top. Or what do you mean by building on top? Is there anything
> > "deeper"
> > > than a Kernel?
> > > And again: Does building a Kernel with Xenomai 3 depends on the paltform
> > I
> > > want to use it on? I need to use it on a BeagleBone Black. Do I have to
> > > change anything for use it on BBB?
> > > Thanks.
> >
> > You could use the setup I employ for doing the CIP kernel tests. All
> > nicely prepared for Xenomai 3 and BBB, only thing you'd have to swap out
> > is the kernel itself which is not too complicated.
> >
> > https://github.com/LetoThe2nd/meta-xenomai

Greetz

-- 
———————————————
Josef Holzmayr
Software Developer Embedded Systems

Tel: +49 8444 9204-48
Fax: +49 8444 9204-50

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
———————————————
Amtsgericht Ingolstadt – GmbH: HRB 191328 – KG: HRA 170393
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
Ust-IdNr: DE 128592548 

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


