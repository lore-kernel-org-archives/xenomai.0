Message-ID: <92812.74331.qm@domain.hid>
Date: Thu, 18 Feb 2010 06:15:36 -0800 (PST)
From: Guvenc Gulce <gulceg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] XDDP / IDDP Protocol Documentation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi 
Starting with Xenomai 2.5.x, there are couple of protocols which can be used by the rt threads for IPC 
purposes. I am playing with the xddp protocol. Apart from the examples in xenomai source tree and an 
e-mail from Philippe in xenomai-core mailing list, I couldnt find any further documentation. Do I overlook 
smt here ? Are there any other pointers which document these protocols with further details ?

The API is actually Posix - Socket based so the usage is pretty straightforward but it would be nice 
to have a list of accepted parameters for setsockopt call and what they are doing and maybe the accepted 
values of "flags" parameter which can be used for example with recvfrom() call ? It would be more comfortable 
then digging in the xenomai source code.

And in order to ask a particular question:

Any idea how to make recvfrom() call non-blocking in xddp context ? seems to be blocking per default.

Thanks & Regards

Guvenc


      

