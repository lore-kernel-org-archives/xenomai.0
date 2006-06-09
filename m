Message-ID: <44892EF4.4070402@domain.hid>
Date: Fri, 09 Jun 2006 10:19:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt-exec test tool on LKML
References: <44888B79.1010309@domain.hid>
In-Reply-To: <44888B79.1010309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Hi,
> 
> just stumbled over this (and before I forget again):
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114979411309740&w=2
> 
> Maybe of some interest for us as well (POSIX skin...).
>

Looking at this code, this reminds me that I need to work on providing 
the RT signal infrastructure so that the POSIX skin can leverage it for 
its own purpose without requiring a switch to secondary mode. 2.2 needs 
to be released first, but the latter has just gotten a priority boost.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

