Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2009 16:36:12 -0800
Message-ID: <6B8F1229FFBDCA47BA5C9712C46F18DFABCE46@domain.hid>
In-Reply-To: <49A323CE.3010302@domain.hid>
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>	<49A1DEBE.6020002@domain.hid><BAY135-W25DA8BBF5E569E370DB25DC6AE0@domain.hid>	<49A2D47D.90609@domain.hid><BAY135-W50A146D755045D42A23F66C6AE0@domain.hid>
	<49A323CE.3010302@domain.hid>
From: "Thomas Schaefer" <thomass@domain.hid>
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Cc: xenomai@xenomai.org

Hi,

unfortunately this doesn't work.
I tried a few other svn revisions.=20
4610 is the last one that works correctly and I can compile without an
error message.
The next revision that successfully compiles hangs.

Thomas


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
On Behalf Of Jan Kiszka
Sent: Monday, February 23, 2009 2:32 PM
To: Thomas Schaefer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)

Thomas Schaefer wrote:
> Hi,
>=20
> CONFIG_SCHED_SMT is not set.
> I manually overwrite CONFIG_X86_HT to n but every time I run make-kpkg
it will overwrite CONFIG_X86_HT to y.

Yeah, that was nonsense. And I do have a HT-capable test box with an
older 2x2 Xeon in fact. It never caused problems, at least not like
those you found (the box has sever and unfixable SMI issues, so I
stopped using it for Xenomai tests).

More ideas: What happens if your run latency like this?

	taskset -c 1 latency -c 1

Maybe there is some strange issue with sending IPIs on your box (which
is required to start things up in case creator and created task sit on
different CPUs). If that happens to make a difference, please try again
without taskset but with dumping /proc/xenomai/irq before and after the
start and post the result.

Jan


CONFIDENTIALITY NOTICE:  This electronic mail message and any attachment he=
reto may contain confidential information of Meyer Sound Laboratories, Inco=
rporated and is intended for the personal and confidential use of the desig=
nated recipient(s) only.  If you are not the intended recipient (or respons=
ible for delivering the message to the intended recipient), you have receiv=
ed this message in error and any review, distribution, or copying of this m=
essage or any attachment hereto is prohibited.  If you have received this m=
essage in error, please promptly notify the sender and permanently delete i=
t from your computer.

