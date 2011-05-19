Date: Thu, 19 May 2011 15:40:58 +0800
From: "arethe.rtai" <arethe.rtai@domain.hid>
Message-ID: <201105191540561098802@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon027263767421_====="
Subject: [Xenomai-core] I solved the problem of the shared memory cannot be
	allocated in the user space
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core <Xenomai-core@domain.hid>


This is a multi-part message in MIME format.

--=====003_Dragon027263767421_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

HI all:
     I solved the problem of the shared memory cannot be allocated in the user space. 
Because the shared memory space are allocated from the kheap, but the kheap is not a mapped heap, i.e. its pages are not reserved.
I init the kheap by xnheap_init_mapped rather than xnheap_init. The problem is solved.
If there is a need, I can submit the patch to Xenomai.

Qin Chenggang

2011-05-19 



arethe.rtai 

--=====003_Dragon027263767421_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=us-ascii">
<META content="MSHTML 6.00.6000.17097" name=GENERATOR><LINK 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}" 
rel=stylesheet></HEAD>
<BODY style="FONT-SIZE: 10pt; MARGIN: 10px; FONT-FAMILY: verdana">
<DIV><FONT face=Verdana size=2>
<DIV><FONT color=#000080 size=2>HI all:</FONT></DIV>
<DIV><FONT color=#000080 size=2>&nbsp;&nbsp;&nbsp;&nbsp; I&nbsp;solved the 
problem of the shared memory cannot be allocated in the user space. 
</FONT></DIV>
<DIV><FONT color=#000080 size=2>Because the shared&nbsp;memory space are 
allocated from the kheap, but the kheap is not a mapped heap, i.e. its pages are 
not reserved.</FONT></DIV>
<DIV><FONT color=#000080>I init the kheap by xnheap_init_mapped rather than 
xnheap_init. The problem is solved.</FONT></DIV>
<DIV style="TEXT-INDENT: 2em"><FONT color=#000080>If there is a need, I can 
submit the patch to Xenomai.</FONT></DIV>
<DIV><FONT color=#000080></FONT>&nbsp;</DIV>
<DIV><FONT color=#000080>Qin Chenggang</FONT></DIV></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT face=Verdana color=#c0c0c0 size=2>2011-05-19 
</FONT></DIV><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT face=Verdana color=#c0c0c0 size=2><SPAN>arethe.rtai</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon027263767421_=====--


