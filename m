From: Edouard Tisserant <edouard.tisserant@gmail.com>
References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
 <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
 <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
Message-ID: <2e75fd33-8998-4cfb-6fa6-bef20f37f2dc@gmail.com>
Date: Fri, 27 Apr 2018 16:43:21 +0200
MIME-Version: 1.0
In-Reply-To: <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>


> Now let see if dlopen/dlclose some code using alchemy segfaults or not.=
=2E.

Well, it didn't work as-is, but I finally got it working !

If I was dlopening anything relying on copperplate after that python
code, then it was making an assert :=C2=A0 __register_setup_call: Asserti=
on
`!main_init_done' failed.

The reason is that all xenomai libraries we plan to use have to be
loaded _before_ call to xenomai_init, so that their setup call is
registered.

Hereafter is updated (and simplified) python code :

from ctypes import *
for name in ["cobalt", "modechk", "copperplate", "alchemy"]:
=C2=A0=C2=A0=C2=A0 globals()[name] =3D CDLL("lib"+name+".so", mode=3DRTLD=
_GLOBAL)
cobalt.xenomai_init(pointer(c_int(0)),
pointer((POINTER(c_char)*2)(create_string_buffer("python"), None)))

Note : Order of dlopen matters. Argument passed to
xenomai_init(&argc,&argv) are here only to prevent de-referencing NULL.

After this being executed, you can load and unload many shared object
that use alchemy and posix (they should not be linked to boostrap_pic.o)

Thanks for your answers.

--
Edouard



