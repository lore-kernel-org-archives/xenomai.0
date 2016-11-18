References: <582ADD06.5000901@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7485f9e5-cba3-4766-e263-04c8e98e3ec0@xenomai.org>
Date: Fri, 18 Nov 2016 19:17:31 +0100
MIME-Version: 1.0
In-Reply-To: <582ADD06.5000901@numalliance.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe trace understanding
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/15/2016 11:01 AM, St=E9phane ancelot wrote:
> Hi,
>=20
> In order to solve my realtime pb, I  have a bit  some problems to
> understand my ipipe trace that has been frozen.
>=20
> My task should normally spend almost 200us to run and in this case, it
> spends more than 500us.
>=20
> My task starts at -723 and stops at -14.
>=20
> I made some comments in the trace, but have problem understanding where
> is the biggest problem.
>=20

[snip]

> (__cobalt_mq_timedreceive+0x25c)
> :|  + begin   0x80000000  -439      0.220  hard_local_irq_disable+0x16
> (__xnlock_get_irqsave.constprop.11+0x9)
> :|  # func                -438      0.493  __put_fd+0x0 (rtdm_fd_put+0x22)
> :|  # func                -438      0.206  __ipipe_restore_head+0x0
> (__xnlock_put_irqrestore.constprop.10+0x67)
> :|  + end     0x80000000  -438! 423.494  hard_local_irq_enable+0x17
> (__ipipe_restore_head+0x70)

This section denotes a transition to user-space, the application code
resumes from a mq_timedreceive() call, running for 423 us before issuing
another Cobalt syscall:

> :   + func                 -14+   2.201  ipipe_fastcall_hook+0x0
> (system_call_after_swapgs+0x6b)
> :   + func                 -12      0.543  handle_head_syscall+0x0
> (ipipe_fastcall_hook+0x18)
>=20

Of course, assuming x86 is your target architecture, this might be a SMI
event happening during this transition too, but I would investigate the
most probable (and fixable) cause first.

--=20
Philippe.

