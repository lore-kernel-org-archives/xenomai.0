Received: from sonic307-53.consmr.mail.ir2.yahoo.com (sonic307-53.consmr.mail.ir2.yahoo.com [87.248.110.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1814658C
	for <xenomai@lists.linux.dev>; Wed,  4 Sep 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444949; cv=none; b=HZBguL7jd6jo85wDSrM2/uBdh2RMOvA6vY6rOulWc1rYXY4C6vuZGbiQjEnN9m4e48hJgmcS75/kbQe8NXYZCzkx1zSafFipmvYRsZEebaUEJfjlHjtowZZvEEMY10xrp+zZn9qEpYIZFDzMM5r1J7x8EOOEHdfjrPw7kGgyBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444949; c=relaxed/simple;
	bh=FzG/1Px/PBJdtL6g+/2CSXWjM8HLeBx6rCstFSadsKQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WID4X5dmegX42AhCXQLWgj4UTSwtfriB9CgDxMR3rSgdPkvH55xkfyo5d0O7ZEW1wJ5LxdTye5jf/svFheadf399jvyXJX86XB0P6oznRSr3fOc+LbXQ1jg573l4933/HpzOCzbRFWpnzOqr8jdRKQ3y1PwEGcn6GwI4dCiJrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H803/MuD; arc=none smtp.client-ip=87.248.110.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H803/MuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725444945; bh=yX58M6/YXbx32rRk0MIudwYqHD0wPLXCnyOfluqjR84=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=H803/MuDCZnnYklrCqRJe4/A1OCgBsFFezr6WWebEXjfIaCMMMhGAWT8YqTaADIxKfMxm9okdVJ3MXTeBS9VebNRpAIXxcSozA7D9A4SB7ewfRUnA/8xUoo2ivYA32G48dyUnueWgRn9pm7MLM6IT3d82GyDhQHM5E6DLD2ETq7iD2U40QmrazhmWuD4e3SNuoQrQWGts8mXB4uL40xUqAqj7uzpIa98i+v/G6GrhwBhOTxKmaOJfa8Z7iPkOklHUJ0Abe48hi7itZBHwPXSzKdWU+PTIOeeVkCMJKCYmxAMKXyCN3slEqlpV38+/m5K0n1mzhbl933IG7ZDnHI9nA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725444945; bh=y6JivBuRSgSiOSuD42bWuCsPFtvdllYQHWBrHuvaK0O=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Y4U8thHPz9iavjhaHtKkknev0iLft4HwLkRI52SdR/+WVOgEpEEG4BAJiXlhDxBcx7DfP3XE9HCOnrUzEvOShkuvqmSUDvOQyZtR8orHudg4TAi13WQ/xrWcKIyoAeAO95tANSwAg4MVKVqyBIb95JPdsXdKLrR4Dgly1032/H2D6HTL6sBQxMpkISkpUHoziJVELyxw58iz8lQ+ezo0AGtoZJ19hOGZ7NX5Lq8/y9vQ9pQwr+mq0pDpTpzwz1jiW/2RniH72tNPc7z7ea532ZqN8GppovaVaX5dL6idkSPiNYPXBvCGDherdFhJnvjfzPjkYKN0FfHfB/Y9crRf+w==
X-YMail-OSG: aDSV6hkVM1no7wSSnVuGiwzyRdjNIZVuB8eWLVgdufhVmV3fFawkio3mhLuon1H
 N7rLKMH1Xh5fvm7dbgf0gFn9Q_CYhHAkvYPraHjypxVeGG4mCdxFdNbnH1vTJkWulAo_TcZL9r2x
 NQFKSLz_BeD4r8EjmK5P9nmeqb2FXZhTZTpgGTRNHggQ43GlLnFcL3eSkRtC9BlFlJtaPbMAp77R
 LmrbYDN_tQtceyDfRKm4sqGn8qtA9kuoAsAvGQaNqrqHOfJFJWzo17N4jBQycwM.qwqHgbQVFti3
 XKFrBGO1LZNDlLHq1jQi0zuipMC9K_GgXOhIPrOEPxJn_iAFAAU6X65gIfFaTCpEzC7lzNChcolu
 WOhvM30xLbfQseYPG0oTrow1iDq9n4d0ntOgaZvWx7Sh2oNLp6BJRs1K6IlmhtL7k0JNFu3b.jL6
 dZmCAxYBEQVkMQkHnn2iLmz62FQON_gfdEJ1UaG.6cJDPKqnMV6NpMuN7iedMtyBpAX_sqzBVxLE
 QcIGSFNscFRR80wSH8PfkbYEgdRbLp4CuVi8EpFzHszl_StEOMAHghmZgjAQ8IftxCy3_3wELAgI
 7XXb29y2SmRr_wEZ.4HRgYwGC_TZ7CtUWLz4BczJjcHMXL124ZSyJ6pMEJmE4LzgiR19aMDuqzhi
 nfY9fY7LhnKp6.lzLGcmLxvga0HcKb1ZUmiQcQDmHu_W6_jdhnqapWi6Aa.mrPgCrlXIQqpJ8vLI
 GudqSoSZhywf25GJe7dlykXweLj7rgKXeschT8ivjho204mdaqCqtB5Dom3c9QD7bcGXeT46e3y2
 vu6SDJ8w.AcusFUaRNENvhtFOHgbdgwXyJc.mjuYm0MUoaeWaYUp1_br59B.1qMc7sY2GMeyorui
 mY9BcMDIU1mDSJF3DA40kg87WYtNQp1yyZoQSEh2w.f8BuoKF_.4S3o6ycMHXOh7T9LhLCXLNrsg
 LgruebUVLrVCOTL3Cwc41Ph3pa5b5y59FlPRSBCOD2jhMSczwzeEZQaBAngZF6UsOZcRHVvF3adW
 2M8av6RxH3Bmxcmj9QbstAUhnnJHYWaRnMgBozohmNnzzfSvWcVc774izB5efSfSd5iHUrby0AKq
 dUahDm2P3ZZJHEfqH878RWGkmXBVxOtpbO.Qpb5ULe9D7mBiyGnyano7Qbx5_QOLGwXRvuz4Auyp
 BrRvDGPQAf6iQUWOC.VQlJ7_zq5ozlYV1fAl_DIpXTceJIS8uA_yHR9saLnYVqTdP3P8qSIqMBF3
 dxfQeliN677St.j1GA89VyK0KepSz9EjrfX51J8HWQIu8mh1dIrcnc7MrDOnHa7A9vOZI6yQc8MM
 nBDZasn96waKg81DoD4ptmi1L6vQaAbt60Q2f9GJ.1mA425x1OB5ob97bOqjUKVvuUOZXbFIV4AC
 jkZuRzOg10Rl08uTwXLw80qZhZhZLPtFHQVOSDXfcGKbBtYfCH0xI9cxLlXz2poy9Ok65aiQypv5
 U1bKNn1KcGPrWOk2Sqe8NkgW_bsjCq6IpcoBJP9xrZcgxyjpkbNiOaoFa9RV2NRjPX5o_q4JcfbA
 wMYKJ0IGkEaEZ7Cg5Pm.Qo92JkZXBuPvGeh09eTVSLt30zVAiTyf6D_iTY76Nbs1xkVOfxBrkQkX
 vAAsAZs.McGTyLx5xVVHhoUUkeatbYiPV4177f1EpM0QEaI_4F20Tf5GYQTILww3pnThxh.jPwyg
 1X6Fknx68.knpYxkTc1H_9uGViADuL4aLh6oMyVMh8ie.Q4qEvCo52is.INQD2uvQowd..sQaAdC
 OWhKU3wCHn8D.BXYkMLwOxaNHb14_ZgRVTItrYwfCyZJ5sNvkPOzPk74Z7zYR2scjavycRQu.zv7
 6CLq6MeEl98SyRLl5hyVlfQKM.l67eBtEOyfjfXqgsqm.nSO.7CdtA68rgih5tt3jGC1cNOL_g9J
 AlPtKnsA3pViqn34DzXvUTx26zxuT1BztLR8xr7W1VlXGQjIDXpfu.9igy_NjD6v1ia8QdoDqRxx
 kTkYKrwqXuqOq9n6XfZ04vGYYtd_bug7o_s_Zlgs7P0DCFIK6p1paSaE1l4RPj25e2a3xhgZu2zq
 oUgZbSZtTA6D_vSNb0CbmnICWTC6fnxUsLEiLN.OoCBhiJSZ26RSKofg.QbfroyxnBOknNhiw9L4
 P00CBSFIqsEQZqnKgj.v2TJiq2gioF2KOwpibwwObl3VfKL1fzQ7STorS81wBxRyq0hvM57CVeIA
 pzV9qK2xx3w--
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 73197938-60f5-45cd-bf2f-cbd1cdc01b76
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 4 Sep 2024 10:15:45 +0000
Received: by hermes--production-ir2-6664f499fc-stbn9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b89f6af31b80aab5e6dd067fb3d81f72;
          Wed, 04 Sep 2024 09:55:28 +0000 (UTC)
Message-ID: <867f2e49-3621-49fa-a9d7-83a8093cb224@yahoo.com>
Date: Wed, 4 Sep 2024 11:55:26 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: "Mauro S." <mau.salvi@yahoo.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
 <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
 <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
 <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
 <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
 <f3493320-9f77-456c-9c57-1b35492ecac6@siemens.com>
 <4dbeb5b9-da91-4aa4-9cf2-06d6776effef@yahoo.com>
Content-Language: en-US, it
In-Reply-To: <4dbeb5b9-da91-4aa4-9cf2-06d6776effef@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 03/09/24 11:01, Mauro S. wrote:
> On 02/09/24 12:26, Jan Kiszka wrote:
>> On 02.09.24 09:08, Mauro S. wrote:
>>> On 30/08/24 14:00, Jan Kiszka wrote:
>>>> On 28.08.24 16:32, Mauro S. wrote:
>>>>> On 28/08/24 15:40, Jan Kiszka wrote:
>>>>>> On 28.08.24 15:05, Mauro S. wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm back after doing more tests also on real hardware.
>>>>>>>
>>>>>>> Here is a summary:
>>>>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto 
>>>>>>> Dunfell
>>>>>>> (GCC 9.5.0)
>>>>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 
>>>>>>> 3.2.4,
>>>>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>>>>
>>>>>>> I confirm that the problem shows only with my own kernel + rootfs,
>>>>>>> both
>>>>>>> on QEMU and on real hardware.
>>>>>>> Other combinations:
>>>>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>>>>> - my kernel + xenomai-image rootfs
>>>>>>> don't show the problem, both on QEMU and on real hardware.
>>>>>>>
>>>>>>> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
>>>>>>> version and using my defconfig: the kernel became identical to mine,
>>>>>>> then I expected to see the problem using this kernel with my
>>>>>>> rootfs. But
>>>>>>> -surprise- the problem does NOT show.
>>>>>>>
>>>>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>>>>> Then, could really the problem be triggered by the GCC compiler
>>>>>>> version
>>>>>>> used to build the kernel OR the rootfs?
>>>>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>>>>> problem, then seems that the problem shows only when using GCC
>>>>>>> 9.5.0 on
>>>>>>> both sides.
>>>>>>>
>>>>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>>>>
>>>>>>
>>>>>> One option. Did you already try switching to a different, likely 
>>>>>> newer
>>>>>> toolchain while keeping the rest?
>>>>>>
>>>>>
>>>>> No, for the moment: I should port the whole custom meta layer (that
>>>>> contains kernel and xenomai recipes) to a recent Yocto version. This
>>>>> means that also other userspace components will change: would that
>>>>> influence our testing?
>>>>>
>>>>>> But it could also be that the compiler brings in some noise to a 
>>>>>> rather
>>>>>> narrow race window, widening it so that it becomes much more 
>>>>>> likely to
>>>>>> be hit.
>>>>>>
>>>>>>> I can share with you my rootfs and my kernel and the QEMU startup
>>>>>>> args,
>>>>>>> or other things that could help you, and I'm open to suggestions 
>>>>>>> about
>>>>>>> other tests to do.
>>>>>>
>>>>>> Problem may be that we will have to be able to reproduce 
>>>>>> variations of
>>>>>> both in order to try out instrumentations.
>>>>>
>>>>> Right, I overlooked this aspect.
>>>>>
>>>>>>
>>>>>> I'm also still puzzled that it takes both your self-built kernel and
>>>>>> userland to trigger the issue. We only have similar but not identical
>>>>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is 
>>>>>> worth to
>>>>>> compare the disassembly of lib/cobalt/internal.o...
>>>>>
>>>>> Yes, this really puzzles me too.
>>>>> Attached the disassembly (obtained with objdump -dSlf) of the two
>>>>> libcobalt.so.2.0.0, with the two libraries too.
>>>>>
>>>>
>>>> There seems to be a difference between the two toolchains in the
>>>> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
>>>> include/xeno_config.h?
>>>>
>>>
>>> Yes sure.
>>>
>>> GCC 9.5.0:
>>> #define CONFIG_XENO_TLS_MODEL "initial-exec"
>>>
>>> GCC 12.2.0:
>>> #define CONFIG_XENO_TLS_MODEL "global-dynamic"
>>> (I got this from build/tmp/schroot-overlay/isar-builder-.... in
>>> xenomai-images build)
>>>
>>> For completeness of information, in my Xenomai recipe I have the
>>> following configuration flags
>>>
>>>    --with-core=cobalt --enable-smp --enable-pshared 
>>> --enable-debug=symbols
>>>
>>
>> OK, and does the issue disappear with your setup when you add
>> --enable-dlopen-libs?
>>
> 
> I added --enable-dlopen-libs to the recipe (rebuilding the rootfs and 
> the toolcain and recompiling the test application with the new 
> toolchain), but the problem still happen. Maybe it takes a bit more time 
> (about 30 minutes) but it happens.
> 
>> But it still did no make it appear on my setup when I removed it. We
>> might be unlucky that there are multiple parameters with the right value
>> needed.
>>
> 
> Yes, probably we are unlucky.
> 
> Anyway, the whole config flags passed by Yocto to Xenomai lib's 
> configure is:
> 
> --build=x86_64-linux --host=x86_64-smitec2-linux 
> --target=x86_64-smitec2-linux --prefix=/usr --exec_prefix=/usr 
> --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec 
> --datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com 
> --localstatedir=/var --libdir=/usr/lib --includedir=/usr/include/xenomai 
> --oldincludedir=/usr/include --infodir=/usr/share/info 
> --mandir=/usr/share/man --disable-silent-rules 
> --with-libtool-sysroot=/opt/yocto/dunfell-x86_64/build-/tmp/work/corei7-64-poky-linux/xenomai/3.2.3-r1/recipe-sysroot --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols --enable-dlopen-libs --disable-static
> 
> Thanks, regards
> 

Hi all,

I made a "minimal" Yocto setup that allows to build an image which in 
Qemu shows the problem.

Yocto image is built into a docker container, to allow the maximum 
reproducibility. Test application is compiled by the SDK generated from 
the same Yocto.

If it could be useful to reproduce on your side the problem, I can share 
the Yocto setup, and the Qemu start script to run the image.

Thanks in advance, regards

-- 
Mauro S.

