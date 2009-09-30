From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <!&!AAAAAAAAAAAYAAAAAAAAACaegimMCbhAp3tFUXd5zLjCgAAAEAAAAPOW/cf+tUNCgHMr877hPbMBAAAAAA==@phiinnovations.com>
References: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
	<20090923175232.AF318832E864@domain.hid>
	<!&!AAAAAAAAAAAYAAAAAAAAACaegimMCbhAp3tFUXd5zLjCgAAAEAAAAPOW/cf+tUNCgHMr877hPbMBAAAAAA==@phiinnovations.com>
Date: Wed, 30 Sep 2009 10:46:12 +0200
Message-Id: <20090930084612.5E9E0832E408@domain.hid>
Subject: Re: [Xenomai-help] Realtime data processing + VGA display
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Dear "Flavio de Castro Alves Filho",

In message <!&!AAAAAAAAAAAYAAAAAAAAACaegimMCbhAp3tFUXd5zLjCgAAAEAAAAPOW/cf+tUNCgHMr877hPbMBAAAAAA==@phiinnovations.com> you wrote:
> 
> In this case, which is a nice library for HMI to use with real-time
> software?

Obviously this depends on your requirements, and available system
resources. If you are running a full-fledged x86/x86_64 system with
CPU clocks of N GHz and gigabytes of RAM and big external storage you
can use any solution you like - Qt, Gnome, GTK, ...

If you are on an embedded system with restricted CPU performance
and/or RAM size you may find X11 based solutions to be too fat, so
you might want to look into QtCore, DirectFB/GTK, or maybe even
Nano-X. But there are tons of other solutions for more specialized
applications, so you really have to check your requirements.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
What the gods would destroy they first submit to  an  IEEE  standards
committee.

