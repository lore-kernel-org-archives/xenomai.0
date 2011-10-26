MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <patchbomb.1318861189@domain.hid>
References: <patchbomb.1318861189@domain.hid>
Date: Wed, 26 Oct 2011 11:44:12 +0200
Message-ID: <CAAXf6LW+yy24Ks6RNOc4_5-Ltonx12SVOrGEKd-Aw4ATGTVaUg@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [PATCH 0 of 4] xenomai-forge PSOS: miscellaneous
	fixes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

On Wed, Oct 19, 2011 at 5:02 PM, Thomas De Schampheleire
<patrickdepinguin+xenomai@domain.hid> wrote:
> This patch series includes some misc. fixes to xenomai-forge:
>
> * definition of ERR_OBJTFULL (should also be added to Xenomai proper)
> * port long_names feature to xenomai-forge and fix it
> * add tm_getm() function (not present in pSOS but present in Xenomai prop=
er)
> * fix compiler warning in task.c
>
> Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@domain.hid=
>
> Signed-off-by: Ronny Meeus <ronny.meeus@domain.hid>
>
> ---
> =A0include/psos/Makefile.am =A0| =A0 2 +-
> =A0include/psos/Makefile.in =A0| =A0 2 +-
> =A0include/psos/long_names.h | =A014 ++++++++++++++
> =A0include/psos/psos.h =A0 =A0 =A0 | =A0 5 +++++
> =A0lib/psos/init.c =A0 =A0 =A0 =A0 =A0 | =A015 +++++++++++++++
> =A0lib/psos/pt.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 6 ++++++
> =A0lib/psos/queue.c =A0 =A0 =A0 =A0 =A0| =A0 6 ++++++
> =A0lib/psos/rn.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 5 +++++
> =A0lib/psos/sem.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 6 ++++++
> =A0lib/psos/task.c =A0 =A0 =A0 =A0 =A0 | =A0 9 +++++++--
> =A0lib/psos/tm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 7 +++++++
> =A011 files changed, 73 insertions(+), 4 deletions(-)
>
>
>

Do you have any comments on this patch series?

Thanks,
Thomas

