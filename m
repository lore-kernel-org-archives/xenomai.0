Message-ID: <5549DE97.2070902@xenomai.org>
Date: Wed, 06 May 2015 11:27:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5548DC34.3000903@free.fr>
In-Reply-To: <5548DC34.3000903@free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] V3 heap usage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/05/2015 05:05 PM, St=E9phane ANCELOT wrote:
> Hi,
>=20
> Since rtheap compat alchemy seems broken, I wanted to try native heap
> dynamic allocation.
>=20

Your test code is broken, not the API so far. Besides, I can only repeat
myself: there is no rtheap compat wrappers in the transition kit, simply
because there is no need for it:

http://www.xenomai.org/pipermail/xenomai/2015-April/034091.html
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Heaps

> I found xnheap_ functions.
>=20

These are kernel-space inner services for implementing the dual kernel
system. You most likely don't want to use them.

> However, in this case, I have to manage heap byte alignment.
>

No, that would make no sense, you must have misread the internal docs or
code.

> These are the right functions to use ? or I missed something ???
>=20

You seem to be missing the documentation:

http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy=
__heap.html

--=20
Philippe.

