Date: Mon, 4 Apr 2022 11:29:51 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <656392314.214549.1649064591209.JavaMail.zimbra@nod.at>
In-Reply-To: <87ilrqnjdp.fsf@xenomai.org>
References: <20220403144348.1775590-1-rpm@xenomai.org>
 <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
 <87ilrqnjdp.fsf@xenomai.org>
Subject: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
> These are the two remaining patches in the final series, ok for both?
>=20
> tick: irq_pipeline: fix proxying of a broadcast device
> x86: dovetail: reinstate I/O bitmap on user entry

I meant this patches;
[PATCH 1/4] sched: dovetail: pass thread-info bits to arch_dovetail_switch_=
finish()
[PATCH 2/4] ARM: dovetail: fix up arch_dovetail_switch_finish()
[PATCH 3/4] arm64: dovetail: fix up arch_dovetail_switch_finish()
[PATCH 4/4] x86: dovetail: reinstate I/O bitmap on out-of-band user entry

Where 4/4 got replaced by this v2 one.

I didn't look into "tick: irq_pipeline: fix proxying of a broadcast device"=
 but can later today.

BTW: Do you have a Patchwork instance for the Xenomai mailing list? I makes=
 dealing with patch
series so much easier.

Or even better, can we have Xenomai at lore.kernel.org? Then we can use b4.=
 :-)

Thanks,
//richard

