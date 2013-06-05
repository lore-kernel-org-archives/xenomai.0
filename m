MIME-Version: 1.0
In-Reply-To: <50CB561D.5070706@grandegger.com>
References: <50CB364C.70706@wanadoo.fr>
	<50CB561D.5070706@grandegger.com>
Date: Wed, 5 Jun 2013 09:15:17 +0200
Message-ID: <CANKLDmugXc4M08TYJaq0ON-Ls04=xk=6oh3dR0gLD0CPBxZjxg@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Init issue with rtcan_flexcan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Thierry Bultel <thierry.bultel@wanadoo.fr>, xenomai@xenomai.org

On Fri, Dec 14, 2012 at 5:38 PM, Wolfgang Grandegger <wg@grandegger.com>wro=
te:

> On 12/14/2012 03:23 PM, Thierry Bultel wrote:
> > Hi,
> > some days ago I have posted a patch for the rtcan_flexcan to be
> > correctly probed on the iMX6q
> >
> > It is functional, but I have not tested it enough, I am sorry about tha=
t.
> > It only works if the linux flexcan driver module has been used once
> before.
> >
> > Else I have got IRQs but no packet go to the upper layer, I think it is
> > stuck in passive state, I am investigating on it.
>
> It would be nice if you could port the missing patches from the mainline
> Linux kernel to rtcan_flexcan.
>

I have ported code from the mainline linux flexcan driver that fixes the
behavior described by Thierry. Please find attached:
0001-make-rtcan_flexcan-driver-compatible-with-non-OpenFi.patch
0002-Fix-rtcan_flexcan-for-mx6-for-OpenFirmware-platforms.patch

The attached patches can be applied to the current mainline xenomai git
(anywhere after commit-3ddc61cda095a9ae51277608d7fd4e9c2c481625). They make
Thierry's patch obsolete.

I have tested the rtcan_flexcan driver in the non-CONFIG_OF configuration
only. On a wandboard with iMX6Solo using the freescale 3.0 kernel. I only
compile tested the CONFIG_OF configuration for the current ipipe master
(3.8) because wandboard solo is not yet supported by OpenFirmware. It would
be great if someone could test the OF version.

Thanks,
Henri


> Thanks,
>
> Wolfgang.
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-make-rtcan_flexcan-driver-compatible-with-non-OpenFi.patch
Type: application/octet-stream
Size: 4683 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130605/276cd6f=
e/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-Fix-rtcan_flexcan-for-mx6-for-OpenFirmware-platforms.patch
Type: application/octet-stream
Size: 8590 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130605/276cd6f=
e/attachment-0001.obj>
