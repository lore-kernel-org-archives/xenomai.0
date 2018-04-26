From: Edouard Tisserant <edouard.tisserant@gmail.com>
Message-ID: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
Date: Thu, 26 Apr 2018 09:02:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Good Morning !

I'm chasing the origins of a random segfault when porting Beremiz to
Xenomai 3.

Beremiz PLC runtime loads PLC logic as a shared object. Loading is
performed as dlopen call from python interpreter. Each time PLC
programmer tries a new program, previous shared object is dlcosed and
the new program is dlopened.

Of course, there is in depth checks to ensure that all
dlopen/dlclose/dlsym operations are done from main thread only, and it
is ensured that all real time tasks and resources have been closed
before dlclose.

Also, I did check that implicit call to xenomai_init_dso() really
happens, when linking shared object with bootstrap-pic.o . I also tried
explicit call to xenomai_init (once at first load or after every
dlopen), no change.

I tried last commit about this topic : "boilerplate/setup: introduce
destructors for __setup_call"
(5511e76040444af875ae1bb099c13a25b16336fc). It didn't help,
unfortunately, but did remove Xenomai "Bad syscall" warning sometimes
after dlclose.

Segfault never happen at first reload. i.e. dlopen/dlcose/dlopen never
fails. You have to at least extend the sequence to
dlopen/dlcose/dlopen/dlcose/dlopen to see the crash. In other words,
smokey/dlopen test doesn't try hard enough to catch the problem. I have
to reload about 6 times to have a crash. Also, it seems that crash has
higher probability to occur if no symbol was called from shared object
in between dlopen and dlclose (dlsym was called).

Enabling full Xenomai debug didn't display more details on the crash.
Post-mortem debug (gdb -c core) works, but gdb can't give me any
backtrace :

(gdb) bt
#0=C2=A0 0x00007fb8 in ?? ()
#1=C2=A0 0xb520c098 in ?? ()

Is there a way to have gdb telling a bit more about what happens in
boilerplate/copperplate ? How can I find where it crashes ?

Cheers,

Edouard



