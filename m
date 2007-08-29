Message-ID: <3535aae80708290436s1cda5728r5f8229ab64b9ec31@domain.hid>
Date: Wed, 29 Aug 2007 13:36:49 +0200
From: "andy motten" <andy.motten@domain.hid>
In-Reply-To: <46D407B7.1060805@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_826_27776304.1188387409823"
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
	<46C08E61.9060204@domain.hid>
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
	<46D301EE.5020805@domain.hid>
	<3535aae80708280306l2adbc447vf522780a92d26c27@domain.hid>
	<46D407B7.1060805@domain.hid>
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
Cc: Xenomai <xenomai@xenomai.org>

------=_Part_826_27776304.1188387409823
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > We have tried xenomai 2.4 rc1 (last changed revision 2865) with linux
> kernel
> > 2.6.20.9 (ipipe 1.8-06) and linux kernel 2.6.22.1 (ipipe 1.9-01).
> > The orocos tests are also not working with this release:
> >
> >     The following tests FAILED:
> >         2 - task-test (OTHER-FAULT)
> >         3 - event-test (OTHER-FAULT)
> >         4 - taskcontext-test (OTHER-FAULT)
> >
> > And we get the the following messages: Killed after a single test. The
> > OROCOS messages are the same as with previous versions.
> > This time there is no extra information on the serial console after
> running
> > the orocos tests (accept "cleaning up sem" and "cleaning up mutex").
>
> So your test apps are stopping due to some segfault or so? Over both
> kernels the same behaviour? Can you try to catch the problem with gdb
> (to see what causes the termination)? That may only make sense with the
> kernel bug below is not visible on a specific setup, though.

From: Klaas Gadeyne <klaas

The only information provided by the backtrace of gdb is:

        (gdb)
        Cannot fetch general-purpose registers for thread -1237948736:
generic error
        Cannot fetch general-purpose registers for thread -1237948736:
generic error

We are unsure about the goal of some of the xenomai function calls used in
the orocos os-layer. (
http://svn.mech.kuleuven.be/websvn/orocos/trunk/rtt/src/os/xenomai/fosi_internal.cpp
)
We will wait until the author comes back from holiday to check the code in
more detail.

>
> > There is however a bug indication on the serial console after loading
> > xeno-native (see listing below, complete listing in appendix). Can this
> have
> > anything to do with the failure of the orocos tests?
> >
> > I-pipe: Domain Xenomai registered.
> > Xenomai: hal/x86 started.
> > I-pipe: Domain IShield registered.
> > Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.
> > Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> > Xenomai: SMI workaround failed!
> > Xenomai: starting native API services.
> > BUG: sleeping function called from invalid context at mm/slab.c:3024
> > in_atomic():0, irqs_disabled():1
> >  [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
> >  [<c01047fd>] show_trace+0x17/0x19
> >  [<c0104911>] dump_stack+0x1a/0x1c
> >  [<c0112a2a>] __might_sleep+0xc0/0xd0
> >  [<c0158edc>] kmem_cache_alloc+0xbc/0xdb
> >  [<c016d206>] d_alloc+0x23/0x190
> >  [<c01638ab>] do_lookup+0x117/0x168
> >  [<c01651aa>] __link_path_walk+0x7cb/0xcd7
> >  [<c01656ff>] link_path_walk+0x49/0xc4
> >  [<c0165797>] path_walk+0x1d/0x1f
> >  [<c0165945>] do_path_lookup+0x7d/0x1b3
> >  [<c016628a>] __user_walk_fd+0x37/0x4f
> >  [<c015fbb8>] vfs_lstat_fd+0x1d/0x43
> >  [<c015fc58>] vfs_lstat+0x16/0x18
> >  [<c015fc73>] sys_lstat64+0x19/0x2d
> >  [<c0102979>] sysenter_past_esp+0x6e/0x72
> >  =======================
> > WARNING: at kernel/softirq.c:138 local_bh_enable()
> >  [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
> >  [<c01047fd>] show_trace+0x17/0x19
> >  [<c0104911>] dump_stack+0x1a/0x1c
> >  [<c011b2a3>] local_bh_enable+0xa3/0xb2
> >  [<c023d6df>] lock_sock_nested+0xbe/0xc6
> >  [<c023ae21>] sock_fasync+0x46/0x14d
> >  [<c023c2ca>] sock_close+0x1e/0x42
> >  [<c015d5fd>] __fput+0x62/0x15c
> >  [<c015d759>] fput+0x1d/0x1f
> >  [<c015afb2>] filp_close+0x46/0x6c
> >  [<c015c0de>] sys_close+0x6f/0xb7
> >  [<c0102979>] sysenter_past_esp+0x6e/0x72
> >  =======================
>
> There is a pending Linux-IRQ-state issue for at least 2.6.22. I came
> across it 2 weeks ago, but no one had the time to dig deeper so far (see
> also xenomai-core). However, I did not see this with 2.6.20. Is your
> observation kernel-version-independent? Maybe it's a race that I just
> miss with my 2.6.20 kernel (it was already tricky to reproduces with
> 2.6.22).
>

From: Klaas Gadeyne <klaas

This observation is kernel independent, it happens with linux kernel
2.6.20.9 (ipipe 1.8-06) and linux kernel 2.6.22.1 (ipipe 1.9-01).

greetings, andy

------=_Part_826_27776304.1188387409823
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; We have tried xenomai 2.4 rc1 (last changed revision 2865) with linux kernel<br>&gt; 
<a href="http://2.6.20.9">2.6.20.9</a> (ipipe 1.8-06) and linux kernel <a href="http://2.6.22.1">2.6.22.1</a> (ipipe 1.9-01).<br>&gt; The orocos tests are also not working with this release:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; The following tests FAILED:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 - task-test (OTHER-FAULT)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 - event-test (OTHER-FAULT)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 - taskcontext-test (OTHER-FAULT)<br>&gt;<br>&gt; And we get the the following messages: Killed after a single test. The
<br>&gt; OROCOS messages are the same as with previous versions.<br>&gt; This time there is no extra information on the serial console after running<br>&gt; the orocos tests (accept &quot;cleaning up sem&quot; and &quot;cleaning up mutex&quot;).
<br><br>So your test apps are stopping due to some segfault or so? Over both<br>kernels the same behaviour? Can you try to catch the problem with gdb<br>(to see what causes the termination)? That may only make sense with the
<br>kernel bug below is not visible on a specific setup, though.</blockquote><div>


	<title>From: Klaas Gadeyne &lt;klaas</title><meta name="GENERATOR" content="OpenOffice.org 2.2  (Linux)"><meta name="AUTHOR" content="Andy Motten"><meta name="CREATED" content="20070829;10080000"><meta name="CHANGEDBY" content="Andy Motten">
<meta name="CHANGED" content="20070829;13060000">
	
	
	
	
	
	
	<style type="text/css">
	&lt;!--
		@page { size: 8.5in 11in; margin: 0.79in }
		P { margin-bottom: 0.08in }
	--&gt;
	</style>

<p style="margin-bottom: 0in;">The only information provided by the
backtrace of gdb is:</p>





<p style="margin-bottom: 0in;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(gdb)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cannot
fetch general-purpose registers for thread -1237948736: generic error<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cannot
fetch general-purpose registers for thread -1237948736: generic error</p><p style="margin-bottom: 0in;">We are unsure about the goal of some of
the xenomai function calls used in the orocos os-layer.
(<a href="http://svn.mech.kuleuven.be/websvn/orocos/trunk/rtt/src/os/xenomai/fosi_internal.cpp">http://svn.mech.kuleuven.be/websvn/orocos/trunk/rtt/src/os/xenomai/fosi_internal.cpp</a>)</p>We will wait until the author comes
back from holiday to check the code in more detail.
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt; There is however a bug indication on the serial console after loading
<br>&gt; xeno-native (see listing below, complete listing in appendix). Can this have<br>&gt; anything to do with the failure of the orocos tests?<br>&gt;<br>&gt; I-pipe: Domain Xenomai registered.<br>&gt; Xenomai: hal/x86 started.
<br>&gt; I-pipe: Domain IShield registered.<br>&gt; Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.<br>&gt; Xenomai: SMI-enabled chipset found, enabling SMI workaround.<br>&gt; Xenomai: SMI workaround failed!<br>
&gt; Xenomai: starting native API services.<br>&gt; BUG: sleeping function called from invalid context at mm/slab.c:3024<br>&gt; in_atomic():0, irqs_disabled():1<br>&gt;&nbsp;&nbsp;[&lt;c0103ab8&gt;] show_trace_log_lvl+0x1f/0x35<br>
&gt;&nbsp;&nbsp;[&lt;c01047fd&gt;] show_trace+0x17/0x19<br>&gt;&nbsp;&nbsp;[&lt;c0104911&gt;] dump_stack+0x1a/0x1c<br>&gt;&nbsp;&nbsp;[&lt;c0112a2a&gt;] __might_sleep+0xc0/0xd0<br>&gt;&nbsp;&nbsp;[&lt;c0158edc&gt;] kmem_cache_alloc+0xbc/0xdb<br>&gt;&nbsp;&nbsp;[&lt;c016d206&gt;] d_alloc+0x23/0x190
<br>&gt;&nbsp;&nbsp;[&lt;c01638ab&gt;] do_lookup+0x117/0x168<br>&gt;&nbsp;&nbsp;[&lt;c01651aa&gt;] __link_path_walk+0x7cb/0xcd7<br>&gt;&nbsp;&nbsp;[&lt;c01656ff&gt;] link_path_walk+0x49/0xc4<br>&gt;&nbsp;&nbsp;[&lt;c0165797&gt;] path_walk+0x1d/0x1f<br>&gt;&nbsp;&nbsp;[&lt;c0165945&gt;] do_path_lookup+0x7d/0x1b3
<br>&gt;&nbsp;&nbsp;[&lt;c016628a&gt;] __user_walk_fd+0x37/0x4f<br>&gt;&nbsp;&nbsp;[&lt;c015fbb8&gt;] vfs_lstat_fd+0x1d/0x43<br>&gt;&nbsp;&nbsp;[&lt;c015fc58&gt;] vfs_lstat+0x16/0x18<br>&gt;&nbsp;&nbsp;[&lt;c015fc73&gt;] sys_lstat64+0x19/0x2d<br>&gt;&nbsp;&nbsp;[&lt;c0102979&gt;] sysenter_past_esp+0x6e/0x72
<br>&gt;&nbsp;&nbsp;=======================<br>&gt; WARNING: at kernel/softirq.c:138 local_bh_enable()<br>&gt;&nbsp;&nbsp;[&lt;c0103ab8&gt;] show_trace_log_lvl+0x1f/0x35<br>&gt;&nbsp;&nbsp;[&lt;c01047fd&gt;] show_trace+0x17/0x19<br>&gt;&nbsp;&nbsp;[&lt;c0104911&gt;] dump_stack+0x1a/0x1c
<br>&gt;&nbsp;&nbsp;[&lt;c011b2a3&gt;] local_bh_enable+0xa3/0xb2<br>&gt;&nbsp;&nbsp;[&lt;c023d6df&gt;] lock_sock_nested+0xbe/0xc6<br>&gt;&nbsp;&nbsp;[&lt;c023ae21&gt;] sock_fasync+0x46/0x14d<br>&gt;&nbsp;&nbsp;[&lt;c023c2ca&gt;] sock_close+0x1e/0x42<br>&gt;&nbsp;&nbsp;[&lt;c015d5fd&gt;] __fput+0x62/0x15c
<br>&gt;&nbsp;&nbsp;[&lt;c015d759&gt;] fput+0x1d/0x1f<br>&gt;&nbsp;&nbsp;[&lt;c015afb2&gt;] filp_close+0x46/0x6c<br>&gt;&nbsp;&nbsp;[&lt;c015c0de&gt;] sys_close+0x6f/0xb7<br>&gt;&nbsp;&nbsp;[&lt;c0102979&gt;] sysenter_past_esp+0x6e/0x72<br>&gt;&nbsp;&nbsp;=======================
<br><br>There is a pending Linux-IRQ-state issue for at least 2.6.22. I came<br>across it 2 weeks ago, but no one had the time to dig deeper so far (see<br>also xenomai-core). However, I did not see this with 2.6.20. Is your
<br>observation kernel-version-independent? Maybe it&#39;s a race that I just<br>miss with my 2.6.20 kernel (it was already tricky to reproduces with<br>2.6.22).<br></blockquote></div><br>


	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title>From: Klaas Gadeyne &lt;klaas</title><meta name="GENERATOR" content="OpenOffice.org 2.2  (Linux)"><meta name="AUTHOR" content="Andy Motten"><meta name="CREATED" content="20070829;10080000">
<meta name="CHANGEDBY" content="Andy Motten"><meta name="CHANGED" content="20070829;13060000">
	
	
	
	
	
	
	<style type="text/css">
	&lt;!--
		@page { size: 8.5in 11in; margin: 0.79in }
		P { margin-bottom: 0.08in }
	--&gt;
	</style>

<p style="margin-bottom: 0in;">This observation is kernel independent,
it happens with linux kernel <a href="http://2.6.20.9">2.6.20.9</a> (ipipe 1.8-06) and linux kernel
<a href="http://2.6.22.1">2.6.22.1</a> (ipipe 1.9-01).</p>
<br>greetings, andy<br>

------=_Part_826_27776304.1188387409823--

