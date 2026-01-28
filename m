Received: from sonic306-20.consmr.mail.ir2.yahoo.com (sonic306-20.consmr.mail.ir2.yahoo.com [77.238.176.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521F23C4FD
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609078; cv=none; b=h5eA1GKybT4S7yHdH7d9c5nCyS3vwXO1Lg8oCF+9DoKnWIgK2Q1TAesKHLpmCeX6kLmqm2ftQAuUybe1sU26m0RZMiN1HNfoOcL4HELCit8yhYzXj6J2Y40GdgzA2TAq81ClARetoCdJ44Ocjbxyw++PtkVfEQOxwUqMnqqBpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609078; c=relaxed/simple;
	bh=r4D5mO1B7vlySqZebE5vwdbit2hlkNkWuC7fcWWXi3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NghcH894GVV8H+OTcaQMsGZ+j1egA+ZqZSuBncw29nF1Vl3Ag0U0FLPl1WYxXivDXY68Sn6jKY2J+1wMpLTi1eFwUekzoxGHGv9zThItlZflYznldQ3z6S/1aC+3xj5LSxVk/qEnTeppsyw+u4W71Bn23LLhvnbG+8tF6o+MvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kkv1YG1o; arc=none smtp.client-ip=77.238.176.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kkv1YG1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769609073; bh=r4D5mO1B7vlySqZebE5vwdbit2hlkNkWuC7fcWWXi3E=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=kkv1YG1oZLG4mCoF/8Q1335gDZ0K6BvCy0EAO4LQ3w6iLrL7EL4V2A782Mxi4XRCDb5wsXumSKomfUXhZr2g9VIM8AK7QO6LYIJQLN67aC87SdKIIuvPEpDshqlg0+VsHQFH6M25/B3UU1rew9fCcKnPgEKSa6oinR4ysguH51ODfkMozMGvs9jCDEGsWlbjzCY8KPi2YhyVbaTWMPIefswP4hFfA+/ajvjmKCTAJYn4ZnabSE4exPJpeh32/h4nWEFRIkCKIbrBDZx0yFOKeNc8wC3iIDH2fj+Z49ySI9SIb+7VOJNrzfEulPZ91Ga7DlD0rRcHeoj1sCfn9r2uww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769609073; bh=HHzd0ZcyPAL7H4u/jnTE8xG+mCdyqnZjWKbFaqQ6gmY=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=k3QM+17Sr6Icv2B+KkHBF1iYNyIQHPUgaK15eiB3io91afYqIbsKNEjzOv1aJTW4IH3XJCBO6l/sVLb6yQG7UAQt7tDS28+BBosOyBNU1l5StCq0I/DKDdUCroCZd7dfwmBOfW8H+KAbxKR+8qFa3XtTNq1S6E43giFEyaHp4/fPAu+N0qFFcp0XRBG26R1v1u6CGNHuFpplrXQFHHKkMel08WzB2IaWgKaGi7oz/yNPV4m4BeciyyDeJDDC2xVRT0jLnQDK+TV8ykf7Oh3nJgeJsX8XPgixBVsm7OO/BSg3v7d3xGuwIUXOenMx9bHFY8kcJvRmXSpaD3V1H6LMyw==
X-YMail-OSG: NIssXpMVM1nQoACj2PrB0ZmpFov0Jyz9G2dIvo8nh6dK9ohGvdRA7gNNTcbByg0
 h.A81OlqQh1zEchiDz1oR2AmV6DUCi2xo_5Xc4Tq1Usmwj80sOXgrPklg7_jnRuU2DGbC.eR0c0x
 bUQJZhe3sKy4YA7lgD1hGACjkgo5JHTWD_Hs3xU1wcQZsYBO.JHdC_hHhmA7rCg2SXEh7FKm7E9K
 wcOu6zNfhiTlqhEMHxslPUq5M4IWb1XEnxycOxZChpIXk9AtUqYTdf8_LN54dpXR8cGxSYhkGuCc
 .bxMPT1zlm1X5PKVExEr4BoqDnhw1uD1C.b1aSDjz0n81q7K4nxBW7akl429mR6ebg.cC6cuxIXH
 lH2VSQ1v6zELGCCxd4T5VnuC6SU5U_5gew0HsDo_dPgy_MAvgt3iT7Qe1axNgczKJGCE2k5BiTqD
 TmrBAj7uyWviZVgT1HMstqUh2Pf4sw2Bpv8xzVN2vOkzoNo7dPX.kNxYcX8kymcID7shfgFLiFS_
 rVnC0iTTg7ekm1K_lL_h9_FamKBqGcKK8FLKLcsRC8w6mb8DV4NbzWpy4EymQpaW0da_BXAwoy3M
 rT2c5hWshxZrFOO7lOI679EAYAzPUH63jnJrPpCV_pqYNReHEOqbgTo5sg8Ff5NThdVFJyVuyr1A
 UZtnaNrL12RffYUBHyNtm0.hdZuc.2_0MtdGhg7L6Roe9sSf5fjSG56cX.jm9VVt3OXFYVKPoSiV
 KVvo_ka.9REMcVlZzDESVMkOsF1nTfFyo14nzQXlWnAN4IWrGIn4L1zJ2wAepItPQlt2Fni_1kqp
 7AKoYncGJrkJtO0PGi6SJc10qp33WAUzOWHHIqo_pz6qyF42aAemaVDfFg475jznn8wXKNUTh3ju
 ewXAypML9avwSNNQ7TBCcPChIH.mmqxnnc7UpW96EGDW0a..y8E6wAi00vynKKydZwCjxzq4h.rI
 lXwOi73v6CqkR4HAcFCC5XOE.IT3tDzZM57k7KxfwZtBacyhVtVs6qIhl55ExQSs4hR_Al0I67Pc
 RHiBGneraWbf.oyFQoREAJXcwNyVxy82fCY763afP2fTyJsiJOZQGP83CIK11o.FqsYvqZs7sWup
 ecubbo4h.BIrWphLP_GNAuBDE0iJoeSsDv5XRFBZzbcjh4S0UPkhGzNBVKxstyne_VjvXEmtpu7a
 eL3iyuN0ZYSGaBaL_GD3O2ysOsJLyCxmRUbH0g3mFB4lajM8oy0mgk37.WA4TdayWYlu9yQ2ieyq
 8HHNW4H3oy8_KFjZ9diN.ywHvCJmf1kkKnIYXc8CZrSMaRDWuIi1KLRNZd6SOCXE8z_ehZ4u9vZw
 XW_opPQiMgoQYppwtmLPuH8VJHjrQIAN8E1uyAV89dodM5IwX.Au2u4DHUcc.x9wx5iXiOOe9gTZ
 sZBD.n7NX2sGl2wT4sZD_wKpfKL5WpbdDcS.H3nSMrVyGDyb4XdkZrVHzhVffpz_lydJ1aCokjeH
 KdRoQjwxlcACHCVmc_Co7_KGSLIrFXHY3TYk4hDoaMOQ10._aNg.E_WmAIbZBDJGh4xzX9Gt02km
 LAWErJ8dxjrkDlUZHMW0VL4g04p8pqchYfshTeGO4J95HZ3iaaiePe0qMxRQK2OUIkBr5mBbdNNH
 PbdLzV0KyF9pTY9axg.mmobD9BZaVOzZpDMVX.rJvlhKFmMLFkEKUhDDlf68qAq9oticr.hAdgHN
 tA5PO41nuVC8_2K8jTUJD6jG.WjyG5HN4Q0O4Qrn1lSk8SYbNO5M8xtsCOY8BdPq5HHvJ3klnRoa
 nMQhoP4yKBJxjq9okaaRAVcpFKkbUITub_AcratNviUJ5aLwFO_UasywzGwc1DkO0Xna2.qBzP_B
 0_005undGEOzfjrLwJggDBaEHH8wNA6Sx0JnIGOBBbVOihcQ5EtyKirc86WCgOU0s6oiUPTotMHs
 14Bq4L0ItQLpIn8WmXq26A.tMxCTrSCAf5dUayF4T4zRBB4HS2gkJc7nzM3rSezu7UyAsq1wTHvm
 sMwIip64etwhu8iOWg3fKhFFT2vYMXRbF3M1WnR004OzAKUQa7A_cuIS_Hkvc7z0WwG..myuGo0p
 EKd_QtiC1O.z2HRP6dOsbYudcxrvaBpnZBtSqnmIGntZZBBtedbyJBtaRNBnNzi2GQ1zOZvvkFSJ
 jfN3OFhoThM0Fqi8yXqavVsRq6jMVDtm5G2uGa3ObpxWkqZ3tHu7Sf2JPi.siL6FCLW3hJ5CR6rB
 fK.HdjVjBKeaEDCpE9mu.hC2_jnM-
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 8e04f131-01f5-4bd3-a871-eda4bc695516
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Wed, 28 Jan 2026 14:04:33 +0000
Received: by hermes--production-ir2-6fcf857f6f-dsxd6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5284fa3e932d3433610ccca7121ca608;
          Wed, 28 Jan 2026 13:03:46 +0000 (UTC)
Message-ID: <7d2de011f553742fb9c016f190956dd72792d8ec.camel@yahoo.com>
Subject: Re: rt_task_resume() resumes a wrong task
From: "Mauro S." <mau.salvi@yahoo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Date: Wed, 28 Jan 2026 14:03:47 +0100
In-Reply-To: <f9116b18-0aa2-4b32-bce1-98913cf0c721@yahoo.com>
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
	 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
	 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
	 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
	 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
	 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
	 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
	 <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
	 <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
	 <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
	 <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
	 <badbf3d2-4ff7-4d72-ae3e-24898f84c015@siemens.com>
	 <f9116b18-0aa2-4b32-bce1-98913cf0c721@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, 2025-12-19 at 15:12 +0100, Mauro S. wrote:
> On 12/19/25 07:50, Jan Kiszka wrote:
> > On 17.12.25 17:16, Mauro S wrote:
> > >=20
> > >=20
> > > On 12/17/25 13:31, Jan Kiszka wrote:
> > > > On 17.12.25 09:42, Mauro S wrote:
> > > > > On 12/17/25 07:59, Jan Kiszka wrote:
> > > > > > On 02.12.25 09:56, Mauro S wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 11/26/25 12:50, Mauro S wrote:
> > > > > > > > On 11/25/25 17:51, Jan Kiszka wrote:
> > > > > > > > > On 25.11.25 16:10, Mauro S wrote:
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > On 11/25/25 15:33, Jan Kiszka wrote:
> > > > > > > > > > > On 25.11.25 13:23, Mauro S wrote:
> > > > > > > > > > > > Hi all,
> > > > > > > > > > > >=20
> > > > > > > > > > > > Not sure if I found an obscure corner case or
> > > > > > > > > > > > I'm doing something
> > > > > > > > > > > > nasty.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I'm using Xenomai 3.2.8 on an Intel Atom system
> > > > > > > > > > > > with Linux
> > > > > > > > > > > > 5.4.299.
> > > > > > > > > > > > Target image and toolchain generated by Yocto.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Please find attached test case code.
> > > > > > > > > > > > Program is very simple: the main task starts a
> > > > > > > > > > > > bunch of joinable
> > > > > > > > > > > > tasks
> > > > > > > > > > > > that immediately suspend theirselves. After
> > > > > > > > > > > > starting tasks, the
> > > > > > > > > > > > main
> > > > > > > > > > > > task resumes all tasks. They do a small sleep
> > > > > > > > > > > > and then
> > > > > > > > > > > > terminates.
> > > > > > > > > > > > Terminated tasks are joined by another task,
> > > > > > > > > > > > that was launched
> > > > > > > > > > > > at the
> > > > > > > > > > > > beginning of the program execution.
> > > > > > > > > > > > Subsequently, main task continues to recreate,
> > > > > > > > > > > > restart and resume
> > > > > > > > > > > > joined
> > > > > > > > > > > > tasks, on and on, until a CTRL+C is issued.
> > > > > > > > > > > >=20
> > > > > > > > > > > > What I observe is that, when calling
> > > > > > > > > > > > rt_task_resume(), the wrong
> > > > > > > > > > > > task is
> > > > > > > > > > > > resumed.
> > > > > > > > > > > > Please see the attached log. In this log I'm
> > > > > > > > > > > > printing the .handle
> > > > > > > > > > > > and .thread data in RT_TASK function as
> > > > > > > > > > > > hexadecimal.
> > > > > > > > > > > > At row 19 you can see that Task1 (that has
> > > > > > > > > > > > .handle value fc1c9,
> > > > > > > > > > > > the same
> > > > > > > > > > > > of the terminated but not yet joined task 0)
> > > > > > > > > > > > has been resumed
> > > > > > > > > > > > when
> > > > > > > > > > > > the
> > > > > > > > > > > > rt_task_resume() was called on Task0. Task0 has
> > > > > > > > > > > > been
> > > > > > > > > > > > terminated its
> > > > > > > > > > > > execution, but has NOT been joined yet: if I'm
> > > > > > > > > > > > not wrong its
> > > > > > > > > > > > resources
> > > > > > > > > > > > should not be usable until join is done (at
> > > > > > > > > > > > least this is what I
> > > > > > > > > > > > understand by documentation). I expect that
> > > > > > > > > > > > calling
> > > > > > > > > > > > rt_task_resume() on
> > > > > > > > > > > > a terminated-but-not-yet-joined joinable task
> > > > > > > > > > > > should return an
> > > > > > > > > > > > error,
> > > > > > > > > > > > not resume another task. Am I wrong?
> > > > > > > > > > > >=20
> > > > > > > > > > > > I know that is some of a stressful test: in
> > > > > > > > > > > > fact if I call the
> > > > > > > > > > > > rt_task_resume() only if task is not terminated
> > > > > > > > > > > > (checking also
> > > > > > > > > > > > the
> > > > > > > > > > > > executed flag adding "&& TaskList[i].executed
> > > > > > > > > > > > =3D=3D 0" into the if)
> > > > > > > > > > > > the
> > > > > > > > > > > > problem obviously does not happen, but as I
> > > > > > > > > > > > said I expect an
> > > > > > > > > > > > error
> > > > > > > > > > > > instead of a wrong resume.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Launching the attached code, you should be able
> > > > > > > > > > > > to reproduce the
> > > > > > > > > > > > problem
> > > > > > > > > > > > on your side. When the test detects a wrong
> > > > > > > > > > > > resume, program
> > > > > > > > > > > > terminates
> > > > > > > > > > > > automatically.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Can you rule out data races on the shared
> > > > > > > > > > > TaskList structure?
> > > > > > > > > > > Seems
> > > > > > > > > > > both
> > > > > > > > > > > your sub-tasks and the main one are accessing it,
> > > > > > > > > > > and that
> > > > > > > > > > > possibly
> > > > > > > > > > > concurrently and/or unordered. Or does this also
> > > > > > > > > > > trigger in a
> > > > > > > > > > > uni-core
> > > > > > > > > > > setup?
> > > > > > > > > > >=20
> > > > > > > > > > > Jan
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Hi Jan,
> > > > > > > > > >=20
> > > > > > > > > > attached the modified code: each access to a
> > > > > > > > > > TaskList element is
> > > > > > > > > > now
> > > > > > > > > > protected with a semaphore (one semaphore each
> > > > > > > > > > element).
> > > > > > > > > > Strange behavior happens anyway.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > ...would have been too easy. Ok, will try the other
> > > > > > > > > day if I can
> > > > > > > > > reproduce and maybe even understand.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Hi Jan,
> > > > > > > >=20
> > > > > > > > sorry, I should me more verbose in my response.
> > > > > > > > First of all: no pressure, take your time.
> > > > > > > >=20
> > > > > > > > Then, a more deep explanation.
> > > > > > > > I added semaphores to avoid possible concurrent access
> > > > > > > > on TaskList
> > > > > > > > elements, but I already verified that code should
> > > > > > > > access them in an
> > > > > > > > ordered way without concurrency, thanks to "joined",
> > > > > > > > "started" and
> > > > > > > > "exited" flags.
> > > > > > > > In detail, TaskList elements are accessed:
> > > > > > > >=20
> > > > > > > > - by main task
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - under task creation, writi=
ng task handler and
> > > > > > > > "joined"
> > > > > > > > flag: this
> > > > > > > > happens only if task was joined before
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - to resume task, reading so=
me elements
> > > > > > > > ("started", "joined" and
> > > > > > > > task handler) and writing "resumed" flag before
> > > > > > > > resuming the task.
> > > > > > > > Here, "started" must be 1 and "joined" must be 0, this
> > > > > > > > can happen
> > > > > > > > only
> > > > > > > > after task creation and start
> > > > > > > >=20
> > > > > > > > - by sub-tasks ourselves: during their execution.
> > > > > > > > Variables written:
> > > > > > > > "started" (at the beginning of the task) and "exited"
> > > > > > > > (just before
> > > > > > > > termination, after task is resumed and did its sleep).
> > > > > > > > Also, verifies
> > > > > > > > "resumed" flag when got resumed, to check if resume
> > > > > > > > request was
> > > > > > > > for it
> > > > > > > >=20
> > > > > > > > - by join task: this happens only if task is "started",
> > > > > > > > "exited" and
> > > > > > > > not "joined". This can happen only after a complete
> > > > > > > > subtask execution
> > > > > > > > task resets all flags and sets "joined" to 1
> > > > > > > >=20
> > > > > > > > Printf sequence seems to confirm that execution order
> > > > > > > > is OK.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > If you would like to understand a bit more already,
> > > > > > > > > you could
> > > > > > > > > catch an
> > > > > > > > > event trace (trace-cmd record -e "cobalt*" -e
> > > > > > > > > "sched*" -e
> > > > > > > > > "signal*") and
> > > > > > > > > study the task interaction (trace-cmd report /
> > > > > > > > > kernelshark).
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I'll do the setup to trace events (I don't have trace-
> > > > > > > > cmd on
> > > > > > > > target, I
> > > > > > > > need to setup a qemu image with it).
> > > > > > > >=20
> > > > > > > > Thanks in advance, regards
> > > > > > > >=20
> > > > > > > > Mauro
> > > > > > > >=20
> > > > > > > > > Jan
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > Hi Jan,
> > > > > > >=20
> > > > > > > I made a sequential version of the test application:
> > > > > > > instead of
> > > > > > > having a
> > > > > > > join task, join call was done by the main task, one
> > > > > > > subtask at time.
> > > > > > > With this code, tasks does not access concurrently to
> > > > > > > variables.
> > > > > > > Problem happens also with this code.
> > > > > > >=20
> > > > > >=20
> > > > > > Starting to look into this:
> > > > > >=20
> > > > >=20
> > > > > Great, thank you!
> > > > >=20
> > > > > > > STARTED TASK Task0 (82a9eab0-829636c0)
> > > > > > > TASK Task0 RUNNING (self: 82a9eab0-829636c0=C2=A0 ext:
> > > > > > > 82a9eab0-829636c0)
> > > > > > > STARTED TASK Task1 (82a9e2b0-829526c0)
> > > > > > > TASK Task1 RUNNING (self: 82a9e2b0-829526c0=C2=A0 ext:
> > > > > > > 82a9e2b0-829526c0)
> > > > > > > RESUMING TASK Task0 (82a9eab0-829636c0)
> > > > > > > RESUMED TASK Task0 (self: 82a9eab0-829636c0=C2=A0 ext:
> > > > > > > 82a9eab0-829636c0)
> > > > > > > RESUMING TASK Task1 (82a9e2b0-829526c0)
> > > > > > > RESUMED TASK Task1 (self: 82a9e2b0-829526c0=C2=A0 ext:
> > > > > > > 82a9e2b0-829526c0)
> > > > > > > TASK Task1 EXITED (self: 82a9e2b0-829526c0=C2=A0 ext:
> > > > > > > 82a9e2b0-829526c0)
> > > > > > > TASK Task0 EXITED (self: 82a9eab0-829636c0=C2=A0 ext:
> > > > > > > 82a9eab0-829636c0)
> > > > > > > JOINED TASK Task1 (82a9e2b0-829526c0)
> > > > > > > STARTED TASK Task1 (82a9eab0-829526c0)
> > > > > > > TASK Task1 RUNNING (self: 82a9eab0-829526c0=C2=A0 ext:
> > > > > > > 82a9eab0-829526c0)
> > > > > >=20
> > > > > > So far so good.
> > > > > >=20
> > > > > > > RESUMING TASK Task0 (82a9eab0-829636c0)
> > > > > >=20
> > > > > > And here you are resuming a task that is in waiting-to-be-
> > > > > > joined state,
> > > > > > right? That is an application bug, but one may expect it to
> > > > > > be either
> > > > > > ignored, only affect that Task0 negatively, or even
> > > > > > throwing an error
> > > > > > back to the caller.
> > > > > >=20
> > > > >=20
> > > > > Yes, exactly: task is ended yet, then should be joined and
> > > > > not resumed,
> > > > > but I would expect that the resume command was ignored and/or
> > > > > an error
> > > > > was returned.
> > > > >=20
> > > > > > > RESUMED TASK Task1 (self: 82a9eab0-829526c0=C2=A0 ext:
> > > > > > > 82a9eab0-829526c0)
> > > > > > > ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0=C2=A0 ext:
> > > > > > > 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
> > > > > >=20
> > > > > > Instead, we see that spurious wakeup of task1. Let me debug
> > > > > > into
> > > > > > this...
> > > > > >=20
> > > > >=20
> > > > > Thumbs up!
> > > >=20
> > > > Ok, here is the catch: The task handle that was used for task0
> > > > is freed,
> > > > even before someone joined that task. And task1 handle was
> > > > freed as well
> > > > before you call CreateAndStartFn(1) again. Now your task1 will
> > > > get the
> > > > handle of previous task0, and when you try to use that stale
> > > > handle for
> > > > resuming task0, alchemy looks up the new task1 instead - and
> > > > resumes
> > > > that.
> > > >=20
> > > > I looked a bit into whether we could delay the handle
> > > > deregistration
> > > > after the joining, but that would be a hairy operation, likely
> > > > also
> > > > affecting libcopperplate. Given all that, I think we are safer
> > > > off
> > > > living with this "specialty", rather than risking instability
> > > > in the
> > > > cleanup path to handle the application error a bit nicer.
> > > >=20
> > > > Jan
> > > >=20
> > >=20
> > > Ok, got it.
> > > IMO this behavior should be documented somewhere because it's not
> > > what a
> > > user would expect.
> > >=20
> > > Just throwing out an idea (that could be completely wrong): to
> > > workaround the deregistration issue, should the resume function
> > > use both
> > > the two RT_TASK fields to decide if resume or not a task,
> > > resuming it
> > > only if both the two IDs matching? From the log seems that the
> > > second
> > > field (pthread ID?) stills occupied until the join happens.
> > >=20
> >=20
> > I played with that idea. It initially looked simple, then reveal a
> > catch, but I think I was able to address that as well. Please have
> > a
> > look at the patches I just shared.
> >=20
> > Jan
> >=20
>=20
> Hi Jan,
>=20
> I've seen patches, thanks a lot!
> Unfortunately I'm not able to test them on the final system, but a
> quick=20
> test in a QEMU machine works properly (no doubts about it).
>=20
> As soon as I'll test on the final system, I'll be back with a
> feedback.
>=20
> Thanks again, regards
>=20

Hi Jan,

sorry for the long delay.
I managed to try your patches on the final system and I confirm that
they work.

Thanks a lot, regards

Mauro
