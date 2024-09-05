Received: from sonic306-20.consmr.mail.ir2.yahoo.com (sonic306-20.consmr.mail.ir2.yahoo.com [77.238.176.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE318FC92
	for <xenomai@lists.linux.dev>; Thu,  5 Sep 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564196; cv=none; b=lwDN7nudhf++fEzGy2Jc/1t7g8UchUYmKnFM1dcEjHoOJo1E4F9YRUnLj/tboVPkWOiNym0Xlr6pxgzlWKtKvfRYYhbvOgF4zShyymko01U9YVe330G5YuE0f1qV8o5R1KL7PQ2EFpR+pOeFtuSfEw5djJg2V7KGjsNUAls9Q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564196; c=relaxed/simple;
	bh=M9Dge6ynTGm3hcD0uzAgQDoXJf4UVNWFxtI0ESW8fao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PhtnK5uadOoIHrl/mOODig9G9zgh4lFNgDMnDvocyCBmeFS5+7+V6oDZVM+1ZSLTjeVDNq/b4VXcCMXxIhYwUXrmGL7fgKC6xQ5MiuztqqorrvkCuYmyU2byyfscsVj+TPqUyB9q0izWBI0wbKsNyIlALm0rnRiE9l4P4P6vRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kcSfDkk+; arc=none smtp.client-ip=77.238.176.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kcSfDkk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725564187; bh=De6G4AxbysqcCySCxiMkwyKE4QJn/iVBJKhU4QISXQY=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=kcSfDkk+DJpzv+wkmnc3UXN0erAQAvAx3UYH2YqY8izoT1OX8fiM6vGOq1gPT6SMT0i2pd3+y5tohkcXOEkIaIWsrmzTFMPsRGd5pjwi1QA3YNY3ByDIDckLtOBoSN6aO+aLtsKB7jXJwLVgMajCuZ9ao9KHCevYzh9g2FH9sPcps2Bel5lV8DY93Z3ErNs7HbsHurMVYu167x9D9cQN9CskouPOj4O3urTydm+bYfWY3cgrpl2S7FF6wZWdB+Xny4LS19iq9pnK/XEqVJSE8rNvCmnhAFGr+1vd+f2UYSku9WneMSlUzKoncrRwZ+5Cz4k4j1OCwHj4KBFKC6A9ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725564187; bh=lz0Hk/Enzo78ZFCFSFA91NHyB8kT3hbZs76Sdlq2Ryg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MvwJ+aWu/kFiDP/Wf6VjrJDvstXvxG/Yw/zs39sNZotiEVbiGSApzEXAHN1B62AM44ew/8r22JIKfWDPcLi+G1f4q16b7b/jq2NDvHO5o4ECXOAICIIguZQKlxZfJ38vfbMCZQwl3LyxmPKXeQvFbYp5r6928mdPL0WXmx9Gu9IEqME+u2wPx0HIYKED2g+PRs9jmqH5GSHhhnp14baPyaG/t/VU4bLe4VDHBP4mZnxl1IGaSm3JVpQlTT8Q1LnlFWI19vyPq7DuC6dtWD9d+iGNmcNwr/WnZ5SnstVjMYkXWkdLxVlxX3UrlIsy0oKDyee5eEBxeRGbqmzjBGD6ig==
X-YMail-OSG: wwyXhbsVM1mkR8V9ZNXhgfINMhLdr_frDc8ra5O4fUUn1bwTY9z2aVLqnwzWRLU
 dwubGRxqOlh.dJnqijqKqWZ7UfSh9RJD36.LezKWoAfZc0RUKHqvLmciJe4yNnu67eNjWMYpAq8Z
 hoRtPizii.baLvg_1ZT3TPZvmYWJvqeqiWgoGwQAppzNs4pqKg8n7y6cgwztFqDh5_MMzuCSlMrr
 KJ3SdLRk2Xm_N5FEzR8f95Rz9RLxl_7NkbnUG83sy85dltLAFXvKjy1YWlQ9cuiPRF3UiejZa50Y
 .RQlevyloMURB5Na3P3u0_2Ht4wV.bJS4KEu3WXk_g8J6hkMuFf28ifbD1x4hXdU9L76IeA_ZAJH
 CaOknQ_48YmG3BnJ2BYUkC9xhAAOBwzROqfQf3rC8WbOBt6CngHqVKe9dH8IsJad2P3y5CyRrgZs
 EwBarPyaaqbVfXh.bJtu3e8qlf5ZLRXfC.F1GIS.1Jm2BAJpnhMNce4vQZgOKQ6D9MNOaDsX5YaD
 .SU7wmiOhykWum6.XiFGi8gHogoG0tceUe32DHFuqhE3nf0EC_avrv03We25mfBMi6buPiFSmwIe
 6Rc1JoAl3q.ADmq_UwPgQHVaCkresSdFGtXFsJhCCUufX400gakMWYJa7_UyDubhYBfMDpCRXuEW
 1SG.8hgDXExVkpmdS0zv5JC1tS0ff9.Llf3S0m7cmPKl5MqYmtpHSB6Fj_8GKpRiO7I0vlKtZrIL
 UFBjSFF_nPMvW2rAYPqmbofx1T6Ql1D22qnZDqmhFLGrLxW8wz7OqnSmc.eobK0IVCnoIls5juKl
 2AeregjME7C4_mwc.K1GrIyno51RsdO8bkLgxzs8kP250ydmQKvx55xr6epfVB3TaGhicslIeBkd
 JYJk5FE7RbjzB3zc9tnBID3tOkkBKgkXiowRVtNhZhaeZeSzxWSwdwkkmoiOLHiDMevXMWUTficc
 TYjrDcsqvgZsxm7dKNnFy3q8PnHo.8KbbxJQklwwtAKxtOtI9hHB.fXZWheEkn3HW9oajc_mF9_R
 g2hp5i08SZGTW.epFq.d7msdFUg1fW3xBzob6dl1S1Vbee7UNGVQpGa1C.2Ruw6rQPy4qW0mcr1O
 RQinF_IerRFcTWb6RIXeWOEM8YwpMIaenrr6HnkKbcEUrIZwTKxRwKgH5OG7sZK5FdK7svidSfKk
 Wt0l0BdcBO_M7.d6PbVzoeTRverVTm7xKBrMKy.560jLCkKKZAA8HY0_REgPDcHllIkoUH3.fph8
 M8G7EK52Vf4DlGNJVmFQCEHGz2.83H0baX0aD.OY0YLXeaP0bPGp5VbO7NfsnfpNlTKRnaFozRZA
 aJd67kZBGF9Dlgp5ac9uYVpkKOAdA.VyqVAX1cP_sMMujkyYg7_e1JfFu9btqFRzUsihnC5PpQde
 .l8gctq9YAddVMjJRaZF_0KWZWoxH6PMQVQd6523NfD7Ib79DXO.MY.6uQ1DBeWpDL9dLosF0Lk4
 qz85g8kqaTmDbstf4DChCn2ONvxekpbpWz4L2WGDguolG2wl6K.qqFr3g_NasytfqUG_rMAGvxzy
 tCWQ3ahf6Rnet2eKzRlfQBW6LJhOYBNwi0MgoAo.f5ZTRshCuixmTbGeGlOvglJPO33cZYgOQ4DA
 4koGwo0m5JLlZbvou8SQi4IHBxlRj4KVGASYaP.FlpIU7amXHYtJQ3IHGFOJaMiJoea3CjfwCv54
 diucDD3SpZcGyDcBRWHwfHtfwlFfC_UTNQL9EWIPT1IhU5XMWmHiXEwKEBTTyJ_unIRoP3ycRE6j
 RbNMojFhPUnhEPgesWwAwsY8rUXmJQ80TexIGTHl8adqFKloy4ktdIjaRL3tT2mhX8f2f8oHUxv8
 hJXFpmixEJNeiCOvCHkThtcfWrRPINrjt5fBmAGsyVPRovW5xmwCD5F2HGwsiqe9pO7NlcI9NwRT
 yLctznhIx2o4zvlM19qoUYi8IPSdLi7cIuQ80VxBWQSRSSdJ3bNn7lD1bwwrd5DMbGOCi0myiaK5
 MQ7xoHw.1dt69wMZ9P8hKH6CrbHC5ANg16Llr46ttgKNYz8DrNskxPyz.CRpzIdLjdiSxODK80Zr
 lEdom7GQLgwebS8vTON4TNdQIkO7FrNDFJQ79hL6KTPnSkKWEHzmJwvQ68Lyg0dy47RCm0bzYKAw
 CQJMuS61T.zwpswabX31N_JMBK2mQk3EckL9k6HthAPGzPqjbJTu50afc3ca1XTtQd4e.KAgD0Et
 xdAoXLf0x.bP.kdGlRkzxWPxr
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 2a770d99-84e1-4dc4-9abd-477c8350a2e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 5 Sep 2024 19:23:07 +0000
Received: by hermes--production-ir2-6664f499fc-ggmrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2ecd174fecc2f853f7d705dd4eb959f;
          Thu, 05 Sep 2024 19:02:47 +0000 (UTC)
Message-ID: <c4f28a37-cc51-481f-b15e-2b9272a46920@yahoo.com>
Date: Thu, 5 Sep 2024 21:02:45 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
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
 <867f2e49-3621-49fa-a9d7-83a8093cb224@yahoo.com>
 <1a0e0318-95e5-49e3-812d-aad59fa4c19d@siemens.com>
Content-Language: en-US, it
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <1a0e0318-95e5-49e3-812d-aad59fa4c19d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 04/09/24 18:18, Jan Kiszka wrote:
> On 04.09.24 11:55, Mauro S. wrote:
>> On 03/09/24 11:01, Mauro S. wrote:
>>> On 02/09/24 12:26, Jan Kiszka wrote:
>>>> On 02.09.24 09:08, Mauro S. wrote:
>>>>> On 30/08/24 14:00, Jan Kiszka wrote:
>>>>>> On 28.08.24 16:32, Mauro S. wrote:
>>>>>>> On 28/08/24 15:40, Jan Kiszka wrote:
>>>>>>>> On 28.08.24 15:05, Mauro S. wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I'm back after doing more tests also on real hardware.
>>>>>>>>>
>>>>>>>>> Here is a summary:
>>>>>>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto
>>>>>>>>> Dunfell
>>>>>>>>> (GCC 9.5.0)
>>>>>>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai
>>>>>>>>> 3.2.4,
>>>>>>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>>>>>>
>>>>>>>>> I confirm that the problem shows only with my own kernel + rootfs,
>>>>>>>>> both
>>>>>>>>> on QEMU and on real hardware.
>>>>>>>>> Other combinations:
>>>>>>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>>>>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>>>>>>> - my kernel + xenomai-image rootfs
>>>>>>>>> don't show the problem, both on QEMU and on real hardware.
>>>>>>>>>
>>>>>>>>> Furthermore, I compiled the xenomai-image kernel forcing the
>>>>>>>>> 5.4.255
>>>>>>>>> version and using my defconfig: the kernel became identical to
>>>>>>>>> mine,
>>>>>>>>> then I expected to see the problem using this kernel with my
>>>>>>>>> rootfs. But
>>>>>>>>> -surprise- the problem does NOT show.
>>>>>>>>>
>>>>>>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>>>>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>>>>>>> Then, could really the problem be triggered by the GCC compiler
>>>>>>>>> version
>>>>>>>>> used to build the kernel OR the rootfs?
>>>>>>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>>>>>>> problem, then seems that the problem shows only when using GCC
>>>>>>>>> 9.5.0 on
>>>>>>>>> both sides.
>>>>>>>>>
>>>>>>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>>>>>>
>>>>>>>>
>>>>>>>> One option. Did you already try switching to a different, likely
>>>>>>>> newer
>>>>>>>> toolchain while keeping the rest?
>>>>>>>>
>>>>>>>
>>>>>>> No, for the moment: I should port the whole custom meta layer (that
>>>>>>> contains kernel and xenomai recipes) to a recent Yocto version. This
>>>>>>> means that also other userspace components will change: would that
>>>>>>> influence our testing?
>>>>>>>
>>>>>>>> But it could also be that the compiler brings in some noise to a
>>>>>>>> rather
>>>>>>>> narrow race window, widening it so that it becomes much more
>>>>>>>> likely to
>>>>>>>> be hit.
>>>>>>>>
>>>>>>>>> I can share with you my rootfs and my kernel and the QEMU startup
>>>>>>>>> args,
>>>>>>>>> or other things that could help you, and I'm open to suggestions
>>>>>>>>> about
>>>>>>>>> other tests to do.
>>>>>>>>
>>>>>>>> Problem may be that we will have to be able to reproduce
>>>>>>>> variations of
>>>>>>>> both in order to try out instrumentations.
>>>>>>>
>>>>>>> Right, I overlooked this aspect.
>>>>>>>
>>>>>>>>
>>>>>>>> I'm also still puzzled that it takes both your self-built kernel and
>>>>>>>> userland to trigger the issue. We only have similar but not
>>>>>>>> identical
>>>>>>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is
>>>>>>>> worth to
>>>>>>>> compare the disassembly of lib/cobalt/internal.o...
>>>>>>>
>>>>>>> Yes, this really puzzles me too.
>>>>>>> Attached the disassembly (obtained with objdump -dSlf) of the two
>>>>>>> libcobalt.so.2.0.0, with the two libraries too.
>>>>>>>
>>>>>>
>>>>>> There seems to be a difference between the two toolchains in the
>>>>>> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
>>>>>> include/xeno_config.h?
>>>>>>
>>>>>
>>>>> Yes sure.
>>>>>
>>>>> GCC 9.5.0:
>>>>> #define CONFIG_XENO_TLS_MODEL "initial-exec"
>>>>>
>>>>> GCC 12.2.0:
>>>>> #define CONFIG_XENO_TLS_MODEL "global-dynamic"
>>>>> (I got this from build/tmp/schroot-overlay/isar-builder-.... in
>>>>> xenomai-images build)
>>>>>
>>>>> For completeness of information, in my Xenomai recipe I have the
>>>>> following configuration flags
>>>>>
>>>>>     --with-core=cobalt --enable-smp --enable-pshared
>>>>> --enable-debug=symbols
>>>>>
>>>>
>>>> OK, and does the issue disappear with your setup when you add
>>>> --enable-dlopen-libs?
>>>>
>>>
>>> I added --enable-dlopen-libs to the recipe (rebuilding the rootfs and
>>> the toolcain and recompiling the test application with the new
>>> toolchain), but the problem still happen. Maybe it takes a bit more
>>> time (about 30 minutes) but it happens.
>>>
>>>> But it still did no make it appear on my setup when I removed it. We
>>>> might be unlucky that there are multiple parameters with the right value
>>>> needed.
>>>>
>>>
>>> Yes, probably we are unlucky.
>>>
>>> Anyway, the whole config flags passed by Yocto to Xenomai lib's
>>> configure is:
>>>
>>> --build=x86_64-linux --host=x86_64-smitec2-linux
>>> --target=x86_64-smitec2-linux --prefix=/usr --exec_prefix=/usr
>>> --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec
>>> --datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com
>>> --localstatedir=/var --libdir=/usr/lib
>>> --includedir=/usr/include/xenomai --oldincludedir=/usr/include
>>> --infodir=/usr/share/info --mandir=/usr/share/man
>>> --disable-silent-rules
>>> --with-libtool-sysroot=/opt/yocto/dunfell-x86_64/build-/tmp/work/corei7-64-poky-linux/xenomai/3.2.3-r1/recipe-sysroot --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols --enable-dlopen-libs --disable-static
>>>
>>> Thanks, regards
>>>
>>
>> Hi all,
>>
>> I made a "minimal" Yocto setup that allows to build an image which in
>> Qemu shows the problem.
>>
>> Yocto image is built into a docker container, to allow the maximum
>> reproducibility. Test application is compiled by the SDK generated from
>> the same Yocto.
>>
>> If it could be useful to reproduce on your side the problem, I can share
>> the Yocto setup, and the Qemu start script to run the image.
> 
> Sure - provided you used kas ;)
> (just joking, I can translate myself)
> 

Sorry, I was in a rush, I had no time to arrange a kas setup :-)
But I would have liked to do it.

I'm sending you all the information privately.

Thank you

-- 
Mauro S.

