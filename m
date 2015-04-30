From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 30 Apr 2015 16:44:46 +0200
Message-ID: <5455853.puTnBMi752@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <20150430144105.GU1993@hermes.click-hack.org>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <20150430144105.GU1993@hermes.click-hack.org>
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

Am Donnerstag, 30. April 2015, 16:41:05 schrieb Gilles Chanteperdrix:
> No. At least ARM and x86 architectures are supposed to support the
> stack protector. Maybe you could tell us on what architecture you
> have this issue?

The platform is 32bit x86. GCC version is 4.9.2. I can reliably get the =

behaviour by switching just this single config option on three different =

machines. =


Anything else I can do to help troubleshooting? The kernel actually does no=
t =

print any message to the console even with all debugging information (ipipe =

and xenomai) switched on. Most of the time it just reboots, which seems =

strange to me as is (the TCO watchdog etc is switched off and reboot on pan=
ic =

also..). It did hang on some trys also though ... (not fully reproducible)

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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150430/e1a124f=
2/attachment.sig>
