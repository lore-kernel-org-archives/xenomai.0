Message-ID: <482BE97E.2080305@domain.hid>
Date: Thu, 15 May 2008 09:42:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28A0@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28A0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] bug with tm_evevery()
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
To: Markus Osterried <markus.osterried@domain.hid>
Cc: Xenomai-core@domain.hid

Markus Osterried wrote:
> Hello,
>  
> there is a bug in the pSOS user-space skin, calling the wrong
> kernel-space function for tm_evevery().
> The file xenomai/src/skins/psos+/tm.c should be fixed like this:
>  
>  
> --- xenomai-2.4/src/skins/psos+/tm.c
> +++ xenomai-2.4/src/skins/psos+/tm.c
> @@ -71,7 +71,7 @@
>  
>  u_long tm_evevery(u_long ticks, u_long events, u_long *tmid_r)
>  {
> -       return XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evwhen, ticks,
> events, tmid_r);
> +       return XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evevery, ticks,
> events, tmid_r);
>  }
>  
>  u_long tm_getm(unsigned long long *ns_r) /* Xenomai extension. */
>  
>  

Merged, thanks.

-- 
Philippe.

