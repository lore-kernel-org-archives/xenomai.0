Message-ID: <2ff1a98a0804070626w486964a2kd56232bbeaddecaf@domain.hid>
Date: Mon, 7 Apr 2008 15:26:58 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0804070616u297997b3yc5a5cb19fe387ee9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0804070547w1695b78dp2a3ed1ce87595855@domain.hid>
	<OF6D5F47BF.2D764233-ONC1257424.0047BBF6-C1257424.00482F9C@retarus.de>
	<2ff1a98a0804070616u297997b3yc5a5cb19fe387ee9@domain.hid>
Subject: Re: [Xenomai-core] posix-skin: unexpected scheduler behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Apr 7, 2008 at 3:16 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Apr 7, 2008 at 3:08 PM, Thomas Wiedemann
>
> <Thomas.Wiedemann@domain.hid> wrote:
>
> > "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> schrieb am
>  >  07.04.2008 14:47:05:
>  >
>  >
>  >  > Forget it, it will not work. What you are trying to do can not work as
>  >  > long as Xenomai and Linux are two distinct schedulers: Xenomai tasks
>  >  > running in secondary mode are suspended from Xenomai scheduler point
>  >  > of view, so, you can yield as much as you want, this will never let
>  >  > them run.
>  >
>  >  But the behaviour is still the same, when i put a
>  >
>  >          pthread_set_mode_np(PTHREAD_PRIMARY, 0);
>  >
>  >  in the thread function. Thereafter, only the xenomai-scheduler is
>  >  responsible for the threads running in primary mode, or am i completely
>  >  wrong?
>
>  The thread remains in primary mode as long as you do not call a
>  secondary mode service, such as pthread_barrier_wait or fprintf.

Besides, the correct syntax is:
pthread_set_mode_np(0, PTHREAD_PRIMARY)

-- 
 Gilles

