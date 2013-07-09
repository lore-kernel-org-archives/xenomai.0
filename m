From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Tue, 9 Jul 2013 12:18:07 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
In-Reply-To: <51DBF250.9070804@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE :  No boot kernel with xenomai on i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

On git under tags, the latest version of Xenomai is 2.6.2.1 (5 months ago),=
 and I think that is the same version I use.

Could you give me the direct link to get the latest version of xenomai, ple=
ase ?

I have a question about the images put on the target : I took the rootfs an=
d the u-boot from LTIB, and took only the uImage from : build_root/linux/ar=
ch/arm/boot/uImage

Is this right ? And is there something else to do ? To put the patched kern=
el with Xenomai on the target.

Regards,

Younes CHALABI
________________________________________
De : Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Date d'envoi : mardi 9 juillet 2013 13:21
=C0 : Younes CHALABI
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai] No boot kernel with xenomai on i.MX6Q Sabrelite

On 07/09/2013 12:40 PM, Younes CHALABI wrote:

> Hi to all,
>
> I am currently trying to deploy Xenomai-2.6.2.1 patched to Linux-3.0.35 (=
Freescale Release) on the i.MX6Q Sabrelite board.
>
> I followed this procedure for the installation : http://www.xenomai.org/d=
ocumentation/xenomai-2.6/html/README.INSTALL/#arm
>
> When I boot the target with an microSD card, the kernel starts to uncompr=
essing but at one moment stops at this line : Switching to clocksource ipip=
e_tsc ; and nothing happens after.
>
> Any suggestion will be welcome.


Could you try with the latest version from xenomai git instead of 2.6.2.1?

--
                                                                 Gilles.

