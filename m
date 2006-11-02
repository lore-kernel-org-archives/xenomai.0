From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Simulator
Date: Thu, 2 Nov 2006 17:17:31 +0100
References: <200611021453.54463.s.zimmermann@domain.hid>
In-Reply-To: <200611021453.54463.s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021717.31758.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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

Am Donnerstag, 2. November 2006 14:53 schrieb Stephan Zimmermann:
> Hi, I am actually trying to set up the Simulator, which turns out to be not
> so easy...
>
<..>
> But calling
> 	"gcic -I/usr/xenomai/include -g -c main.cpp "
> leads to :

Does your C++ programm compile cleanly under gcc-2.95? If not, you are out of 
luck, as the simulator was developped under gcc-2.95.

As far as I know, porting it to a newer version would be a considerable 
effort. I think Gilles mentioned some problems in a earlier mail some months 
ago.

Best regards

-- 
Niklaus Giger

