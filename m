From: Bernhard Walle <bernhard.walle@domain.hid>
Date: Tue, 8 Aug 2006 00:31:40 +0200
Message-ID: <cjrkq3-0ca.ln1@domain.hid>
References: <40982.155.98.4.150.1154987920.squirrel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: mlockall?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

"Brandt Erickson" <brandt@domain.hid> [2006-08-07]:
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

man mlockall


Regards,
  Bernhard
-- 
Faulheit ist die Angewohnheit, sich auszuruhen, bevor man müde ist.  
	-- (unbekannt)


