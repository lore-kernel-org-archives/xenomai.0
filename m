Message-ID: <4727107E.5040408@domain.hid>
Date: Tue, 30 Oct 2007 12:07:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b054e88e0710300348w27eec304hecd5dbed4e189b54@domain.hid>
In-Reply-To: <b054e88e0710300348w27eec304hecd5dbed4e189b54@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Efika board
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
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai@xenomai.org

Giammarco Zacheo wrote:
> Does anybody ever tried to port Xenomai on a Efika board?
> 
> http://www.genesippc.com/efika.php
> 
> It is a freescale powerpc based board, with some patches to make linux
> work on it. I have read some emails on the net talking about RTAI, so
> what about Xenomai?
>

Xenomai is known to work fine on mpc52xx-based boards. It was actually
the first powerpc hardware we ever supported (on an IceCube, at that time).

> Is is realistic that the adeos patch blindly work on the already patched kernel?
>

It is at least realistic on a DENX kernel, since this is our reference
tree for the powerpc arch, and all recent Adeos patches against the
powerpc/ tree support the lite5200b. If your kernel tree comes from some
other vendor/manufacturer, then, you may have some failed hunks to sort
out manually, but there should not be any showstopper.

> Thank you
> 
> Giammarco
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

