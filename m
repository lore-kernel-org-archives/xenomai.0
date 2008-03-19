Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2008 09:27:19 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F330@domain.hid>
In-Reply-To: <47D2CAC4.6000204@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F317@domain.hid>
	<47D2CAC4.6000204@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: Re: [Xenomai-core] Error when exiting pSOS-task with return
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Hello Philippe,

sorry for the delay, I was on holiday a few days.

> PS: you may want to check whether forcing the task to secondary mode =
before calling t_delete(0) does not cause the issue to trigger again.

When forcing the task to secondary mode before returning from main =
function, the issue is triggered.
When forcing the task to primary mode before returning from main =
function, there is no error.
When using t_delete(0) there is no error, regardless of primary or =
secondary mode.


Markus



-----Original Message-----
From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of =
Philippe Gerum
Sent: Samstag, 8. M=E4rz 2008 18:20
To: Markus Osterried
Cc: Xenomai-core@domain.hid
Subject: Re: [Xenomai-core] Error when exiting pSOS-task with return

Markus Osterried wrote:
> Hello,
> =20
> with Xenomai 2.4 on Linux 2.6.18 on PowerPC I have seen the following =
trace:
> =20
> Feb 26 19:37:25 (none) user.err kernel: BUG: sleeping function called=20
> from invalid context at kernel/rwsem.c:20 Feb 26 19:37:25 (none)=20
> user.warn kernel: in_atomic():0, irqs_disabled():1 Feb 26 19:37:25=20
> (none) user.warn kernel: Call Trace:
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFE50] [C000C114]
> show_stack+0x58/0x188 (unreliable)
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFEA0] [C00128B0]=20
> __might_sleep+0xdc/0xf0 Feb 26 19:37:25 (none) user.warn kernel:=20
> [C19BFEC0] [C0032304]
> down_read+0x24/0x58
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFED0] [C00192C8]=20
> exit_mm+0x34/0xec Feb 26 19:37:25 (none) user.warn kernel: [C19BFEF0]=20
> [C001B000] do_exit+0x21c/0x98c Feb 26 19:37:25 (none) user.warn=20
> kernel: [C19BFF30] [C001B810]
> complete_and_exit+0x0/0x28
> Feb 26 19:37:25 (none) user.warn kernel: [C19BFF40] [C00041A0]
> ret_from_syscall+0x0/0x38
> =20
> =20
> This happens (sometimes) when a pSOS-task exits by returning from its=20
> main function.
> I have changed the return statement into t_delete(0) and there was no=20
> error anymore, so this isn't a major issue.
> =20
> But anyway I would like to know whether this is a xenomai bug or it=20
> isn't allowed to exit a pSOS-task by returning from main function.
> I have seen at end of psos_task_trampoline that there is a
> pthread_exit() instead of a t_delete().
>

It is allowed to exit the task body directly. Another possibility is a =
bug in old Adeos/ppc patch for 2.6.18, that would trigger when the =
nucleus has to relax the exiting thread. Anyway, this issue is queued =
for investigation here. Thanks.

PS: you may want to check whether forcing the task to secondary mode =
before calling t_delete(0) does not cause the issue to trigger again.

> Thanks
> Markus
> =20
>=20
>=20
> ----------------------------------------------------------------------
> --
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--
Philippe.

