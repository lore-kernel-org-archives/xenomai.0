References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
 <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <1dbe3f00-a866-248c-3799-a0d8efeee4e4@gmail.com>
Date: Thu, 26 Apr 2018 19:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
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


> If by pointer setup, you mean all the init stuff run by the various
> Xenomai libraries when called on behalf of xenomai_init(), then yes.
Perfect ! Then I will build that xeno_stub.so, dlopen() it and it will
be all fine....

Wait. Did I miss something ? I need to build and dlopen a stub shared
object in order to call something from bootstrap*.o ? Could I do that
directly by dlopening/calling the right shared object directly ?

It seems that __xenomai_init() calls many things from the setup list, in
multiple shared objects. So I would need to build another flavor of the
boilerplate: bootstrap.so, from witch I can call xenomai_init() directly
using python's ctypes. Does it look realistic ?

Also I wonder what happens to non-real-time threads witch have been
created before xenomai_init(). Is that safe if they are already running
threads using posix when xenomai_init() is called ? Should xenomai_int
be called before any thread is created ?

> The init sequence is explained here:
> http://xenomai.org/2015/05/application-setup-and-init/#Initialization_s=
equence
Seems like search engines never link to the real stuff. Many thanks.

--
Edouard


