MIME-Version: 1.0
Date: Tue, 10 Jun 2008 11:22:25 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <ec954c020e0057cc34ff395b2aed5715@domain.hid>
References: <ec954c020e0057cc34ff395b2aed5715@domain.hid>
Message-ID: <f22b8288613937c04516176f9b0c67dd@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Well I have to specify a little. My current vxworks application uses
tickAnounce() on an interrupt clock handler. I see that this routine is
implemented is vxworks skin. Moreover, I'm sure that tickAnnouce is the
only way the scheduler is swinging over my PPC. What I have to do is to g=
et
a hardware interrupt, or I have simulate a hardware interrupt.
Concerning the hardware interrupt, I don't really see what can I use.
Concerning the simulation, I think about creating a periodical xenomai
rt_task. But the problem is what is the influence of tickAnnouce over thi=
s
task ? Is there differencies running task over different CPUs ? How can I
be sure vxworks tasks are scheduled with tickAnnouce and Xenomai task are
schedule normally ?

matthieu

On Tue, 10 Jun 2008 10:43:13 +0200, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi
>=20
> Is it possible to change the value of the xenomai scheduler's ticks
period
> ? I would like the tasks to be scheduled each 1 millisecond for exemple=
.
I
> found out xnpod_tick_announce, but I didn't find any documentation and =
I
> didn't find the sources.
>=20
> Thank you in advence
>=20
> Matthieu



