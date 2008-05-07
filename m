Message-ID: <482170A6.60806@domain.hid>
Date: Wed, 07 May 2008 11:04:38 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <482060A7.70809@domain.hid>
	<2ff1a98a0805060650he46466u88dc82fc1567173c@domain.hid>
In-Reply-To: <2ff1a98a0805060650he46466u88dc82fc1567173c@domain.hid>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_pipe_delete buggy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
<br>
<br>
Gilles Chanteperdrix a =C3=A9crit=C2=A0:
<blockquote
 cite=3D"mid:2ff1a98a0805060650he46466u88dc82fc1567173c@domain.hid"
 type=3D"cite">
  <pre wrap=3D"">On Tue, May 6, 2008 at 3:44 PM, St=C3=A9phane ANCELOT <a=
 class=3D"moz-txt-link-rfc2396E" href=3D"mailto:sancelot@domain.hid">&lt;san=
celot@domain.hid&gt;</a> wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Hi,
 rt_pipe_delete in user space context was working fine in my app in xeno
 2.1.2 using the same call in xeno 2.4.2 crashes the application.
 Any idea ?
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Please only report a bug if it happens with the latest stable release.

  </pre>
</blockquote>
I was a little bit succinct about problem description, here is a
complete description regarding v2.4.2 :<br>
<br>
using the following regression test program :<br>
<br>
#include &lt;native/pipe.h&gt;<br>
<br>
RT_PIPE pipe_defaut;<br>
int main()<br>
{<br>
int ret;<br>
=C2=A0 mlockall(MCL_CURRENT | MCL_FUTURE);<br>
=C2=A0<br>
if ((ret=3Drt_pipe_create(&amp;pipe_defaut,"fifo_defaut",5,100)) !=3D0)<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("unable to create pipe\=
n[%s]\n",strerror(-ret));<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
rt_pipe_delete(&amp;pipe_defaut);<br>
<br>
}<br>
<br>
<br>
and the resulting fault at rt_pipe_delete :<br>
<br>
BUG: Unhandled exception over domain Xenomai at 0xc013dede - switching
to ROOT<br>
Pid: 2440, comm: a.out Tainted: GF=C2=A0=C2=A0=C2=A0=C2=A0 D 2.6.24.3-ipi=
pe #1<br>
=C2=A0[&lt;c010e923&gt;] __ipipe_handle_exception+0x1b3/0x1c0<br>
=C2=A0[&lt;c013dede&gt;] __ipipe_restore_root+0x1e/0x30<br>
=C2=A0[&lt;c0113c03&gt;] try_to_wake_up+0xb3/0xc0<br>
=C2=A0[&lt;c036af0b&gt;] error_code+0x6f/0x7c<br>
=C2=A0[&lt;c0120000&gt;] do_timer+0x30/0xf0<br>
=C2=A0[&lt;c013dede&gt;] __ipipe_restore_root+0x1e/0x30<br>
=C2=A0[&lt;c01400f4&gt;] xnheap_destroy+0x54/0xe0<br>
=C2=A0[&lt;c0155cc0&gt;] __pipe_flush_pool+0x0/0x20<br>
=C2=A0[&lt;c015542b&gt;] rt_pipe_delete+0x10b/0x140<br>
=C2=A0[&lt;c015250e&gt;] __rt_pipe_delete+0x4e/0x70<br>
=C2=A0[&lt;c014a769&gt;] hisyscall_event+0x179/0x280<br>
=C2=A0[&lt;c01495e7&gt;] schedule_event+0x287/0x360<br>
=C2=A0[&lt;c014a5f0&gt;] hisyscall_event+0x0/0x280<br>
=C2=A0[&lt;c013e63f&gt;] __ipipe_dispatch_event+0xbf/0x1d0<br>
=C2=A0[&lt;c010e6c0&gt;] __ipipe_syscall_root+0x40/0xf0<br>
=C2=A0[&lt;c0102ad9&gt;] sysenter_past_esp+0x46/0x72<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
------------[ cut here ]------------<br>
kernel BUG at kernel/ipipe/core.c:321!<br>
invalid opcode: 0000 [#3] PREEMPT<br>
Modules linked in: i915 ibspci(F) rtcan_sja1000(F) usb_storage e100 mii<b=
r>
<br>
Pid: 2440, comm: a.out Tainted: GF=C2=A0=C2=A0=C2=A0=C2=A0 D (2.6.24.3-ip=
ipe #1)<br>
EIP: 0060:[&lt;c013dede&gt;] EFLAGS: 00010206 CPU: 0<br>
EIP is at __ipipe_restore_root+0x1e/0x30<br>
EAX: 00000000 EBX: cded8000 ECX: cdc006c0 EDX: c11bdb00<br>
ESI: cdd2904c EDI: 00000000 EBP: cdd29028 ESP: cb4b3f04<br>
=C2=A0DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068<br>
Process a.out (pid: 2440, ti=3Dcb4b2000 task=3Dcdc19030
task.ti=3Dcb4b2000)&lt;0&gt;<br>
I-pipe domain Linux<br>
Stack: c01400f4 00000000 00000000 c0155cc0 00000000 cdd29010 cdd29028
00000000<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c015542b fffffffd cdd29010 cdc19030 =
c015250e 0000007d cb4b3fb8
00000000<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c014a769 0029014e c01495e7 00000004 =
00000000 00000001 000002a8
00000000<br>
Call Trace:<br>
=C2=A0[&lt;c01400f4&gt;] xnheap_destroy+0x54/0xe0<br>
=C2=A0[&lt;c0155cc0&gt;] __pipe_flush_pool+0x0/0x20<br>
=C2=A0[&lt;c015542b&gt;] rt_pipe_delete+0x10b/0x140<br>
=C2=A0[&lt;c015250e&gt;] __rt_pipe_delete+0x4e/0x70<br>
=C2=A0[&lt;c014a769&gt;] hisyscall_event+0x179/0x280<br>
=C2=A0[&lt;c01495e7&gt;] schedule_event+0x287/0x360<br>
=C2=A0[&lt;c014a5f0&gt;] hisyscall_event+0x0/0x280<br>
=C2=A0[&lt;c013e63f&gt;] __ipipe_dispatch_event+0xbf/0x1d0<br>
=C2=A0[&lt;c010e6c0&gt;] __ipipe_syscall_root+0x40/0xf0<br>
=C2=A0[&lt;c0102ad9&gt;] sysenter_past_esp+0x46/0x72<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 81 3d a0 84 41 c0 00 47 47
c0 75 12 85 c0 74 09 0f ba 2d 40 71 41 c0 00 c3 e9 a2 ff ff ff
&lt;0f&gt; 0b eb fe 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 89 c1 8b<br=
>
EIP: [&lt;c013dede&gt;] __ipipe_restore_root+0x1e/0x30 SS:ESP
0068:cb4b3f04<br>
---[ end trace 3cbecf3ccba7b6fa ]---<br>
sh-3.2$=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
</body>
</html>

