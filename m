From: Nicola Pezzotti <nicola17@domain.hid>
Date: Mon, 11 Sep 2006 00:32:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609110032.53059.nicola17@domain.hid>
Subject: [Xenomai-help] Another newbie problem
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

Here I'm with another newbie question...

Finally I have installed Xenomai 2.2 and all seems right. 

all testsuite go well but when I try to launch a demos I have the following 
errors:

"./latency: error while loading shared libraries: libnative.so.0: cannot open 
shared object file: No such file or directory"


I also try to resolve with this command:

"export LD_LIBRARY_PATH=/usr/xenomai/lib/:$LD_LIBRARY_PATH"

but I cannot resolve.

Can you give me some hint?

