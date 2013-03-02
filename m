Message-ID: <5131B5A2.6000501@web.de>
Date: Sat, 02 Mar 2013 09:17:38 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
	<5130E0C7.80709@siemens.com> <5130E6FE.2070905@siemens.com>
	<1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
In-Reply-To: <1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriele Moabiti <gabmoa@yahoo.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-03-02 01:47, Gabriele Moabiti wrote:
> =

> =

> ----- Messaggio originale -----
> =

> Da: Jan Kiszka <jan.kiszka@siemens.com>
> On 2013-03-01 18:09, Jan Kiszka wrote:
>> There is more broken, even in latest stable 3.5.7. See the patches at
>> [1] for a tested version. Unfortunately, I cannot update my tree for 3.8
>> ATM as git services seem to be down on xenomai.org.
> =

> Does this and other important patches will be backported to 3.2?

I'm planning to get them merged into 3.8 first of all, maybe also into
3.5 (as this is our current production baseline). No plans exist beyond
that. I'd rather like to leave older kernels alone to reduce maintenance
efforts (porting is simple, proper testing takes time).

Also note that 3.2 is lacking much more critical fixes than those few
around KVM. IOW: Don't use it for anything serious with x86.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130302/2853328=
2/attachment.pgp>
