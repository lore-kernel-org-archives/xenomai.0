Message-ID: <fd6a47a90601171559x13acf2c2m@domain.hid>
Date: Wed, 18 Jan 2006 00:59:14 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23599_7744733.1137542354390"
Subject: [Xenomai-core] Scheduling while atomic
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_23599_7744733.1137542354390
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gilles,


I cannot reproduce those messages after turning nucleus debugging on.
Instead, I now either get relatively more failing mutexes or even hard
lockups with the test program I sent to you. If the computer didn't crash,
dmesg contains 3 Xenomai messages relating to a task being movend to
secondary domain after exception #14. As when the computer crashes: I have
written the last kernel panic message on a paper. Please tell if you want
also the addresses or (part of) the call stack.

I'm still wondering if there's a programming error in the mutex test
program. After I sent my previous message, and before I turned nucleus
debugging on, I managed (by reducing the sleeptimes to max. 5.0e4) to
fatally crash the computer, while spewing out countless 'scheduling while
atomic messages'. Is the mutex error reproducible ?

Tomorrow I'll try the patch.

lostage_handler + e/33a
rthal_apc_handler + 3b/46
lostage_handler + 190/33a
rthal_apc_handler + 3b/46
__ipipe_sync_stage + 2a1/2bc
mark_offset_tsc + c1/456
__ipipe_sync_stage + 2a9/2bc
ipipe_unstall_pipeline_from + 189/194 (might be 181/194)
xnpod_delete_thread + ba1/bc3
mcount + 23/2a
taskexit_event + 4f/6c
__ipipe_dispatch_event + 90/173
do_exit + 10f/604
sys_exit + 8/14
syscall_call + 7/b
next_thread + 0/15
syscall_call + 7/b

<0> Kernel panic - not syncing: Fatal Exception in interrupt


Thanks for investigating,

Jeroen.

------=_Part_23599_7744733.1137542354390
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Gilles,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>I cannot reproduce those messages after turning nucleus debugging on. =
Instead, I now either get relatively more failing mutexes or&nbsp;even hard=
 lockups with the test program I sent to you. If the&nbsp;computer didn't c=
rash, dmesg contains 3 Xenomai messages relating to a task being movend to =
secondary domain after exception #14. As&nbsp;when the&nbsp;computer crashe=
s: I have written the last kernel panic message on a paper. Please tell if =
you want also the addresses or (part of) the call stack.
</div>
<div>&nbsp;</div>
<div>I'm still wondering if there's a programming error in the mutex test p=
rogram. After I sent my previous message, and before I turned nucleus debug=
ging on, I managed (by reducing the sleeptimes to max. 5.0e4) to fatally cr=
ash the computer,&nbsp;while spewing out countless 'scheduling while atomic=
 messages'.&nbsp;Is the mutex error reproducible ?
</div>
<div>&nbsp;</div>
<div>Tomorrow I'll try the patch.</div>
<div>&nbsp;</div>
<div>lostage_handler + e/33a</div>
<div>rthal_apc_handler + 3b/46</div>
<div>lostage_handler + 190/33a</div>
<div>rthal_apc_handler + 3b/46</div>
<div>__ipipe_sync_stage + 2a1/2bc</div>
<div>mark_offset_tsc + c1/456</div>
<div>__ipipe_sync_stage + 2a9/2bc</div>
<div>ipipe_unstall_pipeline_from + 189/194 (might be 181/194)</div>
<div>xnpod_delete_thread + ba1/bc3</div>
<div>mcount + 23/2a</div>
<div>taskexit_event + 4f/6c</div>
<div>__ipipe_dispatch_event + 90/173</div>
<div>do_exit + 10f/604</div>
<div>sys_exit + 8/14</div>
<div>syscall_call + 7/b</div>
<div>next_thread + 0/15</div>
<div>syscall_call + 7/b</div>
<div>&nbsp;</div>
<div>&lt;0&gt; Kernel panic - not syncing: Fatal Exception in interrupt</di=
v>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks for investigating,</div>
<div>&nbsp;</div>
<div>Jeroen.</div>

------=_Part_23599_7744733.1137542354390--

