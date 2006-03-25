Message-Id: <1143279446.13244.257499314@domain.hid>
From: "Alessandro Pittaluga" <xpit@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date: Sat, 25 Mar 2006 10:37:26 +0100
Subject: [Xenomai-help] gdb and heaps
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

When trying to access with gdb to variables allocated on a shared heap,
the following message is returned:
(gdb) print mypointer
$5 = (MYTYPE *) 0xb7dc4020
(gdb) print *mypointer
Cannot access memory at address 0xb7dc4020

All the applications (kernel and userland) are accessing correctly to
the  heap-allocated memory. 

Is this the expected behaviour or there's something wrong in my
installation?

Many Thanks
Alessandro
-- 
  Alessandro Pittaluga
  al.pittaluga@domain.hid

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/docs/quotes.html


