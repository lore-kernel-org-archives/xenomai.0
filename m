From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 30 Apr 2015 17:12:09 +0200
Message-ID: <2238179.hbnctTCPtY@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <16271667.Fx8U4yiYQd@eltrolinux48.eltroad.eltropuls>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <20150430145352.GV1993@hermes.click-hack.org>
 <16271667.Fx8U4yiYQd@eltrolinux48.eltroad.eltropuls>
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
To: xenomai@xenomai.org

Am Donnerstag, 30. April 2015, 17:03:54 schrieb Marc Str=E4mke:
> Am Donnerstag, 30. April 2015, 16:53:52 schrieb Gilles Chanteperdrix:
> > Is CONFIG_CC_STACKPROTECTOR enabled when you enable the *_REGULAR
> > option ? The first thing to check is that the xnarch_switch_to
> =

> I can confirm that CONFIG_CC_STACKPROTECTOR gets set together with the
> *_REGULAR option. I am inspecting the disassembly now...

I compared the disassembly of xnarch_switch_to with and without  the option =

set. That does like fine to me (even though i do not fully understand each =

line..). The CANARY_SWITCH gets inserted correctly in to the do_switch_thre=
ads =

inline function.

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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150430/a003c92=
d/attachment.sig>
