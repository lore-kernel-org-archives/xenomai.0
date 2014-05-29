Message-ID: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Thu, 29 May 2014 16:42:15 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rtdm_mutex_init on forge
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,=0A=0AI have a question about rtdm_mutex_init in forge. BUG_ON is=A0=
=0Atriggered each time I create an rtdm_mutex. This seems to be=A0=0Adue to=
 a check in xnsynch_init, while apparently some=A0=0Aimplementation is stil=
l missing in rtdm_mutex_init():=A0=0A=0Avoid rtdm_mutex_init(rtdm_mutex_t *=
mutex)=0A{=0A=A0 =A0 =A0 =A0 spl_t s;=0A=0A=A0 =A0 =A0 =A0 /* Make atomic f=
or re-initialisation support */=0A=A0 =A0 =A0 =A0 xnlock_get_irqsave(&nkloc=
k, s);=0A=0A=A0 =A0 =A0 =A0 xnsynch_init(&mutex->synch_base,=0A=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, =
NULL);=0A=0A=A0 =A0 =A0 =A0 xnlock_put_irqrestore(&nklock, s);=0A}=0A=0A=0A=
void xnsynch_init(struct xnsynch *synch, int flags, atomic_long_t *fastlock=
)=0A{=0A=A0 =A0 =A0 =A0 if (flags & XNSYNCH_PIP)=0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 flags |=3D XNSYNCH_PRIO | XNSYNCH_OWNER;  /* Obviously... */=0A=0A=
=A0 =A0 =A0 =A0 synch->status =3D flags & ~XNSYNCH_CLAIMED;=0A=A0 =A0 =A0 =
=A0 synch->owner =3D NULL;=0A=A0 =A0 =A0 =A0 synch->cleanup =3D NULL;  /* O=
nly works for PIP-enabled objects. */=0A=A0 =A0 =A0 =A0 synch->wprio =3D -1=
;=0A=A0 =A0 =A0 =A0 INIT_LIST_HEAD(&synch->pendq);=0A=0A=A0 =A0 =A0 =A0 if =
(flags & XNSYNCH_OWNER) {=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(fastlock=
 =3D=3D NULL); // <---------- Obviously this is=0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //             =
always occurs for an=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //             rtdm_mutex.=0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 synch->fastlock =3D fastlock;=0A=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 atomic_long_set(fastlock, XN_NO_HANDLE);=0A=A0 =A0 =A0 =A0 } e=
lse=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synch->fastlock =3D NULL;=0A}=0A=0AAt=
 the moment I am not sure if the atomic_long_t counter needs be added to=A0=
=0Artdm_mutex or the flags need to be changed. Thanks for your help,=0A=0AM=
atthias

