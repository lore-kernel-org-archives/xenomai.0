Message-ID: <20100903085639.12173@domain.hid>
Date: Fri, 03 Sep 2010 08:56:39 -0400
From: "C Robinson" <starknight__@domain.hid>
Content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 60, Issue 2
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


Hi,

So the position I am in is still not knowing how to run the examples.   Atte=
mpting the command "sudo make  /home/<user name>/xenomai-2.5.4" from the dir=
ectory /usr/xenomai_egs/xenomai-head/examples/, results in the following err=
or (as mentioned previously):

----------------------------------------------------------------------------=
------------------------------------------------
xddp-echo.c: In function ?realtime_thread?:
xddp-echo.c:115: error: ?SOL_XDDP? undeclared (first use in this function)
xddp-echo.c:115: error: (Each undeclared identifier is reported only once
xddp-echo.c:115: error: for each function it appears in.)
xddp-echo.c:115: error: ?XDDP_POOLSZ? undeclared (first use in this function=
)
make[1]: *** [xddp-echo] Error 1
----------------------------------------------------------------------------=
-----------------------------------------------

and shortly afterwards ended with:

make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/xenomai_egs/xenomai-head/examples/posix'

How do I get around this error?  In addition, is it ok to use the default us=
er account. (or should a specific xenomai account be set up)

Trying to get up the man pages results in:

----------------------------------------------------------------------------=
-----------------------------------------------
clocktest man
The program 'clocktest' is currently not installed.  You can install it by t=
yping:
sudo apt-get install xenomai-runtime
----------------------------------------------------------------------------=
-----------------------------------------------
Is this because I installed the xenomai-runtime package manually via the Deb=
ian guideline ? (Synaptic shows this as being already installed, perhaps thi=
s is a result of the earlier problem?).


Thanks,
Charles

