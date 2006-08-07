Subject: Re: [Xenomai-help] mlockall?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <40982.155.98.4.150.1154987920.squirrel@domain.hid>
References: <40982.155.98.4.150.1154987920.squirrel@domain.hid>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 00:11:00 +0200
Message-Id: <1154988660.21290.91.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-07 at 15:58 -0600, Brandt Erickson wrote:
> I had a program that ran fine under xenomai-2.1.2, but I just upgraded to
> xenomai-2.2.0 and when I try to run the program, I get:
> 
>   Xenomai: process memory not locked (missing mlockall?)
> 
> I saw this article (http://www.captain.at/xenomai-2.2.php) which says to
> just add:
> 
>   mlockall(MCL_CURRENT | MCL_FUTURE);
> 
> I tried just putting this in main, but I get compiler errors.  Is there a
> particular file I need to include to resolve this error or am I going
> about solving this wrong?  Thanks.

#include <sys/mman.h>

should do the trick.

> -Brandt
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



