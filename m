From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: [PATCH 1/2] cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
Date: Tue, 8 Oct 2019 14:36:48 +0000
Message-ID: <8682248.VGrCJTeWfp@omoikane>
References: <8271e30f-9fcf-b366-8154-922f988bf366@siemens.com>
 <12773854.dYiKgG3qDd@omoikane>
 <18df8bb2-52ac-105b-81da-4238f8ab8284@siemens.com>
In-Reply-To: <18df8bb2-52ac-105b-81da-4238f8ab8284@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F286A60174322A479D5F10BBBCEB6D1E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On Tuesday, October 8, 2019 10:33:13 AM EDT Jan Kiszka wrote:
> We "just" need a hook on return to user space in non-RT. But I'm not
> familiar with PPC to tell if that is already complex enough.

It should be pretty straight-forward. The issue is there are several sub-ar=
chs=20
of PPC32 that each have their own head file and I was thinking the ret_from=
*=20
files are in those, but in reality they're all in one file entry_32.S so it=
 may=20
not be as complicated as I thought.

> Can't help much with that decision. But it basically boils down to
> announcing such considerations, asking for feedback and then decide and
> communicate. But as some parts of our community are even then silent,
> you might need telepathy. ;)
>=20

I've seen one person other than me mention PPC on the list in the last few=
=20
months, but I'd need telepathy to find him at this point. I can't pay atten=
tion=20
to anything anymore because I'm trying to do 20 things at once. ;)

Steven




