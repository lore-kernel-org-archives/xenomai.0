From: Edouard Tisserant <edouard.tisserant@gmail.com>
References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
 <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
Message-ID: <e937a73f-ef0f-5394-bdae-400fcfe30ddb@gmail.com>
Date: Fri, 27 Apr 2018 12:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
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


> It seems that __xenomai_init() calls many things from the setup list, i=
n
> multiple shared objects. So I would need to build another flavor of the=

> boilerplate: bootstrap.so, from witch I can call xenomai_init() directl=
y
> using python's ctypes. Does it look realistic ?

For the record, following python code calls xenomai_init_dso() directly
from libcobalt.so.

from ctypes import *
# declaration
argvp_type =3D POINTER(POINTER(POINTER(c_char)))
cobalt =3D cdll.LoadLibrary("libcobalt.so")
cobalt.xenomai_init_dso.argtypes =3D (POINTER(c_int), argvp_type)
# init params
argc =3D c_int(0)
argv =3D (POINTER(c_char) * 2)()
argv[0] =3D create_string_buffer("prog_name")
argv[1] =3D None
# call
cobalt.xenomai_init_dso(pointer(argc), cast(pointer(argv), argvp_type))

Now let see if dlopen/dlclose some code using alchemy segfaults or not...=


--
Edouard



