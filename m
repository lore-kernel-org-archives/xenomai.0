From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 14:51:50 -0500
References: <200706071357.12212.ngustavson@domain.hid>
	<1181244856.4998.133.camel@domain.hid>
	<200706071446.10731.ngustavson@domain.hid>
In-Reply-To: <200706071446.10731.ngustavson@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071451.50393.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe
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
Cc: xenomai@xenomai.org

from: man:pipe(7)
If all file descriptors referring to the write end of a pipe have been closed, 
then an attempt to read(2) from the pipe will see end-of-file 

well there ya go, when all else fails read the manual

thx again,
NZG


