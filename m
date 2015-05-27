Message-ID: <55661E8E.1000300@xenomai.org>
Date: Wed, 27 May 2015 21:44:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <C9F8415089354E4FB76F4548B3515AF48CD382E9@edb0.wapice.localdomain>
 <C9F8415089354E4FB76F4548B3515AF48CD48B3E@edb1.wapice.localdomain>
In-Reply-To: <C9F8415089354E4FB76F4548B3515AF48CD48B3E@edb1.wapice.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] [PATCH] Backport for chained interrupt handling
 fix - Linux 3.1.10 PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/27/2015 04:19 PM, Jouko Haapaluoma wrote:

> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC8309 UNIC2CORE
> Modules linked in: flx_frs rtl2_prot rtvlan rtnetproxy rt_loopback rtpacket rtudp rt_ucc_geth rtipv4 rtnet
> NIP: 00000000 LR: c0060df0 CTR: 00000000

For some reason, the IRQ log syncer runs a NULL handler. You should try
understanding which IRQ is involved, and why this happens. At first
glance, I don't see any issue related to masking.

This might be the consequence of a domain mismatch. A related bug was
fixed a few months ago, you should at least check the IRQ log syncer in
the legacy pipeline code for this issue:
http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.18&id=3a71c688d0e33c2e1bbe3eee8cce898419043cac

I can't elaborate more, since this legacy code is pretty old and a lot
of context would need to be refreshed to discuss this properly. Hectic
schedule on my end prevents this unfortunately.

-- 
Philippe.

