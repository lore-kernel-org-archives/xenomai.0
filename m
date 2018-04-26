Date: Thu, 26 Apr 2018 13:07:53 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180426130753.53daba34@md1pvb1c.ad001.siemens.net>
In-Reply-To: <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edouard Tisserant <edouard.tisserant@gmail.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi,

i recently looked into dlopen()/dlclose() again, because the testcase i
wrote did not really work.

What i found is that dlclose() currently can not work because we lack
destructor code for the core and skins. Removing the setup_descriptors
from the list is only a small fraction of what would actually be needed.

In fact we would need the reverse of
"struct setup_descriptor->init()" for every file in lib/*/init.c.
On dlclose() one would need to call those and remove the descriptor
from the list. But since there are no destructors we are leaking half
initialized state because dlclose() might not actually go and free all
its memory/state.

So for now the state is that dlclose() is not supported, restart your
application if you need another "plugin".
Enabling dlclose() is sure possible, but not trivial.

Could you please have a look at
http://www.xenomai.org/pipermail/xenomai/2018-April/038821.html

That will actually "prevent" dlclose.

Henning

Am Thu, 26 Apr 2018 11:24:19 +0200
schrieb Edouard Tisserant <edouard.tisserant@gmail.com>:

> One more question. Sorry for flooding the list.
>=20
> As a workaround to avoid leaking memory, I would like to try this :
>=20
> =C2=A0- xeno_stub.so : stub library, linked with bootstrap-pic.o
> =C2=A0- 1.so, 2.so, ... n.so : libraries calling alchemy/posix realtime
> resources, NOT linked with bootstrap-pic.o
>=20
> Process life-cycle would be :
>=20
> - process start
>=20
> dlopen(xeno_stub.so)
>=20
> dlopen(1.so)
> dlsym + call 1.so
> dlclose(1.so)
> ...
> dlopen(n.so)
> dlsym + call n.so
> dlclose(n.so)
>=20
> dlclose(xeno_stub.so)
>=20
> - process end
>=20
> Is that correct to assume that this way, pointers setup while calling
> xenomai_init() as a side effect of first dlopen() would stay valid
> while other non-bootstrap-pic libraries are loaded and unloaded ?
>=20
>=20
> On 26/04/2018 09:39, Edouard Tisserant wrote:
> > @Henning Schild :
> >
> > I just see your message from Tuesday : '[PATCH 3/3] build: link
> > dlopen libs with "nodelete"'
> >
> > Is "nodelete" the only way to make it stable ? Does it apply only to
> > Xenomai libs (i.e. alchemy, copperplalte) or should it also apply to
> > final shared object that uses Xenomai libs ?=C2=A0
> >
> > Edouard
> >
> >
> > On 26/04/2018 09:02, Edouard Tisserant wrote: =20
> >> Good Morning !
> >>
> >> I'm chasing the origins of a random segfault when porting Beremiz
> >> to Xenomai 3.
> >>
> >> Beremiz PLC runtime loads PLC logic as a shared object. Loading is
> >> performed as dlopen call from python interpreter. Each time PLC
> >> programmer tries a new program, previous shared object is dlcosed
> >> and the new program is dlopened.
> >>
> >> Of course, there is in depth checks to ensure that all
> >> dlopen/dlclose/dlsym operations are done from main thread only,
> >> and it is ensured that all real time tasks and resources have been
> >> closed before dlclose.
> >>
> >> Also, I did check that implicit call to xenomai_init_dso() really
> >> happens, when linking shared object with bootstrap-pic.o . I also
> >> tried explicit call to xenomai_init (once at first load or after
> >> every dlopen), no change.
> >>
> >> I tried last commit about this topic : "boilerplate/setup:
> >> introduce destructors for __setup_call"
> >> (5511e76040444af875ae1bb099c13a25b16336fc). It didn't help,
> >> unfortunately, but did remove Xenomai "Bad syscall" warning
> >> sometimes after dlclose.
> >>
> >> Segfault never happen at first reload. i.e. dlopen/dlcose/dlopen
> >> never fails. You have to at least extend the sequence to
> >> dlopen/dlcose/dlopen/dlcose/dlopen to see the crash. In other
> >> words, smokey/dlopen test doesn't try hard enough to catch the
> >> problem. I have to reload about 6 times to have a crash. Also, it
> >> seems that crash has higher probability to occur if no symbol was
> >> called from shared object in between dlopen and dlclose (dlsym was
> >> called).
> >>
> >> Enabling full Xenomai debug didn't display more details on the
> >> crash. Post-mortem debug (gdb -c core) works, but gdb can't give
> >> me any backtrace :
> >>
> >> (gdb) bt
> >> #0=C2=A0 0x00007fb8 in ?? ()
> >> #1=C2=A0 0xb520c098 in ?? ()
> >>
> >> Is there a way to have gdb telling a bit more about what happens in
> >> boilerplate/copperplate ? How can I find where it crashes ?
> >>
> >> Cheers,
> >>
> >> Edouard
> >>
> >> =20
> > =20
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


