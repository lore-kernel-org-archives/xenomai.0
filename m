From: Richard Weinberger <richard@nod.at>
Subject: Re: x86_64 kernel does not start under qemu
Date: Thu, 21 Mar 2019 12:57:54 +0100
Message-ID: <3154485.mhzyMJEECq@blindfold>
In-Reply-To: <ddd256e9-0e93-30bc-ddf0-e4f333d24d7f@siemens.com>
References: <CAFLxGvyyMEJ3t4K3dShxXMZccXCkuLN=bkTaTKLDugMieFD8ZA@mail.gmail.com>
 <73309048-fefd-20a4-31ae-1ce41b0fb8a6@siemens.com>
 <ddd256e9-0e93-30bc-ddf0-e4f333d24d7f@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "henning.schild@siemens.com" <henning.schild@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Am Donnerstag, 21. M=E4rz 2019, 12:02:45 CET schrieb Jan Kiszka:
> FWIW, I've just seen this issue as well, with QEMU in KVM mode: I ran int=
o that=20
> lockup when my host was under full load while Xenomai booted in the VM. A=
nd it=20
> seems reproducible. Debugging...

Oh, good to hear that!
I played a little with your config but got badly interrupted with other stu=
ff.
Your config seems to work but mostly because things are slower due to debug=
ging stuff
you've enabled. Maybe this info helps.

Thanks,
//richard




