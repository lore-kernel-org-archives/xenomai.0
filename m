From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 30 Apr 2015 17:17:48 +0200
Message-ID: <3872595.UY9zmVq9KM@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150430151442.GW1993@hermes.click-hack.org>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <2238179.hbnctTCPtY@eltrolinux48.eltroad.eltropuls>
 <20150430151442.GW1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hang/Reboot when using
	CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Donnerstag, 30. April 2015, 17:14:42 schrieb Gilles Chanteperdrix:
> > I compared the disassembly of xnarch_switch_to with and without  the
> > option
> > set. That does like fine to me (even though i do not fully understand e=
ach
> > line..). The CANARY_SWITCH gets inserted correctly in to the
> > do_switch_threads inline function.
> =

> I guess the next step is to look at what this *_REGULAR option adds
> to CONFIG_CC_STACKPROTECTOR in the kernel code, and see if it does
> not add something more to switch_to that we should add to
> xnarch_switch_to.

This will probably take a bit of time on my side... =


Thank you for your help Gilles, I might have something more to say or ask n=
ext =

week...

Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150430/b264224=
0/attachment.sig>
