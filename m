Message-ID: <45756F92.6060001@domain.hid>
Date: Tue, 05 Dec 2006 14:09:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>	<20061127125419.3852edd9.benjamin.zores@domain.hid>	<456AD5EB.5040901@domain.hid>	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	<45754723.6050503@domain.hid>
	<20061205133516.b3b9ae85.benjamin.zores@domain.hid>
In-Reply-To: <20061205133516.b3b9ae85.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin Zores wrote:
> On Tue, 05 Dec 2006 11:17:07 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> I have now a preliminary patch for adeos-ipipe-2.6.19-ppc-1.5-00. The 
>> porting was rather straight-forward, as the ppc tree does not use the 
>> new "genirq" interface, in contrast to the powerpc tree (that's what you 
>> have realized as well).
> 
> Well, i guess the old "ppc" arch is bound to die sooner or later.
> New developments should always be done against "powerpc" arch imho.

Well, the powerpc tree is still highly experimental and only a few 
embedded boards are already supported. I guess it will take a long time 
before the ppc tree finally gets buried, especially because porting is 
not really trivial (due to OF, IRQ layer, etc.),

>> Therefore the port of the powerpc tree should be based on Philippe's new 
>> adeos-ipipe-2.6.19-i386-1.6-00. Unfortunately, I still do not have a 
>> board by hand supported by the powerpc tree.
> 
> I haven't had much much time investigating the problem till now.
> But from what i've seen from Philippe's splitted patches, many of them
> that were supposed to be generic (i.e. don't have i386 in their name)
> still have references to x86 changes.
> Is it a normal behavior ?

Unfortunately, "generic" applies only to the Linux part. I realized, 
that the new IPIPE support for the genirqs requires even more 
arch-specific modifications than the old interface :-( on PowerPC.

> 
> (about dev board, no one's developing on lite5200 or sth like that ?)

Have you ever worked with that board under 2.6? It is not even well 
supported by the old ppc tree and you need patches, which are available 
somewhere but still require extra tweaking. I have such a board on my 
table and if I'm lucky, I will get U-Boot with OF support up and booting 
Linux PowerPC 2.6.19 ... but I need plenty of luck.

Wolfgang.


