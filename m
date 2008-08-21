Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Aug 2008 13:08:13 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E56432274@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
	<48AC6BA0.9010306@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Philippe,

I updated via svn ... and transferring data to the Xenomai domain with a
pipe now works perfect. I see that also the documentation has been
updated. Thanks a lot, very nice work.

I still have 1 thing on my wish-list of the pipe: is it possible to add
1 argument Cookie (void* or long) to the rt_pipe_monitor function so
that when a generic monitor-function is used, it would be possible to
find it's instance data (that Cookie should then be passed to the
call-back function).
Now I have to work around this as follows:

static rt_vcom_context_t* MonitorCookie[2];
MonitorCookie[0] =3D &Instance_data_0; rt_pipe_monitor(Pipe0,
MonitorFcts[0]);
MonitorCookie[1] =3D &Instance_data_1; rt_pipe_monitor(Pipe1,
MonitorFcts[1]);

static int cbMonitor0(RT_PIPE* hPipe, int Event, long Arg) {return
cbMonitor(hPipe, Event, Arg, MonitorCookie[0]);}
static int cbMonitor1(RT_PIPE* hPipe, int Event, long Arg) {return
cbMonitor(hPipe, Event, Arg, MonitorCookie[1]);}
typedef int (*monitor_f)(RT_PIPE *pipe, int event, long arg);
static monitor_f MonitorFcts[SERIAL_NR_DEVS] =3D
{
   cbMonitor0
  ,cbMonitor1
};

static int cbMonitor(RT_PIPE* hPipe, int Event, long Arg, void* Cookie)
{ /* my generic Monitor implemnetation for all instances */
  rt_vcom_context_t* Mycontext =3D (rt_vcom_context_t*)Cookie;
  /* .... */
}

However, with an improved version of the Xenomai interface, I would not
need the MonitorFcts array, just:
rt_pipe_monitor(Pipe0, cbMonitor, &Instance_data_0);
rt_pipe_monitor(Pipe1, cbMonitor, &Instance_data_1);

Please comment.


Question concerning P_EVENT_NOBUF.  Now I am using the user-space
endpoint in blocking mode and it works fine with the latest version of
Xenomai when the memory is exhausted.  So far, so good.  But what would
happen if I open the endpoint in non-blocking mode? Would it still be
the implementation of the handler (returning 0) of P_EVENT_NOBUF that
would have the power to block the writer or will the writer then see the
ENOMEM (so indeed non-blocking in all cases)?  Please comment.


Best regards,
Filip.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 20 August 2008 21:08
To: Filip Van Rillaer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM

Filip Van Rillaer wrote:
> Hello,
>=20
> Thank you for your work-around.
> Though I have some problems with the implementation:
> pipe_i_handler (Xenomai side) does not know when the xnpipe_write got=20
> errno=3DENOMEM (the pipe_i_handler is I think even not called in case=20
> ENOMEM is returned).  So there is I think with the current Xenomai=20
> implementation no way for the pipe_i_handler to correctly fill in the=20
> value of buffer_filled_up_p.  This would mean that my writer-thread=20
> 'userland' would have to set this 'variable'.
> Then I was thinking about moving the <<rt_sem_p(&bsync, TM_INFINITE)>>

> to the writer-thread when errno-ENOMEM is returned, but that would=20
> require that the writer-thread has to bind the semaphore that was=20
> created in another program.  This is probably possible via the Xenomai

> registry.
>=20

Commit #4114 provides P_EVENT_NOBUF (formerly P_EVENT_FULL).

--
Philippe.

