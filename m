MIME-Version: 1.0
References: <10EBFD20-C1C9-4D96-BDD0-53F005DFE4A5@aliyun.com>
In-Reply-To: <10EBFD20-C1C9-4D96-BDD0-53F005DFE4A5@aliyun.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 28 Apr 2022 14:12:23 +0200
Message-ID: <CAFLxGvybFFac-WKKF1Rj-amayVx6ARD=6QA=fzf9OiJQwW2jmA@mail.gmail.com>
Subject: Re: How can I use RTDM skin in cmake
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ivan Jiang <jcgeforce@aliyun.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Apr 28, 2022 at 12:34 PM Ivan Jiang via Xenomai
<xenomai@xenomai.org> wrote:
>
> Dear Xenomais=E2=80=99
>
>
>
>        I know how to use RTDM Skin in makefile wich --rtdm in CFLAGS LFLA=
GS.
>
>        But if some cpp threads should use CMAKE and I really don=E2=80=99=
t know how to edit cmakelists with this skin.

xeno-config will show you all needed linker and compiler flags. You
can directly use these flags in CMake,
or any other build system. Lookup in the CMake documentation how to
set compiler/linker flags.
But there is no need to embedded the call to xeno-config in your build syst=
em.

--=20
Thanks,
//richard

