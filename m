MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18216.53657.302556.690006@domain.hid>
Date: Wed, 31 Oct 2007 20:03:53 +0100
In-Reply-To: <1963009588.20071031182042@domain.hid>
References: <1078761341.20071030094041@domain.hid>
	<4726F2B5.5000307@domain.hid>
	<1935435350.20071030105318@domain.hid>
	<47270861.8090500@domain.hid>
	<1963009588.20071031182042@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] how to stop a runaway task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
Cc: xenomai@xenomai.org

Carsten Spie=DF wrote:
 > Hello Philippe,
 >=20
 >=20
 > > You will have to remove the printf() from the low prio task for the
 > > nucleus watchdog to detect the runaway situation, otherwise, your task
 > > would be considered as being under the control of the Linux scheduler
 > > until it issues a blocking Xenomai syscall (which it never does), and
 > > therefore escape the watchdog detection. That's the particular case I
 > > was talking about.
 > Meanwhile i got my sample code running:
 > When removing the printf it works fine.
 > So for me it looks like a problem when a task is switched to secondary
 > domain.
 > Is there a way to force a thread to switch back to primary domain?
 >=20
 > Now i unsuccesfully tried to get a posix skin variant running.
 > (my real app is based on pthread)
 > Since i only can use signals to suspend a posix thread (correct me if
 > i'm wrong) i run in the same problem with the secondary domain.
 >=20
 > Is there a way to switch back to primary domain in posix skin?

In 99% of the cases, you do not need to do this, Xenomai switches
threads to primary mode when they call a service which runs in primary
mode.

For the remaining cases, there is pthread_set_mode_np, see the API
documentation at:
http://www.xenomai.org/index.php/API_documentation

To suspend threads, you can use pthread_cond_wait, sem_wait,
pthread_mutex_lock or clock_nanosleep, depending on what you are trying
to achieve. Signals are no good if you want to remain in primary mode,
because they cause a switch to secondary mode.

 > Do i have a chance to do this with pthread or do i have to rewrite my
 > code using rt_task* calls?

--=20


					    Gilles Chanteperdrix.

