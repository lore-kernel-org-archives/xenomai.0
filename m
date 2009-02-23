Message-ID: <49A2DB32.2070200@domain.hid>
Date: Mon, 23 Feb 2009 18:21:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid> <49A29232.5060003@domain.hid>
In-Reply-To: <49A29232.5060003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Could anyone affected by the fs/buffer.c WARN_ON() message try at least one of
> the patches below? It is an attempt to fix the exception handling bugs both for
> x86_32 and x86_64.
> 
> TIA,
> 
> http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.27.19-x86-2.2-06.patch
> http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.28.7-x86-2.2-06.patch
> 

For 2.6.28.7-x86-2.2-06 on 32 bit, I can report that Roman's test no
longer triggers an oops or a warning.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

