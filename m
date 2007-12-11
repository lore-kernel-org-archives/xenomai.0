Message-ID: <2ff1a98a0712110541x12633fa3yb311214d9d0245a1@domain.hid>
Date: Tue, 11 Dec 2007 14:41:03 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <475E8DAE.9070405@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid> <475E8DAE.9070405@domain.hid>
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Dec 11, 2007 2:16 PM, Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote:
> Jan Kiszka escribi=F3:
> > That's due to the reworked timer subsystem: Starting timers (like the
> > periodic task timer) in the past is reported as error - up to the
> > application in this case. One may discuss if this case can be considere=
d
> > as an undocumented API change (I haven't re-read the docs in this regar=
d
> > yet).
> >
> I correct myself. The API actually states that the -ETIMEDOUT error code
> will be return if passed idate is in the past. But that is true for the
> 2.3.x series and for the new 2.4.0 version.
>
> Which means that the true difference between 2.3.x and 2.4.0 is that:
>
> 2.3.x: returns -ETIMEDOUT but schedules the task for immediate execution.
>
> 2.4.0: returns -ETIMEDOUT and *does not* schedule the task for immediate
> execution.
>
> The more I think about it the mode I think this is a bug.
>
> I just can't think of a situation in which idate is in the past and it
> makes sense *not scheduling* the task for immediate execution...

Why not passing TM_NOW as an initial date if you want the task to be
scheduled immediately instead of passing a date in the past ? It has
always worked and still works with Xenomai 2.4.0.


--=20
                                               Gilles Chanteperdrix

