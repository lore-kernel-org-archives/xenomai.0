Message-ID: <2ff1a98a0806130809ga992aa9y7372fa061466ad7f@domain.hid>
Date: Fri, 13 Jun 2008 17:09:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28D9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28D9@domain.hid>
Subject: Re: [Xenomai-core] pSOS skin: bug in tm_ticks_to_date() and
	tm_date_to_ticks()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, Jun 13, 2008 at 4:18 PM, Markus Osterried
<markus.osterried@domain.hid> wrote:
> Hello,
>
> there is a bug in the pSOS kernel-space skin, calculating calendar time to
> ticks and vice versa.
> The file xenomai/ksrc/skins/psos+/tm.c should be fixed like this:

Have you tried Xenomai 2.4.4 ? It contains a fix in the same file.

-- 
 Gilles

