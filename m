From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 5 Apr 2018 11:39:14 +0000
Message-ID: <DB6PR0701MB24560C064C4B2E0CA3E8BA72B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456FE5A9F080B3BE39375E0B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <08c2ad36-f2c4-952f-5372-bd95146943cf@xenomai.org>
In-Reply-To: <08c2ad36-f2c4-952f-5372-bd95146943cf@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] doc for xeno-config skins
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks and sorry for overlooking that. I thought if there was some docs on =
xeno-config it would have been inlined in its source, so that is where I lo=
oked for it. I guess the man folder should have been a more obvious choice.

Is it correct that calling `xeno-config --skin cobalt` expects you to call,=
 POSIX functions prefixed with `__wrap_` ? Does this mean that the *actual*=
 "Cobalt POSIX interface" consists of __wrap_fn() calls as opposed to fn() =
calls?
If yes,  is this documented somewhere obvious? I kind of figured this out o=
ver time by reading http://xenomai.org/2014/08/porting-a-linux-application-=
to-xenomai-dual-kernel/  and looking at the wrappers files and at the sourc=
e code, but is it stated clearly somewhere?=20
This is a place where I would have looked for that, for instance: http://ww=
w.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api.html=
 .

(incidentally, these two images (referenced by the xeno-config man page) ar=
e missing
http://www.xenomai.org/documentation/xenomai-3/html/man1/asciidoc-icons/not=
e.png
http://www.xenomai.org/documentation/xenomai-3/html/man1/asciidoc-icons/cau=
tion.png
)

Thanks,
Giulio
________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 05 April 2018 07:36
To: Giulio Moro; xenomai@xenomai.org
Subject: Re: [Xenomai] doc for xeno-config skins

On 04/04/2018 10:15 PM, Giulio Moro wrote:
> What is the difference between the Posix and Cobalt skin, as far as xeno-=
config is concerned??
>
> Difference between
>   xeno-config --skin posix --cflags
>   xeno-config --skin cobalt --cflags
> is that the former declares -D__COBALT_WRAP__ (which in turn adds fwd dec=
larations for clock_nanosleep() and pthread_setname_np() in boilerplate/lib=
c.h).
>
> difference between
>   xeno-config --skin posix --ldflags
>   xeno-config --skin cobalt --ldflags
> is that the former adds `-Wl,@/usr/xenomai/lib/cobalt.wrappers`
>
> So it seems to me that `--skin posix` expects you to call, e.g.: pthread_=
create(), while `--skin cobalt` expects you to call, e.g.: __wrap_pthread_c=
reate()
>
> Is this correct?
> Is that it?
> What are the intended uses?
> I don't think this is documented anywhere? Where would be the best place =
to have this written down? Perhaps the --help of xeno-config? Also, while w=
e are at it, --skin alchemy vs --skin native and the effect of --compat cou=
ld use some description.
>

http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.=
html



--
Philippe.

