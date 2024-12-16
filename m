Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341D157469
	for <xenomai@lists.linux.dev>; Mon, 16 Dec 2024 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330256; cv=none; b=aZ5ZJgCGK9vNX2pKnWHrwcGursLdo+tnHNHRYwL2Kh/LmVfnQHZDvwEKXuFabVUM9X7PGpYd9J4TttIUYjJlWpE66ID/9oMCkmloG2Ki5TWOL+q41LxY9wqswAbaoSmzoQxV+xJCXtH1dnrgtIhCLa6j8VRr24IPNw+wRonvlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330256; c=relaxed/simple;
	bh=XW8V/TBj3yPGVCW+HJLFia2K2hvq8nuK76gBsSMgNkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjSMSIiI6z9pwvBMWEjzmm6DWEptggrCdYxWI/rXaF6dYDSzp60UcEc/cGJaBjrwLLUAib7X04atds6WKhq3eKCf5UBHwMmeMTkCp13hrDgz1CM9lGylbkU+qSh5dNEZ0ELA4LAyi+L+zc/554wmxr5yFet3k5bjIHyN0zJQUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9b4i0Fs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9b4i0Fs"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-303548a933aso5486221fa.3
        for <xenomai@lists.linux.dev>; Sun, 15 Dec 2024 22:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734330252; x=1734935052; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDNjym9nZT56PmyvNAJ1+YUAjumiZIsmukLhKkkjn/I=;
        b=I9b4i0FsJiUegq+zusvf5WehTOCV1L5TJK3h0una41vRHKUTMexCkzTzwmIIWUwL0d
         M6BjjvolglwQBzYYh1EbaIxQLRckx3E86+gT8TUVU539ah+7LfwAdRxjcgIeyF92fnX/
         IZz3a140ecoppvn8g4MDRJ5aPYHLUc4H+NByw2Vh8+E/m/MJmcZ1LAIUn3d1EhbVmk2Y
         /BlNsRrlxCh8HyDxRlF0hVM3YD4H66GpM7sk66Oi3Mul37tz5ZN4IpjMt9IlM3Ts1lpw
         imDkzX63S+Lu0CLbuO5pWgFVyZTSKAJPywDBrtcitpILPAOzCclO6fB7uR4gytCxyAR5
         0ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734330252; x=1734935052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDNjym9nZT56PmyvNAJ1+YUAjumiZIsmukLhKkkjn/I=;
        b=vEoLCQ+8haqYwHHvSPjUhPrCbZnAbvudD3a9xt9CK9cdUQ6k3HUM/gO2G2q+QZ6MQg
         yRGv99h1uJe4DH010B8mOVqS7AITizzquRVIDverWq2o8kXY4zL6FTy5t/pTL579xMZ2
         Pk6dvgpVErDL437itN1KlOlbRNMXwFGYMHTpHT+oUVX5IhhO9IUFLU1DupdvpC7aQXzi
         6ufFlAY2/AkjjKyCfmxYUS5Cr6eJ/iYBp41o73TIanhOfffru7DzroaA8x5oS6oKIr+m
         Q8PI2zHSLrIJ6+5J/gSU5zY62yWZZsgtj8PCzwisXCeiwtR0sT/cOXEhHjSi4xbiagSG
         bsyw==
X-Forwarded-Encrypted: i=1; AJvYcCW6/8PyqA/RVNlb5uqj+J2CNOQd4IgZ1pn+rxZIL9N47/m6v2+h2ABkIx3c21olQS6UOiaeMeg0@lists.linux.dev
X-Gm-Message-State: AOJu0YxStK2Eam1EJuqE+0FDmRdZN/HmJBeLfTEFQPE6ZnX//KuEvb8U
	yiXsGjQ9kzLJy/IjYz5B3Ev+oQ0Fnnp3x9tFaB9ITV9qyh8yrS+pdg2irt79Wawvb93vaJgFsZx
	BnuQrfcXlm9fuOkPkuiV1Hds5xxTO9GONKemaiA==
X-Gm-Gg: ASbGnct5gqG1SVsy4N3badiQGa+YG0mXc1+nOYfnHb58O5oa5LpDRXgNCdJQm9F30Sw
	mqGfXuthW9XqozDD07QBfkisnMGkT7A1S55wShvz4jBdBp5bbQPH9bDGrILRgit1lymlXdVUF
X-Google-Smtp-Source: AGHT+IGdTgBn2wNj3VymQoPro3bh2Mp78fm5zjV4l+qH2VZqDcI/3a4zj+ziYrKdTu5GCRu8sioVUY5654qALQMx/Rk=
X-Received: by 2002:a05:651c:2208:b0:300:1f2c:e3cf with SMTP id
 38308e7fff4ca-3025457ff2cmr35884481fa.13.1734330251603; Sun, 15 Dec 2024
 22:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <AS8PR04MB8119B0401C5CB0EA31DF207DE1352@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <AS8PR04MB81198798255FBF290C500120E1372@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <AS8PR04MB8119B91C92C4361DDB6FBE2DE1302@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <87ser2wld2.fsf@xenomai.org> <AS8PR04MB8119D9E6C982D6BB998B4380E1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <AS8PR04MB8119242427AA2F405CBBD9DBE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <AS8PR04MB8119EF7586D426724D8ADC6CE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
 <AS8PR04MB8119D818B3D79ADBDBFE980FE13B2@AS8PR04MB8119.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8119D818B3D79ADBDBFE980FE13B2@AS8PR04MB8119.eurprd04.prod.outlook.com>
From: Qichen Qiu <ruiqurm@gmail.com>
Date: Mon, 16 Dec 2024 14:24:00 +0800
Message-ID: <CAHR=ZXFzK6AoSy-j2gA=uf7ua+B5o2CSmZ+5kKcONQ2POTF2Pw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IEZXOiBbRVhUXSBSZTog6L2s5Y+ROiBQZXJmb3JtYW5jZSBpc3N1ZSBhYm91dCBYZQ==?=
	=?UTF-8?B?bm9tYWk0IEVWTCBjb3JlKHY2LjYuMjMtZXZsMi1yZWJhc2Up?=
To: Hongbo Wang <hongbo.wang@nxp.com>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, 
	Sam Chiu <ruiqurm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried running your program on a Raspberry Pi 5b with kernel version
6.6.47 and the bcm2711_defconfig. The latency I observed appears to be
relatively normal. Since the CTXSW and SYS results are nearly
identical, I did not apply your kernel patch for the test. Could you
please provide more specific instructions on how to reproduce your
results?

Here is the result of my test:

Linux raspberrypi 6.6.47-v8-16k+ #34 SMP PREEMPT IRQ_PIPELINE Mon Dec
16 05:24:51 UTC 2024 aarch64 GNU/Linux

start_rt_latency_thread(): sched_priority:99 cycle_time:125000ns.
rt_latency_thread: attched to XENOMAI EVL core!

sec,1,cnt,7997,time,-1542,-1293,19182,-1284.05,index,2120,184
sec,2,cnt,15997,time,-1542,-1232,19182,-1309.83,index,2120,184
sec,3,cnt,23997,time,-1665,-1283,19182,-1324.97,index,16011,184
sec,4,cnt,31997,time,-1665,-1095,19182,-1324.36,index,16011,184
sec,5,cnt,39998,time,-1665,-1351,19182,-1330.42,index,16011,184
sec,6,cnt,47998,time,-1665,-1349,19182,-1334.41,index,16011,184
sec,7,cnt,55998,time,-1665,-1310,19182,-1333.64,index,16011,184
sec,8,cnt,63998,time,-1665,-1329,19182,-1332.91,index,16011,184
sec,9,cnt,71998,time,-1665,-1273,19182,-1330.96,index,16011,184
sec,10,cnt,79998,time,-1665,-1275,19182,-1328.83,index,16011,184
sec,11,cnt,87998,time,-1665,-1275,19182,-1327.10,index,16011,184
sec,12,cnt,95999,time,-1665,-1350,19182,-1327.00,index,16011,184
sec,13,cnt,103999,time,-1665,-1149,19182,-1315.74,index,16011,184
sec,14,cnt,111999,time,-1665,-1301,19182,-1309.93,index,16011,184
sec,15,cnt,119999,time,-1665,-1324,19182,-1311.20,index,16011,184
sec,16,cnt,127999,time,-1665,-1309,19182,-1311.44,index,16011,184
sec,17,cnt,135999,time,-1665,-1296,19182,-1311.48,index,16011,184
sec,18,cnt,143999,time,-1665,-1098,19182,-1306.46,index,16011,184
sec,19,cnt,151999,time,-1665,-1142,19182,-1300.06,index,16011,184
sec,20,cnt,159999,time,-1665,-1131,19182,-1291.76,index,16011,184
sec,21,cnt,168000,time,-1665,-1101,19182,-1283.73,index,16011,184
sec,22,cnt,176000,time,-1665,-1311,19182,-1281.47,index,16011,184
sec,23,cnt,184000,time,-1665,-1117,19182,-1277.79,index,16011,184
sec,24,cnt,192000,time,-1665,-1108,19182,-1270.86,index,16011,184
sec,25,cnt,200000,time,-1665,-1137,19182,-1264.79,index,16011,184
sec,26,cnt,208000,time,-1665,-1147,19182,-1259.19,index,16011,184
sec,27,cnt,216000,time,-1665,-1122,19182,-1253.98,index,16011,184
sec,28,cnt,224001,time,-1665,-1095,19182,-1249.18,index,16011,184
sec,29,cnt,232001,time,-1665,-1312,19182,-1248.06,index,16011,184
sec,30,cnt,240001,time,-1665,-1140,19182,-1246.02,index,16011,184
sec,31,cnt,248001,time,-1665,-1135,19182,-1242.44,index,16011,184
sec,32,cnt,256001,time,-1665,-1112,19182,-1239.10,index,16011,184
sec,33,cnt,264001,time,-1665,-1127,19182,-1235.64,index,16011,184
sec,34,cnt,272001,time,-1665,-1105,19182,-1232.22,index,16011,184
sec,35,cnt,280001,time,-1665,-1140,19182,-1230.16,index,16011,184
sec,36,cnt,288002,time,-1665,-1229,19182,-1230.20,index,16011,184
sec,37,cnt,296002,time,-1665,-1116,19182,-1229.14,index,16011,184
sec,38,cnt,304002,time,-1665,-1116,19182,-1226.63,index,16011,184
sec,39,cnt,312002,time,-1665,-1115,19182,-1224.05,index,16011,184
sec,40,cnt,320002,time,-1665,-1133,19182,-1221.51,index,16011,184
sec,41,cnt,328002,time,-1665,-1154,19182,-1219.12,index,16011,184
sec,42,cnt,336002,time,-1665,-1135,19182,-1216.99,index,16011,184
sec,43,cnt,344002,time,-1665,-1322,19182,-1217.56,index,16011,184
sec,44,cnt,352002,time,-1665,-1120,19182,-1218.26,index,16011,184
sec,45,cnt,360002,time,-1665,-1086,19182,-1215.60,index,16011,184
sec,46,cnt,368003,time,-1665,-1032,19182,-1212.95,index,16011,184
sec,47,cnt,376003,time,-1665,-1110,19182,-1210.59,index,16011,184
sec,48,cnt,384003,time,-1665,-1096,19182,-1208.22,index,16011,184
sec,49,cnt,392003,time,-1665,-1082,19182,-1205.91,index,16011,184
sec,50,cnt,400003,time,-1665,-1272,19182,-1204.75,index,16011,184
sec,51,cnt,408003,time,-1665,-1277,19182,-1206.16,index,16011,184
sec,52,cnt,416003,time,-1665,-1431,19182,-1208.99,index,16011,184
sec,53,cnt,424003,time,-1665,-1123,19182,-1207.42,index,16011,184
sec,54,cnt,432003,time,-1665,-1131,19182,-1206.21,index,16011,184
sec,55,cnt,440004,time,-1665,-1304,19182,-1206.86,index,16011,184
sec,56,cnt,448004,time,-1665,-1312,19182,-1209.13,index,16011,184
sec,57,cnt,456004,time,-1665,-1301,19182,-1210.87,index,16011,184
sec,58,cnt,464004,time,-1665,-1309,19182,-1212.29,index,16011,184
sec,59,cnt,472004,time,-1665,-1134,19182,-1212.26,index,16011,184
sec,60,cnt,480004,time,-1665,-1144,19182,-1211.00,index,16011,184
sec,61,cnt,488004,time,-1665,-1117,19182,-1209.78,index,16011,184
sec,62,cnt,496004,time,-1665,-1166,19182,-1208.60,index,16011,184
sec,63,cnt,504004,time,-1665,-1139,19182,-1207.22,index,16011,184
sec,64,cnt,512005,time,-1665,-1094,19182,-1205.80,index,16011,184
sec,65,cnt,520005,time,-1665,-1327,19182,-1206.12,index,16011,184
sec,66,cnt,528005,time,-1665,-1136,19182,-1206.28,index,16011,184
sec,67,cnt,536005,time,-1665,-1112,19182,-1205.10,index,16011,184
sec,68,cnt,544005,time,-1665,-1366,19182,-1204.74,index,16011,184
sec,69,cnt,552005,time,-1665,-1139,19182,-1204.44,index,16011,184
sec,70,cnt,560005,time,-1665,-1135,19182,-1203.42,index,16011,184
sec,71,cnt,568005,time,-1665,-1131,19182,-1202.58,index,16011,184
sec,72,cnt,576005,time,-1665,-1313,19182,-1202.92,index,16011,184
sec,73,cnt,584006,time,-1665,-1031,19182,-1202.67,index,16011,184
sec,74,cnt,592006,time,-1665,-1287,19182,-1203.74,index,16011,184
sec,75,cnt,600006,time,-1665,-1303,19182,-1204.83,index,16011,184
sec,76,cnt,608006,time,-1665,-1301,19182,-1205.88,index,16011,184
sec,77,cnt,616006,time,-1665,-1313,19182,-1206.94,index,16011,184
sec,78,cnt,624006,time,-1665,-1142,19182,-1206.24,index,16011,184
sec,79,cnt,632006,time,-1665,-1319,19182,-1206.83,index,16011,184
sec,80,cnt,640006,time,-1665,-1122,19182,-1207.02,index,16011,184
sec,81,cnt,648006,time,-1665,-1129,19182,-1206.18,index,16011,184
sec,82,cnt,656007,time,-1665,-981,19182,-1205.46,index,16011,184
sec,83,cnt,664007,time,-1665,-1128,19182,-1204.64,index,16011,184
sec,84,cnt,672007,time,-1665,-1146,19182,-1203.82,index,16011,184
sec,85,cnt,680007,time,-1665,-1325,19182,-1206.35,index,16011,184
sec,86,cnt,688007,time,-1665,-1306,19182,-1208.07,index,16011,184
sec,87,cnt,696007,time,-1665,-1305,19182,-1209.54,index,16011,184
sec,88,cnt,704007,time,-1665,-1337,19182,-1210.79,index,16011,184
sec,89,cnt,712007,time,-1665,-1157,19182,-1211.01,index,16011,184
sec,90,cnt,720008,time,-1665,-1005,19182,-1210.40,index,16011,184
sec,91,cnt,728008,time,-1665,-1140,19182,-1209.63,index,16011,184
sec,92,cnt,736008,time,-1665,-1163,19182,-1208.76,index,16011,184
sec,93,cnt,744008,time,-1665,-1301,19182,-1209.03,index,16011,184
sec,94,cnt,752008,time,-1665,-1297,19182,-1210.01,index,16011,184
sec,95,cnt,760008,time,-1665,-1291,19182,-1210.91,index,16011,184
sec,96,cnt,768008,time,-1665,-1333,19182,-1211.79,index,16011,184
sec,97,cnt,776008,time,-1665,-1297,19182,-1212.65,index,16011,184
sec,98,cnt,784008,time,-1665,-1128,19182,-1212.06,index,16011,184
sec,99,cnt,792009,time,-1665,-1144,19182,-1211.45,index,16011,184
sec,100,cnt,800009,time,-1665,-1322,19182,-1212.00,index,16011,184
sec,101,cnt,808009,time,-1665,-1358,19182,-1213.02,index,16011,184
sec,102,cnt,816009,time,-1665,-1169,19182,-1212.73,index,16011,184
sec,103,cnt,824009,time,-1665,-1147,19182,-1212.26,index,16011,184
sec,104,cnt,832009,time,-1665,-1124,19182,-1211.92,index,16011,184
sec,105,cnt,840009,time,-1665,-1137,19182,-1211.62,index,16011,184
sec,106,cnt,848009,time,-1665,-1145,19182,-1211.31,index,16011,184
sec,107,cnt,856009,time,-1665,-1155,19182,-1211.23,index,16011,184
sec,108,cnt,864010,time,-1665,-1146,19182,-1210.96,index,16011,184
sec,109,cnt,872010,time,-1665,-1144,19182,-1210.68,index,16011,184
sec,110,cnt,880010,time,-1665,-1149,19182,-1210.39,index,16011,184
sec,111,cnt,888010,time,-1665,-1141,19182,-1209.97,index,16011,184
sec,112,cnt,896010,time,-1665,-1109,19182,-1209.44,index,16011,184
sec,113,cnt,904010,time,-1665,-1119,19182,-1208.92,index,16011,184
sec,114,cnt,912010,time,-1665,-1126,19182,-1208.42,index,16011,184
^CCPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT
    TIMEOUT      %CPU      CPUTIME       WCHAN                 NAME
  3   2204   fifo    99   0       915132    915133    0          D
  972            1.1      1:215.238    -
rt_latency_thread:2201


Statistic:
sec,115,cnt,915130,time,-1665,-987,19182,-1208.22,index,16011,184
rt_latency_thread: detached from XENOMAI EVL core!

Hongbo Wang <hongbo.wang@nxp.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=80
10:13=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Philippe Gerum <rpm@xenomai.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B412=E6=9C=885=E6=97=
=A5 17:05
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Hongbo Wang <hongbo.wang@nxp.com>
> > =E4=B8=BB=E9=A2=98: [EXT] Re: =E8=BD=AC=E5=8F=91: Performance issue abo=
ut Xenomai4 EVL
> > core(v6.6.23-evl2-rebase)
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message
using
> > the 'Report this email' button
> >
> >
> > Hongbo Wang <hongbo.wang@nxp.com> writes:
> >
> > > Hi Xenomai owner,
> > >
> > > I try to find the root cause of this issue, so I applied the
> > > attached linux-evl.patch for kernel, it will reuse RWA counter as
> > > timeout counter. if
> > RWA counter is not 0, timeout happens.
> > >
> > > In my test using evl_latency, I indeed captured the case that RWA
is not 0.
> > > after that, I supposed it may be caused by out-of-step between
> > > userspace vdso gettime and evl_read_clock(*MONO*) used in EVL
core,
> > > so, I
> > applied the patch libevl.patch for libevl, to get clock_id that
used in EVL core.
> > > but it also has same issue, SYS is bigger than CTXSW obviously
> > > because of
> > using non-vdso gettime.
> > >
> > > CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA
> > STAT     TIMEOUT      %CPU      CPUTIME       WCHAN
> > NAME
> > >   0   959    fifo    99   0       2392593   14291411  9
> > D       044           14.7     43:330.732    -
> > main_cycle_task:954
> > >
> > > I attached my evl_latency for ARM aarch64, , it's like cyclictest,
> > > the command is: "./evl_latency -p -c 125000 -t 600",
> > >
> > > the code is following:
> > >
> > > evl_read_clock(CLOCK_MONOTONIC, &now)
> > > while(1) {
> > > =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82next =3D now + =
125000;
> > > =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82evl_sleep_until=
(CLOCK_MONOTONIC, TIMER_ABSTIME,
&next);
> > > =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82evl_read_clock(=
CLOCK_MONOTONIC, &now);
> > > =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82latency =3D now=
 - next;
> > > }
> > >
> > > the output is:
> > > cnt,5200591,sec,521,time,-545,242,13070,307.49,index,2500281,0
> > > cnt,5210592,sec,522,time,-545,576,13070,307.46,index,2500281,0
> > >
cnt,5220593,sec,523,time,-545,296,234278,308.04,index,2500281,521537
> > > 0
> > >
cnt,5230594,sec,524,time,-545,282,234278,308.03,index,2500281,521537
> > > 0
> > >
> > > you can see that max latency has changed from 13070(ns) to 234278,
> > > and
> > RWA is 15:
> > >
> > > CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA
> > STAT     TIMEOUT      %CPU      CPUTIME       WCHAN
> > NAME
> > >   0   667    fifo    99   0       5990681   5990696   15
> > D       338            2.9     17:495.597    -
> > rt_latency_thread:665
> > >
> > > Statistic:
> > >
> >
cnt,5990684,sec,600,time,-545,3941,234278,304.01,index,2500281,5215370
> > >
> > > BR,
> > > Hongbo
> > >
> > >
--------------------------------------------------------------------
> > > --
> > > ---------------------------------------------------
> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Hongbo Wang
> > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B412=E6=9C=882=E6=97=
=A5 16:11
> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: rpm@xenomai.org <rpm@xenomai.org>
> > > =E6=8A=84=E9=80=81: Hongbo Wang <hongbo.wang@nxp.com>
> > > =E4=B8=BB=E9=A2=98: Performance issue about Xenomai4 EVL
core(v6.6.23-evl2-rebase)
> > >
> > > Hello Xenomai owner,
> > >
> > > I'm evaluating the performance of my RT program, running on
Xenomai4
> > > EVL core, I have ported the patches from v6.6.23-evl2-rebase to
our
> > > kernel
> > branch v6.6.23.
> > >
> > > Then I attached my RT thread to EVL core and tested the
performance,
> > > but I found a interesting thing,
> > >
> > > when CTXSW is same to SYS, system latency is ~15us, it's a very
good result.
> > >
> > > # evl ps -l
> > > *
> > >
> > > but when  CTXSW is different from SYS,  system latency is ~200us,
> > > seems
> > that something goes wrong.
> > >
> > > *
> > >
> > > in which case, CTXSW is less than SYS or different?
> > >
> > > how can I resolve this issue?
> > >
> > > Thanks in advance.
> > >
> > > Best regards,
> > >
> > > Hongbo
> > >
> > >
> > >
> > > NXP Beijing SE team
> > >
> > > *
> > >
> > > [4. linux-evl.patch --- text/x-patch; linux-evl.patch]...
> > >
> > > [5. libevl.patch --- text/x-patch; libevl.patch]...
> > >
> > > [6. evl_latency --- application/octet-stream; evl_latency]...
> >
> > Please use the project mailing list at xenomai@lists.linux.dev,
hosted
> > at [1] for any technical question. Also, providing the full source
of
> > your test code is good practice to help people figuring out the
issue
> > at hand, executable files are unlikely to be either useful to or
even
> > considered for debugging by the contributors there.
> >
> > [1]
> >
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsubs
> > pac
> >
e.kernel.org%2Flists.linux.dev.html&data=3D05%7C02%7Chongbo.wang%40nxp.c
> > om%7C029427bc9c16445fac6b08dd150bfd9e%7C686ea1d3bc2b4c6fa92cd9
> > 9c5c301635%7C0%7C0%7C638689863423758804%7CUnknown%7CTWFpbG
> > Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> > IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dos3YxVfbBU81
> > D8O4u%2BDD3wgdQ%2BLjbK5MWnaK15bWfvk%3D&reserved=3D0
> >
> > --
> > Philippe.
>
> Hi Philippe,
>
> Thanks for your feedback, I have uploaded my app to the following
link:
> https://github.com/whbo158/rt_latency
>
>
>
> I found the former email maybe not sent successfully, so sent it
again.
>
>
>
> Best Regards,
> Hongbo
