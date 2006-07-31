From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.60695.176599.493100@domain.hid>
Date: Mon, 31 Jul 2006 13:44:23 +0200
Subject: Re: [Xenomai-help] configuration scripts doesn't work
In-Reply-To: <e325d110607310304pac72cf3pad25cec643be0edf@domain.hid>
References: <e325d110607310304pac72cf3pad25cec643be0edf@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > ./configure --enable-x86-sep --enable-x86-tsc
 > 
 > Xenomai: incompatible feature set
 > (required="sep tsc", present="sep", missing="tsc").
 > 
 > https://mail.gna.org/public/xenomai-help/2006-04/msg00198.html
 > 
 > I managed to fix it by following the same way.. can someone fix it in
 > the trunk or next distribution please.

As explained in the mail you have found, there is nothing to be fixed in
Xenomai sources. What need to be fixed is the flags you passed to
configure.

-- 


					    Gilles Chanteperdrix.

