Date: Wed, 31 Oct 2007 18:20:42 +0100
From: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
Message-ID: <1963009588.20071031182042@domain.hid>
In-Reply-To: <47270861.8090500@domain.hid>
References: <1078761341.20071030094041@domain.hid>
	<4726F2B5.5000307@domain.hid>
	<1935435350.20071030105318@domain.hid>
	<47270861.8090500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] how to stop a runaway task
Reply-To: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hello Philippe,


> You will have to remove the printf() from the low prio task for the
> nucleus watchdog to detect the runaway situation, otherwise, your task
> would be considered as being under the control of the Linux scheduler
> until it issues a blocking Xenomai syscall (which it never does), and
> therefore escape the watchdog detection. That's the particular case I
> was talking about.
Meanwhile i got my sample code running:
When removing the printf it works fine.
So for me it looks like a problem when a task is switched to secondary
domain.
Is there a way to force a thread to switch back to primary domain?

Now i unsuccesfully tried to get a posix skin variant running.
(my real app is based on pthread)
Since i only can use signals to suspend a posix thread (correct me if
i'm wrong) i run in the same problem with the secondary domain.

Is there a way to switch back to primary domain in posix skin?

Do i have a chance to do this with pthread or do i have to rewrite my
code using rt_task* calls?

Thanks for your help, regards

Carsten
--=20
Dipl.-Ing. Carsten Spie=DF
Softwareentwicklung - Beratung - Schulung
Lauterlech 39d
D-86152 Augsburg
Tel.: +49(821)15 999 765
Fax.: +49(821)15 999 767
mailto://mail@domain.hid
http://www.carsten-spiess.de





