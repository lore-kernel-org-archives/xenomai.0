Message-ID: <4852908D.2020704@domain.hid>
Date: Fri, 13 Jun 2008 17:21:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28D9@domain.hid>
	<2ff1a98a0806130809ga992aa9y7372fa061466ad7f@domain.hid>
In-Reply-To: <2ff1a98a0806130809ga992aa9y7372fa061466ad7f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] pSOS skin: bug in tm_ticks_to_date()
	and	tm_date_to_ticks()
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Markus Osterried <markus.osterried@domain.hid>, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Fri, Jun 13, 2008 at 4:18 PM, Markus Osterried
> <markus.osterried@domain.hid> wrote:
>> Hello,
>>
>> there is a bug in the pSOS kernel-space skin, calculating calendar time to
>> ticks and vice versa.
>> The file xenomai/ksrc/skins/psos+/tm.c should be fixed like this:
> 
> Have you tried Xenomai 2.4.4 ? It contains a fix in the same file.
> 

Actually, my fix was wrong, it should have read:

	for (n = month - 1; n > 0; n--)
-		*count += tm_month_sizes[n];
+		*count += tm_month_sizes[n - 1];

The other hunk, which is an overflow issue has been fixed in SOLO recently, but
not merged back yet, so this still applies.

-- 
Philippe.

