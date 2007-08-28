Message-ID: <3535aae80708280306l2adbc447vf522780a92d26c27@domain.hid>
Date: Tue, 28 Aug 2007 12:06:20 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46D301EE.5020805@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_53384_29338392.1188295580919"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
	<46BC8074.3090104@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
	<46D301EE.5020805@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_53384_29338392.1188295580919
Content-Type: multipart/alternative; 
	boundary="----=_Part_53385_7992878.1188295580919"

------=_Part_53385_7992878.1188295580919
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> That specific Xenomai bug should be fixed in 2.4, please check your
> testcase against -rc1 e.g. Unfortunately we have no backport of the fix
> in 2.3 yet. Can't tell right now if this is tricky, but this test
> demonstrates that $SOMETHING should be done...
>
> Jan


We have tried xenomai 2.4 rc1 (last changed revision 2865) with linux kernel
2.6.20.9 (ipipe 1.8-06) and linux kernel 2.6.22.1 (ipipe 1.9-01).
The orocos tests are also not working with this release:

    The following tests FAILED:
        2 - task-test (OTHER-FAULT)
        3 - event-test (OTHER-FAULT)
        4 - taskcontext-test (OTHER-FAULT)

And we get the the following messages: Killed after a single test. The
OROCOS messages are the same as with previous versions.
This time there is no extra information on the serial console after running
the orocos tests (accept "cleaning up sem" and "cleaning up mutex").

There is however a bug indication on the serial console after loading
xeno-native (see listing below, complete listing in appendix). Can this have
anything to do with the failure of the orocos tests?

I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
I-pipe: Domain IShield registered.
Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.
Xenomai: SMI-enabled chipset found, enabling SMI workaround.
Xenomai: SMI workaround failed!
Xenomai: starting native API services.
BUG: sleeping function called from invalid context at mm/slab.c:3024
in_atomic():0, irqs_disabled():1
 [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
 [<c01047fd>] show_trace+0x17/0x19
 [<c0104911>] dump_stack+0x1a/0x1c
 [<c0112a2a>] __might_sleep+0xc0/0xd0
 [<c0158edc>] kmem_cache_alloc+0xbc/0xdb
 [<c016d206>] d_alloc+0x23/0x190
 [<c01638ab>] do_lookup+0x117/0x168
 [<c01651aa>] __link_path_walk+0x7cb/0xcd7
 [<c01656ff>] link_path_walk+0x49/0xc4
 [<c0165797>] path_walk+0x1d/0x1f
 [<c0165945>] do_path_lookup+0x7d/0x1b3
 [<c016628a>] __user_walk_fd+0x37/0x4f
 [<c015fbb8>] vfs_lstat_fd+0x1d/0x43
 [<c015fc58>] vfs_lstat+0x16/0x18
 [<c015fc73>] sys_lstat64+0x19/0x2d
 [<c0102979>] sysenter_past_esp+0x6e/0x72
 =======================
WARNING: at kernel/softirq.c:138 local_bh_enable()
 [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
 [<c01047fd>] show_trace+0x17/0x19
 [<c0104911>] dump_stack+0x1a/0x1c
 [<c011b2a3>] local_bh_enable+0xa3/0xb2
 [<c023d6df>] lock_sock_nested+0xbe/0xc6
 [<c023ae21>] sock_fasync+0x46/0x14d
 [<c023c2ca>] sock_close+0x1e/0x42
 [<c015d5fd>] __fput+0x62/0x15c
 [<c015d759>] fput+0x1d/0x1f
 [<c015afb2>] filp_close+0x46/0x6c
 [<c015c0de>] sys_close+0x6f/0xb7
 [<c0102979>] sysenter_past_esp+0x6e/0x72
 =======================

greetings, andy

------=_Part_53385_7992878.1188295580919
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">That specific Xenomai bug should be fixed in 2.4, please check your<br>testcase against -rc1 
e.g. Unfortunately we have no backport of the fix<br>in 2.3 yet. Can&#39;t tell right now if this is tricky, but this test<br>demonstrates that $SOMETHING should be done...<br><br>Jan</blockquote><div><br>We have tried xenomai 
2.4 rc1 (last changed revision 2865) with linux kernel <a href="http://2.6.20.9">2.6.20.9</a> (ipipe 1.8-06) and linux kernel <a href="http://2.6.22.1">2.6.22.1</a> (ipipe 1.9-01). <br>The orocos tests are also not working with this release:
<br><br>&nbsp;&nbsp;&nbsp; The following tests FAILED:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 - task-test (OTHER-FAULT)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 - event-test (OTHER-FAULT)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 - taskcontext-test (OTHER-FAULT)<br><br>And we get the the following messages: Killed after a single test. The OROCOS messages are the same as with previous versions.
<br>This time there is no extra information on the serial console after running the orocos tests (accept &quot;cleaning up sem&quot; and &quot;cleaning up mutex&quot;).<br><br>There is however a bug indication on the serial console after loading xeno-native (see listing below, complete listing in appendix). Can this have anything to do with the failure of the orocos tests?
<br><br>I-pipe: Domain Xenomai registered.
<br>Xenomai: hal/x86 started.
<br>I-pipe: Domain IShield registered.
<br>Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.
<br>Xenomai: SMI-enabled chipset found, enabling SMI workaround.
<br>Xenomai: SMI workaround failed!
<br>Xenomai: starting native API services.
<br>BUG: sleeping function called from invalid context at mm/slab.c:3024
<br>in_atomic():0, irqs_disabled():1
<br>&nbsp;[&lt;c0103ab8&gt;] show_trace_log_lvl+0x1f/0x35
<br>&nbsp;[&lt;c01047fd&gt;] show_trace+0x17/0x19
<br>&nbsp;[&lt;c0104911&gt;] dump_stack+0x1a/0x1c
<br>&nbsp;[&lt;c0112a2a&gt;] __might_sleep+0xc0/0xd0
<br>&nbsp;[&lt;c0158edc&gt;] kmem_cache_alloc+0xbc/0xdb
<br>&nbsp;[&lt;c016d206&gt;] d_alloc+0x23/0x190
<br>&nbsp;[&lt;c01638ab&gt;] do_lookup+0x117/0x168
<br>&nbsp;[&lt;c01651aa&gt;] __link_path_walk+0x7cb/0xcd7
<br>&nbsp;[&lt;c01656ff&gt;] link_path_walk+0x49/0xc4
<br>&nbsp;[&lt;c0165797&gt;] path_walk+0x1d/0x1f
<br>&nbsp;[&lt;c0165945&gt;] do_path_lookup+0x7d/0x1b3
<br>&nbsp;[&lt;c016628a&gt;] __user_walk_fd+0x37/0x4f
<br>&nbsp;[&lt;c015fbb8&gt;] vfs_lstat_fd+0x1d/0x43
<br>&nbsp;[&lt;c015fc58&gt;] vfs_lstat+0x16/0x18
<br>&nbsp;[&lt;c015fc73&gt;] sys_lstat64+0x19/0x2d
<br>&nbsp;[&lt;c0102979&gt;] sysenter_past_esp+0x6e/0x72
<br>&nbsp;=======================
<br>WARNING: at kernel/softirq.c:138 local_bh_enable()
<br>&nbsp;[&lt;c0103ab8&gt;] show_trace_log_lvl+0x1f/0x35
<br>&nbsp;[&lt;c01047fd&gt;] show_trace+0x17/0x19
<br>&nbsp;[&lt;c0104911&gt;] dump_stack+0x1a/0x1c
<br>&nbsp;[&lt;c011b2a3&gt;] local_bh_enable+0xa3/0xb2
<br>&nbsp;[&lt;c023d6df&gt;] lock_sock_nested+0xbe/0xc6
<br>&nbsp;[&lt;c023ae21&gt;] sock_fasync+0x46/0x14d
<br>&nbsp;[&lt;c023c2ca&gt;] sock_close+0x1e/0x42
<br>&nbsp;[&lt;c015d5fd&gt;] __fput+0x62/0x15c
<br>&nbsp;[&lt;c015d759&gt;] fput+0x1d/0x1f
<br>&nbsp;[&lt;c015afb2&gt;] filp_close+0x46/0x6c
<br>&nbsp;[&lt;c015c0de&gt;] sys_close+0x6f/0xb7
<br>&nbsp;[&lt;c0102979&gt;] sysenter_past_esp+0x6e/0x72
<br>&nbsp;=======================<br>&nbsp;<br>greetings, andy<br></div><br></div><br>

------=_Part_53385_7992878.1188295580919--

------=_Part_53384_29338392.1188295580919
Content-Type: application/zip; name=linux-2.6.22.1-ipipe-1.9-01.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5w8hri6
Content-Disposition: attachment; filename="linux-2.6.22.1-ipipe-1.9-01.zip"

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
------=_Part_53384_29338392.1188295580919--

