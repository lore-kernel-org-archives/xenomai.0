Message-ID: <445C34C100012AEC@n016.sc0.cp.net> (added by
	postmaster@domain.hid)
From: "Prashanti Bedapudi" <pbedapudi@domain.hid>
Date: Sat, 6 May 2006 21:30:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
Subject: [Xenomai-help] help with using alarams
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

Hi,
I am new to xenomai and linux. I am having some problems with alarms. =
Here
is a sample piece of code that I am using.
If you look at the main function, I have a while(!quit_now)=A0 and I am
setting this flag in the alarm_handler. I am seeing some weird results. =
When
I have a printf statement in the while(!quit_now) loop as I have below, =
it
works as expected and the program terminates when the quit_flag is set. =
But
if I remove the printf() the program never terminates, it just hangs, =
even
if the quit_now flag is set.=20
Any insight into this problem will be greatly appreciated.

I posted this message 2 days ago..but I got a reply with message saying
'HTML attachment has been scrubbed'. Not sure what that meant, so I am
posting it again..


alarm_handler()
{
=A0=A0=A0=A0=A0=A0=A0 for(;;)
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 rt_alarm_wait();
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 do_processing();
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 if(condition met)
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 quit_now =3D TRUE;=A0 /* =
global variable */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 }
}

main()
{
=A0=A0=A0=A0=A0=A0=A0 rt_alarm_create;
=A0=A0=A0=A0=A0=A0=A0 rt_task_spawn();
=A0=A0=A0=A0=A0=A0=A0 rt_alarm_start();

=A0=A0=A0=A0=A0=A0=A0 while(!quit_now)
=A0=A0=A0=A0=A0=A0=A0 =A0 printf("Inside while\n");
}




thanks in advance,
Shanti



