MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18417.53680.5061.752392@domain.hid>
Date: Tue, 1 Apr 2008 08:09:52 +0200
In-Reply-To: <f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
	<18417.28104.771421.524613@domain.hid>
	<f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <levesquev@domain.hid>
Cc: xenomai@xenomai.org

Vincent Levesque wrote:
 > Thanks for the tip. I tried and did indeed get error messages. Unfortunately
 > I haven't been able to redirect these errors to a file or to find any
 > reference to them in /var/log/. The best I could do was to take a picture of
 > the screen: http://www.cim.mcgill.ca/~vleves/oops.jpg<http://www.cim.mcgill.ca/%7Evleves/oops.jpg>.
 > Please let me know if I can do anything else.

At first sight, it looks like you have the same issue with kmap_atomic
as Tomas. Could you try and increase resolution so that we get the
beginning of the oops ? Enable "Video mode selection support" in
"Console display driver support" menu, then pass something like
vga=0x0F01 on kernel command line. Also enable frame pointers in the
kernel if they are disabled.

-- 


					    Gilles.

