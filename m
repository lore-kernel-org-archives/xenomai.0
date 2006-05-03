Message-ID: <4458A62B.1040409@domain.hid>
Date: Wed, 03 May 2006 14:46:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200604171123.14192.lbocseg@domain.hid>
	<4443DA12.9000503@domain.hid>
	<200605021948.38480.lbocseg@domain.hid>
In-Reply-To: <200605021948.38480.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Re: [Xenomai-help] [PATCH] MSW and CSW meanings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> Hi Philippe,
>=20
> How about this patch? Or something like, if you prefer...
>

I really think that we should keep the /proc output as terse as
possible, but properly documenting the corresponding information in the
same move (which is not the case yet), so that we don't embed excessive
"dead" data into the kernel, but rather have a some accurate
documentation about it.

> Best Regards,
>=20
> Rodrigo.
>=20
> ____________________________________________________________
> Em Segunda 17 Abril 2006 15:10, Philippe Gerum escreveu:
>=20
>=20
>>Rodrigo Rosenfeld Rosas wrote:
>>
>>>Please, what do MSW and CSW mean on /proc/xenomai/stats?
>>
>>MSW =3D Mode switches: primary->secondary/secondary->primary (actually,
>>I'm going to only leave the first one)
>>
>>CSW =3D Context switches (operated by Xenomai for real-time threads,
>>kernel + user-space).
>>
>>
>>>Sorry if it is documented somewhere but I didn't find it on docs...
>>>
>>>Rodrigo.
>>>
>>>
>>>----------------------------------------------------------------------=
--
>>>
>>>Index: ksrc/nucleus/module.c
>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>--- ksrc/nucleus/module.c	(revis=C3=A3o 1024)
>>>+++ ksrc/nucleus/module.c	(c=C3=B3pia de trabalho)
>>>@@ -252,8 +252,8 @@
>>> 	pid_t pid;
>>> 	xnflags_t status;
>>> 	const char *name;
>>>-	unsigned long ssw;
>>>-	unsigned long csw;
>>>+	unsigned long ssw; /* mode switch: primary->secondary/secondary->pri=
mary */
>>>+	unsigned long csw; /* context switches */
>>> 	unsigned long pf;
>>>     } stat_info[1];
>>> };
>>>@@ -293,8 +293,13 @@
>>> static int stat_seq_show(struct seq_file *seq, void *v)
>>> {
>>>     if (v =3D=3D SEQ_START_TOKEN)
>>>-	seq_printf(seq,"%-3s  %-6s %-10s %-10s %-4s  %-8s  %s\n",
>>>-		   "CPU","PID","MSW","CSW","PF","STAT","NAME");
>>>+	{
>>>+		seq_printf(seq, "MSW - Mode Switches (primary->secondary/secondary-=
>primary)\n"
>>>+			        "CSW - Context switches (operated by Xenomai for real-time=
 threads, kernel + user-space)\n"
>>>+			        "PF  - Page faults\n");
>>>+		seq_printf(seq,"%-3s  %-6s %-10s %-10s %-4s  %-8s  %s\n",
>>>+			   "CPU","PID","MSW","CSW","PF","STAT","NAME");
>>>+	}
>>>     else
>>> 	{
>>> 	struct stat_seq_info *p =3D (struct stat_seq_info *)v;


--=20

Philippe.


