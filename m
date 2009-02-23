Message-ID: <49A29232.5060003@domain.hid>
Date: Mon, 23 Feb 2009 13:10:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid>
In-Reply-To: <499EBF45.900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


Could anyone affected by the fs/buffer.c WARN_ON() message try at least one of
the patches below? It is an attempt to fix the exception handling bugs both for
x86_32 and x86_64.

TIA,

http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.27.19-x86-2.2-06.patch
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.28.7-x86-2.2-06.patch


-- 
Philippe.

