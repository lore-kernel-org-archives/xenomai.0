From: "Bjoern Slotkowski" <bjoern.slotkowski@domain.hid>
Date: Tue, 15 Jul 2008 13:53:45 +0200
Message-ID: <AEEPJNCLKODJPOANLAJJAEHECIAA.bjoern.slotkowski@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20080715102911.4187A24304@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] MPC5200 and 2.6.25-powerpc-DENX
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wd@domain.hid
Cc: xenomai@xenomai.org

Thanks for your help especially the feature of the snapshots.
Think my git version was to old (1.4).

But I still have a question:
What is the right kernel - snapshot.
In the README file in ksrc/arch/powerpc/patches are
GIT commit numbers for linux version 2.6.23 ,24 and 2.4.25 but not for
2.6.25.

I took a snapshot near the date xenomai 2.4.4 was released but I still ge=
t
"hunks failed"
when I patch the ipipe and I fear this is not ok.


Best regards,

Bjoern


-----Urspr=FCngliche Nachricht-----
Von: wd@domain.hid [mailto:wd@domain.hid]
Gesendet: Dienstag, 15. Juli 2008 12:29
An: Bjoern Slotkowski
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] MPC5200 and 2.6.25-powerpc-DENX


In message <AEEPJNCLKODJPOANLAJJMEHBCIAA.bjoern.slotkowski@domain.hid>
you wrote:
>
> And this is my problem: Where can I get the 2.6.25-powerpc-DENX-2.2-02
> kernel ?

You can get this (and any other version) from our git repository.

> I tried to get the linux-2.6-denx on Denx's homepage via git.
> Our firewall blocks port 9418 so I used http but get the error
> "Couldn't get http://git.denx.de/linux-2.6-denx.git/refs/heads/405EX fo=
r
> heads/405EX".

You can also use HTTP protocol (although *much* slower), and you  can
even  download  compressed  tarballs simply by clicking on one of the
"snapshot" links.

> Am I on the right way and if not can someone point me to the right way =
?

Hope this helps.

> imc Messsysteme GmbH    Tel:   +49 30 46 70 90 23

Ah. Please say hallo to Steven Scholz...

Best regards,

Wolfgang Denk

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
God grant me the senility to accept the things I cannot  change,  The
frustration  to  try to change things I cannot affect, and the wisdom
to tell the difference.


