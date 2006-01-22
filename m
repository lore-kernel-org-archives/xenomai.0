Message-ID: <fd6a47a90601220819n3f4cd382t@domain.hid>
Date: Sun, 22 Jan 2006 17:19:35 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <b647ffbd0601220010x3cc023an@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_19371_23229298.1137946775362"
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_19371_23229298.1137946775362
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,


I'm currently not at a level to participate in your discussion. Although I'=
m
willing to supply you with stresstests, I would nevertheless like to learn
more from task migration as this debugging session proceeds. In order to do
so, please confirm the following statements or indicate where I went wrong.
I hope others may learn from this as well.

xn_shadow_harden(): This is called whenever a Xenomai thread performs a
Linux (root domain) system call (notified by Adeos ?). The migrating thread
(nRT) is marked INTERRUPTIBLE and run by the Linux kernel
wake_up_interruptible_sync() call. Is this thread actually run or does it
merely put the thread in some Linux to-do list (I assumed the first case) ?
And how does it terminate: is only the system call migrated or is the threa=
d
allowed to continue run (at a priority level equal to the Xenomai
priority level) until it hits something of the Xenomai API (or trivially:
explicitly go to RT using the API) ? In that case, I expect the nRT thread
to terminate with a schedule() call in the Xeno OS API code which
deactivates the task so that it won't ever run in Linux context anymore. A
top priority gatekeeper is in place as a software hook to catch Linux's
attention right after that schedule(), which might otherwise schedule
something else (and leave only interrupts for Xenomai to come back to life
again). I have the impression that I cannot see this gatekeeper, nor the
(n)RT threads using the ps command ?

Is it correct to state that the current preemption issue is due to the
gatekeeper being invoked too soon ? Could someone knowing more about the
migration technology explain what exactly goes wrong ?

Thanks,


Jeroen.

------=_Part_19371_23229298.1137946775362
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>I'm currently not at a level to participate in your discussion. Althou=
gh I'm willing to supply you with stresstests, I would nevertheless like to=
 learn more from task migration&nbsp;as this debugging session proceeds. In=
 order to do so, please confirm the following statements or indicate where =
I went wrong. I hope others may learn from this as well.
</div>
<div>&nbsp;</div>
<div>xn_shadow_harden(): This is called whenever a Xenomai thread performs =
a Linux (root domain) system call (notified by Adeos ?). The migrating thre=
ad (nRT) is marked INTERRUPTIBLE and run by the Linux kernel wake_up_interr=
uptible_sync() call. Is this thread actually run or does it merely put the =
thread in some Linux to-do list&nbsp;(I assumed the first case) ? And how d=
oes it terminate: is only the system call migrated or is the thread allowed=
 to continue run (at a priority level equal to the Xenomai priority&nbsp;le=
vel) until it hits something of the Xenomai API (or trivially: explicitly g=
o to RT using the API) ? In that case, I&nbsp;expect the nRT thread to term=
inate with a schedule() call in the Xeno OS API code which deactivates the =
task so that it won't ever run in Linux context anymore. A top priority gat=
ekeeper is in place as a software hook to catch Linux's attention&nbsp;righ=
t after that schedule(), which might otherwise schedule something else (and=
 leave only interrupts for Xenomai to come back to life again). I have the =
impression that I cannot see this gatekeeper, nor the (n)RT threads using t=
he ps command ?
</div>
<div>&nbsp;</div>
<div>Is it correct to state that the&nbsp;current preemption issue&nbsp;is =
due to the gatekeeper being&nbsp;invoked too soon&nbsp;? Could someone know=
ing more about the migration technology explain what exactly goes wrong ?</=
div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>

------=_Part_19371_23229298.1137946775362--

