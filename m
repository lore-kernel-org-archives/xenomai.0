Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C3E0A0.4060604@domain.hid>
References: <44C3CF5C.3010806@domain.hid> <44C3D581.1010101@domain.hid>
	<44C3E0A0.4060604@domain.hid>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 23:25:32 +0200
Message-Id: <1153689932.8053.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sun, 2006-07-23 at 22:48 +0200, Hannes Mayer wrote:
> Jan Kiszka wrote:
> > Hannes Mayer wrote:
> >> Hi all!
> >>
> >> Subject basically says it.
> >>
> >> I'm trying to do this:
> >> err = rt_intr_create(&intr_desc, "parint", PARPORTINT, I_PROPAGATE);
> >> in main() before spawning an RT tasks, but it fails with ENOSYS.
> >> Xeno2.2, 2.4.32
> >>
> >> Any enlightenment very much appreciated!
> > 
> > CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.
> 
> Yeah, works. Thanks! :-)
> 
> What's the reason for defaulting to off ?
> Force users to write RTDM stuff ?

This gives a strong hint about what would be a good design decision when
crafting a device driver over Xenomai: i.e. use RTDM.

> 
> Tanti saluti,
> Hannes.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



