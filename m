From: Ulrich Schwab <schwab@domain.hid>
Date: Mon, 31 Oct 2005 14:53:13 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510311453.14159.schwab@domain.hid>
Subject: [Xenomai-help] pthread_attr_setfp_np needed in user space apps ?
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

I am in the progress of porting an application from RTLinux to Xenomai-2.0
While compiling for a user space RT program with the posix skin I get
the following warning:

warning: implicit declaration of function `pthread_attr_setfp_np'

is this call NOT needed in an user space app   ?

It is there in the sources, but does not seem to be exported to a user space 
RT app.

Another point unclear to me is, how are printf's handled in RT user space 
apps ?
Isn't the RT scheduling affected, when done in a RT critical context ?

Thanks, for any comments,
Ulrich Schwab

-- 
====================================================
  inmess GmbH
  Frankfurter Str. 74
  D - 64521 Gross-Gerau
  Phone: +49 6152 97790
  Fax  : +49 6152 977920
  mail : info@domain.hid
  web:   www.inmess.de
====================================================

