From: =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>
Date: Mon, 13 Jun 2016 15:14:05 +0000
Message-ID: <d7f1e0d09cba4c14a5e0e20d168a2141@EDB2.wapice.localdomain>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
 <09ef98ed5f8a438fa3703a3e3f5736f5@EDB2.wapice.localdomain>
 <20160613143016.GJ898@hermes.click-hack.org>
In-Reply-To: <20160613143016.GJ898@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] PowerPC hardware watchpoints unstable with GDB and
 Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Whether or not you should contact the gdb mailing list is simple: if you =
get the issue without Xenomai, then it is a=20
> gdb issue, if you get the issue only with Xenomai, then it is a Xenomai i=
ssue, and there is no reason to bother the=20
> gdb mailing list.

Well, I had no idea which side contains the Xenomai support and I wished th=
e GDB guys to provide some debugging hints. But if you see it most probably=
 as a Xenomai issue, let's not cross-post it then.


> Xenomai 2.6.1 is pretty old, a lot of things have been fixed since then, =
including issues with gdb. So, do you get the same issue with Xenomai 2.6.4=
?

I will find out if we have the possibility of trying the version update wit=
h sensible effort.

A thought: I have been getting "warning: Unable to find libthread_db matchi=
ng inferior's thread library, thread debugging will not be available." at G=
DB startup, but ignored it this far as the threading has worked just fine..=
 Might this have anything to do with my issue, and does anyone know how to =
get rid of the message on Xenomai? I know how to specify the library for GD=
B, but which one should be the correct for Xenomai?

BR,
Lassi Niemist=F6
Wapice Oy
Vaasa, Finland

