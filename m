Message-ID: <51A2F3EF.3080404@web.de>
Date: Mon, 27 May 2013 07:49:35 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <201305251236.38418.lux-integ@btconnect.com>
In-Reply-To: <201305251236.38418.lux-integ@btconnect.com>
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

On 2013-05-25 13:36, lux-integ wrote:
> Greetings
> =

> I have some DAS  boards to develop linux-device drivers for. So I am plan=
ning =

> a driver-development-system. In my search on the internet for hints and c=
lues  =

> I came across links of RTAI with user-mode-linux but none with xenomai an=
d =

> user-mode-linux.
> =

> I am attracted to doing  the driver-developments using the analogy-API of =

> xenomai. So I would like to know if  xenomai can  be run on a user-mode-l=
inux =

> setup .

UML is not supported, but you can do driver development very comfortably
inside virtual machines - at least on x86 (other archs are just gaining
virtualization support). See [1] for more details.

Jan

[1]
http://chemnitzer.linux-tage.de/2012/vortraege/folien/1061-VirtualDebugging=
.pdf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130527/7a93a7a=
7/attachment.pgp>
