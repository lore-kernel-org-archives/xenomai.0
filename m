MIME-Version: 1.0
In-Reply-To: <5169C63B.1070406@xenomai.org>
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
	<5169C63B.1070406@xenomai.org>
Date: Sun, 14 Apr 2013 00:41:50 +0200
Message-ID: <CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

linux kernel : 3.2.21
xenomai version : 2.6.2.1
arch: x86

In fact, I base on the cookie of the "rt_task_add_hook" function to
retrieve the descriptor address of the task which has been switched or
started.
And I guess that if the returned name is ROOT it's means that either the
task is switched to secondary mode or it's another linux task and if the
retuned name isn't ROOT it mean that it's a task in the xenomai scheduler.

Also, I deduce the time during which the task "t" has the context by
subtracting  the context switch date of the the task "t+1" by that of the
task "t".
This gives me the following:

*(D) =3D beginning of the context
*
*(F) =3D end of the context*

*case 1:*

(D) ROOT/0 : 0.14545 ms : CPU0
(F) ROOT/0 : 3.37748 ms (duree -> 3.23203)
(D) hook : 3.37755 ms : CPU0
(F) hook : 3.38848 ms (duree -> 0.010934)
(D) ROOT/0 : 3.38854 ms : CPU0
(F) ROOT/0 : 208.973 ms (duree -> 205.584)
(D) ROOT/0 : 208.973 ms : CPU0
(F) ROOT/0 : 209.027 ms (duree -> 0.054216)
(D) ROOT/0 : 209.027 ms : CPU0
(F) ROOT/0 : 1209.03 ms (duree -> 1000)
(D) hook : 1209.03 ms : CPU0
(F) hook : 1209.03 ms (duree -> 0.002698)
(D) ROOT/0 : 1209.03 ms : CPU0
(F) ROOT/0 : 1209.03 ms (duree -> 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 6858.131530] TRD: 144195ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6858.134758] TRD: 3374717ns - NOM "hook" - CPU 0 - RT:0
[ 6858.134769] TRD: 3387877ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6858.340104] TRD: 208971154ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6858.340157] TRD: 209026676ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6859.338949] TRD: 1209025602ns - NOM "hook" - CPU 0 - RT:1
[ 6859.338951] TRD: 1209030466ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6859.339363] TRD: 1209445419ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 6859.339370] TRD: 1209453240ns - NOM "ROOT/0" - CPU 0 - RT:1

*case 2:*

(D) ROOT/0 : 0.141063 ms : CPU0
(F) ROOT/0 : 3.33535 ms (duree -> 3.19428)
(D) hook : 3.33563 ms : CPU0
(F) hook : 3.34731 ms (duree -> 0.011681)
(D) ROOT/0 : 3.34737 ms : CPU0
(F) ROOT/0 : 3.3764 ms (duree -> 0.029035)
(D) ROOT/0 : 3.37646 ms : CPU0
(F) ROOT/0 : 3.37775 ms (duree -> 0.001293)
(D) hook : 3.37779 ms : CPU0
(F) hook : 208.936 ms (duree -> 205.558)
(D) ROOT/0 : 208.936 ms : CPU0
(F) ROOT/0 : 208.997 ms (duree -> 0.06107)
(D) ROOT/0 : 208.997 ms : CPU0
(F) ROOT/0 : 1209 ms (duree -> 1000)
(D) hook : 1209 ms : CPU0
(F) hook : 1209 ms (duree -> 0.003158)
(D) ROOT/0 : 1209 ms : CPU0
(F) ROOT/0 : 1209 ms (duree -> 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[ 7324.095401] TRD: 139711ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7324.098591] TRD: 3333666ns - NOM "hook" - CPU 0 - RT:0
[ 7324.098603] TRD: 3346697ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7324.303943] TRD: 3375854ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7324.303944] TRD: 3377371ns - NOM "hook" - CPU 0 - RT:1
[ 7324.303945] TRD: 208934837ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7324.304002] TRD: 208996555ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7325.302795] TRD: 1208995468ns - NOM "hook" - CPU 0 - RT:1
[ 7325.302797] TRD: 1209000358ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7325.303218] TRD: 1209425068ns - NOM "ROOT/0" - CPU 0 - RT:1
[ 7325.303225] TRD: 1209433203ns - NOM "ROOT/0" - CPU 0 - RT:1

By comparing the two results, I guess when the CPU is loaded, the task is
in secondary mode for the sequence 1 and in primary mode for the sequence 2.


Maybe now it is really clearer...



2013/4/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 04/13/2013 08:20 PM, alex alex wrote:
>
> > I hope this is more clear like this.
>
>
> We definitely do not have information. As usual, we do not know what
> version of Xenomai you are using, on what platform, how your kernel is
> configured.
>
> /*
>  * When case 1 is activated we see (with the dmesg command) :
>  *
> [  796.318290] HOOK: 107212ns - NAME "ROOT/0"
> [  796.321501] HOOK: 3322158ns - NAME "hook"        <- task creation
> (primary mode)
> [  796.321512] HOOK: 3335024ns - NAME "ROOT/0"      <- immediate switch
> in secondary mode and do cpu load (why this switch?)
>
> 1- a switch from "hook" to "ROOT" thread does not necessarily mean a
> switch to secondary mode. It also happens if "hook" suspends, of if ROOT
> preempts hook.
> 2- a switch to "hook" does not necessarily mean that the task startup is
> done, if you have a look at the thread startup code, you will see that
> has several steps, switching back and forth between the creator task and
> the created task.
> 3- if it is indeed a switch to secondary mode, you can have a look at
> examples/sigdebug.c to see how to find the reason for a secondary mode
> switch.
>
>
> [  796.526870] HOOK: 208957565ns - NAME "ROOT/0"
> [  796.526927] HOOK: 209017235ns - NAME "ROOT/0"
> [  797.525640] HOOK: 1209016502ns - NAME "hook"     <- the task is deleted
> [  797.525642] HOOK: 1209020993ns - NAME "ROOT/0"
>  *
>  * case 2 : with the sleep function
>  *
>  1093.722850] HOOK: 109993ns - NAME "ROOT/0"
> [ 1093.726044] HOOK: 3307528ns - NAME "hook"        <- task creation
> (primary mode)
> [ 1093.726056] HOOK: 3321275ns - NAME "ROOT/0"
> [ 1093.931404] HOOK: 3350018ns - NAME "ROOT/0"
> [ 1093.931405] HOOK: 3351297ns - NAME "hook"        <- after the sleep.
> The sleep seems to force the task to remain in primary mode during the
> cpu load.
>
> I do not think nanosleep(0) suspends the calling task.
>
>
> [ 1093.931406] HOOK: 208932507ns - NAME "ROOT/0"
> [ 1093.931469] HOOK: 209001818ns - NAME "ROOT/0"
> [ 1094.930182] HOOK: 1209000982ns - NAME "hook"     <- the task is deleted
> [ 1094.930184] HOOK: 1209005156ns - NAME "ROOT/0"
>  *
>  * case 3 : with the pthread_set_mode_np
>  *
> [ 1455.427711] HOOK: 123409ns - NAME "ROOT/0"
> [ 1455.430896] HOOK: 3311532ns - NAME "hook"      <- task creation
> (primary mode)
> [ 1455.430908] HOOK: 3325521ns - NAME "ROOT/0"    <- immediate switch in
> secondary mode and do cpu load while pthread_set_mode_np
> should force the task to remain in primary mode?
>
> Again, how do you see this a switch to secondary mode? The three
> sequences look the same to me, I do not see how do you get all these
> interpretations.
>
> [ 1455.636262] HOOK: 208942671ns - NAME "ROOT/0"
> [ 1455.636331] HOOK: 209015748ns - NAME "ROOT/0"
> [ 1456.635043] HOOK: 1209014877ns - NAME "hook"   <- the task is deleted
> [ 1456.635045] HOOK: 1209019259ns - NAME "ROOT/0"
>
>
>
> --
>                                                                 Gilles.
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 147506 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130414/a590eb3=
7/attachment.obj>
