Date: Tue, 10 Nov 2015 15:28:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151110142814.GA4629@hermes.click-hack.org>
References: <5641F09E.3040608@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5641F09E.3040608@free.fr>
Subject: Re: [Xenomai] panic macro interference with xerces api.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Nov 10, 2015 at 02:26:54PM +0100, St=E9phane ANCELOT wrote:
> Hi,
>=20
> I don't know if there might be a  big impact, but I noticed, depending=20
> on the order we include headers , that
> there was a panic macro interfering with xercesc api headers.
>=20
> #include <alchemy/task.h>
> #include <xercesc/dom/DOMException.hpp>
>=20
>=20
> /usr/xenomai-3.0-igb/include/boilerplate/ancillaries.h:64:10: error:=20
> expected identifier before '__func__'
>    __panic(__func__, __fmt, ##__args)

Well, if the two headers define the same macro, there are not many
solutions: arrange for not having to include them in the same file.
It should not be too hard, since a real-time thread using
alchemy/task.h has no business using an xml library, probably only
using linux services which a real-time task can not use without
switching to secondary mode.

--=20
					    Gilles.
https://click-hack.org

