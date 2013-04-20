Message-ID: <51724F82.2000809@web.de>
Date: Sat, 20 Apr 2013 10:19:14 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>
	<517195B6.8020209@xenomai.org>
	<12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
In-Reply-To: <12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-04-20 08:04, Michael Haberler wrote:
> =

> Am 19.04.2013 um 21:06 schrieb Gilles Chanteperdrix <gilles.chanteperdrix=
@xenomai.org>:
> =

>> On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:
>>
>>> [1] =

>>> http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-April/006986.=
html
>>
>>
>> Hi,
>>
>> that link does not tell us why you need this option. And that would be
>> the most important information.
> =

> with the linuxcnc package build I need to turn on --enable-dlopen-skins a=
s well to get Python modules to work properly

OK, it looks like we should try harder to detect dlopen scenarios during
runtime to avoid build-time switches. This is likely Xenomai 3 material:

 - We need to disable TLS optimizations by default (no big deal).

 - In the POSIX skin constructor, we need to read out the mlockall
   state, lock everything if necessary, and restore the state
   accordingly afterward. The Nucleus may help us here if there is no
   adequate libc service (ABI change -> Xenomai 3).

 - IIRC, the problem with unconditional auto-shadowing back then were
   the improper scheduling parameters that POSIX used to apply. That
   was fixed a while back. So if we simple re-apply the current
   parameters, it should cause no harm in a dlopen scenario. But I need
   to check this again at work against our scenario.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130420/d3c1b2e=
3/attachment.pgp>
