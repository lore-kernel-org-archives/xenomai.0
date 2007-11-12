Message-ID: <fd6a47a90711121010k2fa1f393u10f3692f2a3b4bd7@domain.hid>
Date: Mon, 12 Nov 2007 19:10:38 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <4738945D.2030503@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53629_5127313.1194891038988"
References: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>
	<4738839E.8020203@domain.hid>
	<fd6a47a90711120911q34d2fba5w22683bd06598b150@domain.hid>
	<47388CA0.6070405@domain.hid>
	<fd6a47a90711120936m6c8eb691na49fae868b803470@domain.hid>
	<4738945D.2030503@domain.hid>
Subject: Re: [Xenomai-core] Long execution time inside
	__ipipe_unstall_iret_root()
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
Cc: Xenomai-core@domain.hid

------=_Part_53629_5127313.1194891038988
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Ouch, this shouldn't be allowed in user space! WBINVD is a privileged
> instruction. Do we leak privileges to user land??? Please check if your
> execution mode (privilege ring) is correct there.


No, I rather meant a kernel-mode program that was controlled from the user
space. Sorry for upsetting you.

But indeed, wbinvd is devastating if you can execute it, causing
> typically around 300 us latencies, at worst even milliseconds
> (cache-size and state dependent)!


If I recall correctly, some of the Linux AGP GART drivers use(d?) it.

This raises another interesting question: to what extent is the x86 actually
a viable and dependable realtime platform, with its SMI's and highly
uncontrollable caching architecture ? How would VT-based solutions compare ?
(BTW Intel should really have implemented a feature to use parts of the
cache as SRAM.)


Jeroen.

------=_Part_53629_5127313.1194891038988
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Ouch, this shouldn&#39;t be allowed in user space! WBINVD is a privileged<br>instruction. Do we leak privileges to user land??? Please check if your
<br>execution mode (privilege ring) is correct there.</blockquote><div><br>No, I rather meant a kernel-mode program that was controlled from the user space. Sorry for upsetting you.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
But indeed, wbinvd is devastating if you can execute it, causing<br>typically around 300 us latencies, at worst even milliseconds<br>(cache-size and state dependent)!</blockquote><div><br>If I recall correctly, some of the Linux AGP GART drivers use(d?) it.
<br><br>This raises another interesting question: to what extent is the x86 actually a viable and dependable realtime platform, with its SMI&#39;s and highly uncontrollable caching architecture ? How would VT-based solutions compare ? (BTW Intel should really have implemented a feature to use parts of the cache as SRAM.)
<br></div><br><div><br>Jeroen.<br><br></div></div>

------=_Part_53629_5127313.1194891038988--

