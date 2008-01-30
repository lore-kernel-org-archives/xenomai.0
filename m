Message-ID: <2ff1a98a0801300654r5d6a30c3vbc4a28e126e30ad1@domain.hid>
Date: Wed, 30 Jan 2008 15:54:44 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376803@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D376803@domain.hid>
Subject: Re: [Xenomai-help] rt_task_set_periodic()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Jan 30, 2008 3:52 PM, Steven Seeger
<sseeger@domain.hid> wrote:
>
>
>
>
> I notice that I only get =96EAGAIN (-11) when I call rt_task_set_periodic=
()
> when I have a kernel module loaded that calls rt_timer_set_mode(125000) t=
o
> start a periodic timebase of 125us. If I don't do this, then it works as
> expected. Any idea?

Check the return value of rt_timer_set_mode.

--=20
                                               Gilles Chanteperdrix

