Message-ID: <51A82D96.5000900@web.de>
Date: Fri, 31 May 2013 13:56:54 +0900
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <201305251236.38418.lux-integ@btconnect.com>
	<51A2F3EF.3080404@web.de>
	<201305281152.41490.lux-integ@btconnect.com>
In-Reply-To: <201305281152.41490.lux-integ@btconnect.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] uml question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: lux-integ <lux-integ@btconnect.com>
Cc: xenomai@xenomai.org

On 2013-05-28 19:52, lux-integ wrote:
> On Monday 27 May 2013 06:49:35 Jan Kiszka wrote:
>>
>> UML is not supported, but you can do driver development very comfortably
>> inside virtual machines - at least on x86 (other archs are just gaining
>> virtualization support). See [1] for more details.
>>
>> Jan
>>
>> [1]
>> http://chemnitzer.linux-tage.de/2012/vortraege/folien/1061-VirtualDebugg=
ing
>> .pdf
> =

> thanks for your link.  =

> =

> does  'is-not-supported' =3D  "cant-be-done"?

A lot can be done (in software), but this thing would not make sense.

> =

> "QEMU is a very flexible virtualization technology however it is quite sl=
ow =

> and it is recommended that you understand and evaluate alternative soluti=
ons =

> before picking this one"

QEMU is a CPU emulator is slow - compared to native or KVM-based
execution. Still, QEMU is faster in this domain than many other
*emulator*. But you don't need to worry when you have hardware
virtualization  support on your host and enabled KVM for QEMU.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130531/e8808c1=
5/attachment.pgp>
