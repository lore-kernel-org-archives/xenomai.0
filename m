From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46AF5F1E.7030009@domain.hid>
References: <46AF5F1E.7030009@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Jul 2007 18:26:57 +0200
Message-Id: <1185899217.6611.246.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] 2.4-rc1: modular nucleus cannot be	unloaded
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-07-31 at 18:11 +0200, Jan Kiszka wrote:
> Already a plain command sequence causes this problem:
> 
> # modprobe xeno_nucleus
> # rmmod xeno_nucleus
> rmmod: xeno_nucleus: Resource temporarily unavailable
> 
> Can anyone confirm?

Cannot reproduce it here. However, I got another report saying that
/proc/xenomai/stat would return -ENOMEM. Cannot reproduce it here
either, though, but it does happen on the other site.

>  This is unfortunately only a secondary issue that I
> came across while hunting more severe problems of my colleagues, ie. I
> don't have the time to look into detail ATM.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



