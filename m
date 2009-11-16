Message-ID: <4B0147E1.7050102@domain.hid>
Date: Mon, 16 Nov 2009 13:38:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091020113724.9069.23594.stgit@domain.hid>	
	<20091020113726.9069.95593.stgit@domain.hid>	
	<1256082066.2862.178.camel@domain.hid>
	<4AE0395F.1010800@domain.hid>	 <4AFAB527.5050503@domain.hid>
	<1258306730.2348.96.camel@domain.hid>
In-Reply-To: <1258306730.2348.96.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 9/9] nucleus: Include all heaps in
	statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe Gerum wrote:
> ...
> I would rather pick your suggestion to introduce a display-oriented name
> we could call a label instead, to make clear that we are only dealing
> with pretty-printing in /proc.
> 
> I.e.
> 
> - xnheap_init() remains unchanged
> - xnheap_set_label(fmt, args...) is introduced
> 

OK, will take this route!

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

