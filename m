Message-ID: <184545.11821.qm@domain.hid>
Date: Thu, 12 May 2011 11:02:21 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] IDDP/XDDP File/Socket descriptors with select/epoll
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi
The Xenomai IPC Mechanisms IDDP and XDDP use the Posix Socket API.
Is it possible to monitor the returned file/socket descriptors of IDDP/XDDP
sockets using the select/epoll mechanisms ?

For example can we monitor the socket descriptors of IDDP Sockets using
the posix select and/or linux epoll mechanism if those sockets
are running in the context of two xenomai real time threads which are 
trying to communicate with each other over IDDP ?

Thanks & Regards

Guvenc 


