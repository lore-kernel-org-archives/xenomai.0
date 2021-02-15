MIME-Version: 1.0
References: <CAFZ-hKgrQwCVW8rUsMjj4ySBA_P3aYDss273B244y2x69QrOpQ@mail.gmail.com>
 <358306354.8105980.1613394904650.JavaMail.zimbra@wolfram.com>
 <CAFZ-hKiDZg9V7PhGfw_1rPFqm063-CnL0LbQ_6cc5hjZrhDq8A@mail.gmail.com>
 <1968963516.8138258.1613396774639.JavaMail.zimbra@wolfram.com>
 <CAFZ-hKg=m0t_dF7iqzzb=xSd15zJdyFK6kxZ9oEXcJyqJ+zXew@mail.gmail.com>
 <a3d7098288f689f83be4a3fd43d82ba6de379a68.camel@sprinte.eu>
In-Reply-To: <a3d7098288f689f83be4a3fd43d82ba6de379a68.camel@sprinte.eu>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Mon, 15 Feb 2021 15:06:10 +0100
Message-ID: <CAFZ-hKi=Uc3f3hZokOtLOCazc-GMLEAeXyAOLWRM0QWR9uRMgw@mail.gmail.com>
Subject: Re: Mode Switch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

perfect it works! Thanks!

Il giorno lun 15 feb 2021 alle ore 14:57 Julien Blanc via Xenomai <
xenomai@xenomai.org> ha scritto:

> Le lundi 15 f=C3=A9vrier 2021 =C3=A0 14:52 +0100, Leandro Bucci via Xenom=
ai a
> =C3=A9crit :
> > What I want is to have a function that generates me mode switches
>
> __STD(nanosleep)(timeout, NULL) with a zero timeout should do it.
>
> and you can use any switch-primary call to go back to primary mode.
>
> Regards,
>
> Julien
>
