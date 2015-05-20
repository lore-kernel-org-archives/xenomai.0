From: Paul <paul_c@tuxcnc.org>
Date: Wed, 20 May 2015 11:11:20 +0100
References: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
In-Reply-To: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201505201111.20347.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wednesday 20 May 2015, Marco Baracchi wrote:
> We are using kernel *linux 3.0.35*, branch *imx_3.0.35_4.1.0* with
> patches *adeos-xenomai
> 2.6.4* for *mxc* on a freescale imx6 single core and we have =A0a
> problem with hrtimer: sometimes after a couple of hour our periodic
> task inside Xenomai blocks. checking inside /proc path we =A0found:
> ---------------------------------------------------------------------
>----------------------------------------------------------------------
>-------------------
>
> ~$ cat /proc/timer_list
> Timer List Version: v0.6
> HRTIMER_MAX_CLOCK_BASES: 3
> now at 23036522464643 nsecs
>
> cpu: 0
> =A0clock 0:
> =A0 .base: =A0 =A0 =A0 80bac120
> =A0 .index: =A0 =A0 =A00
> =A0 .resolution: 10000000 nsecs
> =A0 .get_time: =A0 ktime_get
> active timers:
> =A0#0: <8da95ad0>, hrtimer_wakeup, S:01
> * # expires at 21797170078601-21797175078598 nsecs [in -1239352386042
> to -1239347386045 nsecs]*
[...]
>-------------------
>
> seems the hrclock receive a negative next event.


If you look at the print_timer() function found in=20
kernel/time/timer_list.c, the last two values are cast to a long long.=20
Nothing to worry about, but perhaps an issue that should be addressed=20
via the linux kernel mailing list.

