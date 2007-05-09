Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 9 May 2007 13:49:38 +0100
Message-ID: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
In-Reply-To: <mailman.51.1178704831.10156.xenomai@xenomai.org>
From: "Noren, Andrew" <Andrew.Noren@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
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


Hi Gilles,

I too have encountered this issue with the POSIX skin.
I think it may have to do with the order in which the posix skin hooks
are run on thread deletion.

In ksrc/skins/posix/syscall.c
xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);

and ksrc/skins/posix/thread.c
xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);

The thread_delete_hook seems to run first causing the thread data to be
destroyed before __shadow_delete_hook has a chance to run.

This results in __shadow_delete_hook failing in various cases.

An example of an error case linked with this would be the failure to
remove the thread key from the hash bucket after application exit.  The
next run of an application can then result in pthread_setschedparam
failing to create a shadow since it likely finds an id in the hash
bucket already.

Regards,
Andy

=20

