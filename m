Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Thu, 09 Apr 2020 20:10:57 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>,
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>,
 <20200408114406.6119E0D9@centrum.cz>,
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>,
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
In-Reply-To: <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20200409201057.74CB5ED0@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

> Don't use signal().
> Use sigaction() and *don't* set SA_RESTART. Maybe read() is always restar=
ted...
=C2=A0
Thank you for trying to help me.
But with the sigaction (without SA_RESTART) the behavior is completely the =
same:
Only Ctrl+C or kill(0, SIGINT) are able to invoke the signalHandler.The rea=
d() is not interrupted (maybe syscall restart in some inner cycle).Example =
of the signal handler setup:
=C2=A0=C2=A0=C2=A0 // Setup signal handler
=C2=A0=C2=A0=C2=A0 struct sigaction act;
=C2=A0=C2=A0=C2=A0 memset(&act, 0, sizeof (act));
=C2=A0=C2=A0=C2=A0 act.sa_handler =3D signalHandler;
=C2=A0=C2=A0=C2=A0 sigaction(SIGINT, &act, NULL);
=C2=A0=C2=A0=C2=A0 sigaction(SIGTERM, &act, NULL);
=C2=A0
Petr

