Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503615BE
	for <xenomai@lists.linux.dev>; Thu, 17 Nov 2022 16:45:32 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 85F53240011;
	Thu, 17 Nov 2022 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668703530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKlKwvllZS2B1N/JhTd4ZAtefAr3MQiwmgsFSPe9KLs=;
	b=H3CbZui6PFEexMFMxoDfc3JPTJhuhYhkiHgtZtkWPQwGZJynsF7qIHVXAVYZr8CbyZbl64
	reWAYMhakLl9BhV2+wjIHxRdx07xjIAMBBEwvFjooMHHcjzyf1rfxRFnqnLOzb4Vkud/gT
	jyNAMLgd/6amwAssjrYKubUtxvEU81bKoWzCQdg/Wap/SM1Vn1oVi6n/qWIyyou1ctZRhn
	ptINwxdEog57/cSUuU4OYUrrdaQ2iDAd9AMpvb98LyrmjPj0Z9He1QL0rsb4DClkXrjFg9
	uKOAUzzffqE22mCDHz52uk5XyddAMxz7VhIEuLuVP80+XA9VRCmBPn0Yj/utqQ==
References: <PH1P110MB1050FFAC564F1F74AFE24367E2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <8735ahczf9.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: EVL Thread Priorities
Date: Thu, 17 Nov 2022 17:43:11 +0100
In-reply-to: <8735ahczf9.fsf@xenomai.org>
Message-ID: <87y1s9bkd3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> Hello,
>>
>>=20=20
>>
>> We are seeing an issue with setting thread priorities. I=E2=80=99m not s=
ure if this is a real problem that is contributing to our issues, or if it=
=E2=80=99s just
>> something weird happening.=20
>>
>>=20=20
>>
>> Here is a list of the real time threads and the priority and CPU affinit=
y settings we=E2=80=99re asking for.
>>
>>=20=20
>>
>> Thread               Priority  CPU
>>
>> ___________________________
>>
>> Main                         50     0
>>
>> TxStartup                 52     0
>>
>> RxStartup                 51     0
>>
>> DummyTxConfig     89     2
>>
>> DummyTxService    88     3
>>
>> TxMain                      87     4
>>
>> TxWorker(n)             86    8-11
>>
>> DummyTxSample    85     5
>>
>> DummyRxConfig     79     2
>>
>> DummyRxService    78     3
>>
>> RxMain                      77     4
>>
>> RxWorker(n)             76    8-11
>>
>>=20=20
>>
>> If we run =E2=80=98top=E2=80=99 we can see the priority settings:
>>
>>   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMA=
ND
>>
>> 32130 root      20   0 3731268   2.5g 110748 S  0.0 16.2   0:05.54 realt=
ime_sfhm
>>
>> 32140 root      20   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 sigth=
read
>>
>> 32144 root     -51   0 3731268   2.5g 110748 S  0.0 16.2   0:00.09 Main
>>
>> 32150 root     -53   0 3731268   2.5g 110748 S  0.0 16.2   0:00.21 TxSta=
rtup
>>
>> 32151 root     -86   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 Dummy=
TxSample
>>
>> 32152 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWor=
ker0
>>
>> 32153 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWor=
ker1
>>
>> 32154 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWor=
ker2
>>
>> 32155 root     -52   0 3731268   2.5g 110748 S  0.0 16.2   0:00.13 RxSta=
rtup
>>
>> 32156 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWor=
ker3
>>
>> 32157 root     -88   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxMain
>>
>> 32158 root     -89   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 Dummy=
TxService
>>
>> 32159 root     -80   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 Dummy=
RxConfig
>>
>> 32160 root     -78   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 RxMain
>>
>> 32161 root     -77   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 RxWor=
ker0
>>
>> 32162 root     -79   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 Dummy=
RxService
>>
>>=20=20
>>
>> Top apparently has this weirdness where it displays real-time thread pri=
orities as =E2=80=93(P+1), which I guess is how it=E2=80=99s maintained in =
the kernel.
>> This seems to be a known issue, but it appears that, with this caveat, t=
hat the thread priorities are being set properly within the pthreads
>> implementation. The two non-realtime threads are part of our startup pro=
cess. They never execute within the EVL context.=20
>>
>>=20=20
>>
>> However, if we look at the same threads using =E2=80=98evl ps=E2=80=99, =
we get this result:
>>
>> CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT    =
 TIMEOUT      %CPU   CPUTIME     NAME
>>
>>   0   32144  fifo    50   34      1316      2910      0          Dto    =
 011.587        0.0  00:027.437  Main
>>
>>   0   32150  fifo    52   4       1286      1974      0          Dto    =
 075.003        0.0  00:023.977  TxStartup
>>
>>   5   32151  fifo    87   0       51201     587379    49931      wbto   =
 907.752        1.0  01:343.085  DummyTxSample
>>
>>   8   32152  fifo    87   0       19580     207489    19653      wbto   =
 998.796        1.0  01:240.410  TxWorker0
>>
>>   9   32153  fifo    87   0       19000     206602    19071      wbto   =
 905.257        1.0  01:242.255  TxWorker1
>>
>> 10   32154  fifo    87   0       16976     197880    17049      wbto    =
901.719        1.0  01:314.756  TxWorker2
>>
>>   0   32155  fifo    87   4       141       646       8          Dbto   =
 966.055        0.0  00:007.204  RxStartup
>>
>> 11   32156  fifo    87   0       16372     180026    16439      wbto    =
907.961        1.0  01:273.781  TxWorker3
>>
>>   4   32157  fifo    87   0       13443     851659    13390      wto    =
 902.939        1.5  01:929.911  TxMain
>>
>>   3   32158  fifo    88   0       1281      3845      0          Dto    =
 004.172        0.0  00:039.957  DummyTxService
>>
>>   2   32159  fifo    87   0       6515      260458    5314       wbto   =
 073.624        0.7  00:858.282  DummyRxConfig
>>
>>   4   32160  fifo    87   0       49059     626499    49185      wbto   =
 972.854        2.4  03:082.805  RxMain
>>
>>   8   32161  fifo    87   0       33436     386429    32535      wbto   =
 065.114        1.8  02:317.974  RxWorker0
>>
>>   3   32162  fifo    87   0       37243     378069    36132      Dbto   =
 071.350        1.9  02:374.748  DummyRxService
>>
>>=20=20
>>
>> CPU affinity settings look to be correct, but the priorities shown by =
=E2=80=98evl ps=E2=80=99 are not consistent with those from =E2=80=98top=E2=
=80=99. Furthermore, there seems
>> to be some difference between runs. Sometimes the priorities will be clo=
ser to those we asked for. At other times it looks more like this, where
>> they all appear to be set to 87.
>>
>>=20=20
>>
>> I don=E2=80=99t know if this is just a mistake by the =E2=80=98evl ps=E2=
=80=99 command, or if the EVL scheduler is actually using the wrong priorit=
ies for scheduling.
>> Relative to our other issue that you=E2=80=99re looking at, this one is =
definitely of lower importance, unless it is related in some way to that ot=
her
>> problem.
>
> The 'b' flag appearing in the STAT field for a thread means that it is
> undergoing a priority boost due to mutex priority
> inheritance/protection, PRIO displays the effective priority which may
> be boosted - not the base priority.
>
> By the way, if evl ps is able to catch this output frequently, this
> means that your app triggers *a lot* of priority inheritance, maybe a
> bit too much/frequent sharing of resources between threads which belong
> to distinct priority groups?

CAUTION: if these priorities remain unchanged over time, then there
could be an issue in the core, i.e. some threads not being deboosted
properly. You may want to check this by running a display loop, e.g.

# watch -n1 evl ps -l

--=20
Philippe.
