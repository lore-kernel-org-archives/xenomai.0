From: "Eichenberg, Marius" <Marius.Eichenberg@student.hpi.uni-potsdam.de>
Date: Thu, 8 Jan 2015 16:02:44 +0000
Message-ID: <87BB06E7C07D514A96969FF11282F7954DEFBF@MXSTU2012.hpi.uni-potsdam.de>
References: <87BB06E7C07D514A96969FF11282F7954DEB98@MXSTU2012.hpi.uni-potsdam.de>
 <20150108153519.GC21505@hermes.click-hack.org>,
 <20150108153947.GD21505@hermes.click-hack.org>
In-Reply-To: <20150108153947.GD21505@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Is there a specification?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hey Gilles, =0A=
thanks for your fast response.=0A=
=0A=
Actually we don't want to implement an own skin. =0A=
We just want to compare the tasks from OSEK and the one from Xenomai (versi=
on 3 is preferred).=0A=
=0A=
For now we were using the Task Management Service of the Alchemy API as a r=
eference.=0A=
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__t=
ask.html=0A=
=0A=
The API is good for a specific mapping of the methods, but we're missing an=
 abstract overview.=0A=
Especially a conceptual description how Xenomai sees tasks,=0A=
e.g. which states are available, when are transitions firing?=0A=
=0A=
Thank you a lot,=0A=
Cheers=0A=
________________________________________=0A=
Von: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Gesendet: Donnerstag, 8. Januar 2015 16:39=0A=
An: Eichenberg, Marius=0A=
Cc: xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] Is there a specification?=0A=
=0A=
On Thu, Jan 08, 2015 at 04:35:19PM +0100, Gilles Chanteperdrix wrote:=0A=
> On Thu, Jan 08, 2015 at 03:13:10PM +0000, Eichenberg, Marius wrote:=0A=
> > Hey folks,=0A=
> > we're a team of two students at a university in Germany.=0A=
> >=0A=
> > Currently we're trying to evaluate how easy it is to map tasks=0A=
> > from Autosar (OSEK) to Xenomai. Therefore we're looking for a=0A=
> > specification of Xenomai. Right now we're dealing with the API,=0A=
> > but this is acutally a little bulky.=0A=
>=0A=
> The API documentation is big because it documents several=0A=
> interfaces, the underlying common interface as well as several skins=0A=
> implemented on top of this common interface. But implementing a new=0A=
> interface such as OSEK means implementing a new skin, on top of the=0A=
> common interface only.=0A=
>=0A=
> For Xenomai 2.x, this common interface resides in kernel-space and=0A=
> is documented here:=0A=
> https://xenomai.org/documentation/xenomai-2.6/html/api/group__nucleus.htm=
l=0A=
>=0A=
> For Xenomai 3.x (which is recommended for starting a new=0A=
> development), this common interface moved to user-space, is based on=0A=
> the POSIX interface and is documented here:=0A=
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy.=
html=0A=
=0A=
Sorry, wrong link. The Alchemy interface is a skin, like the OSEK=0A=
skin, so you could use it as an example for implementing a new skin.=0A=
=0A=
The common interface for user-space skins is now posix, with the=0A=
copperplate library masking differences between Xenomai posix=0A=
implementation and Linux posix implementation. The alchemy or=0A=
vxworks skins are example of using posix and copperplate to=0A=
implement a new skin.=0A=
=0A=
--=0A=
                                            Gilles.=0A=

