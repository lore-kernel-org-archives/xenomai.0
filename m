Message-ID: <OF7AA2B50F.2763501F-ONC125738A.0058C081-C125738A.00597EAF@philips.com>
From: "A.J.W. van Lievenoogen" <a.j.w.van.lievenoogen@domain.hid>
Date: Mon, 5 Nov 2007 17:21:42 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF919DFCB46118f9e8a93df938690918c4EBBF919DFCB4611"
Content-Disposition: inline
Subject: [Xenomai-help] calling posix functions in vxworks application
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

--0__=4EBBF919DFCB46118f9e8a93df938690918c4EBBF919DFCB4611
Content-type: text/plain; charset=US-ASCII


I'm trying to port a vxworks application to xenomai.
Some calls in this application are posix calls (which are supported by
vxworks)  for example the clock_gettime function.
This function in xenomai is implemented in the posix skin but not in the
vxworks skin.
Can I still somehow use these functions in the posix skin while I'm using
others in the VxWorks skin?

the only functions I mis from vxworks are  clock_gettime  and localtime_r
so if I can't use both skins simultaneously is there a way to work around
that for these functions?

regards,

Anne van Lievenoogen
--0__=4EBBF919DFCB46118f9e8a93df938690918c4EBBF919DFCB4611
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>I'm trying to port a vxworks application to xenomai. <br>
Some calls in this application are posix calls (which are supported by vxworks)  for example the clock_gettime function.<br>
This function in xenomai is implemented in the posix skin but not in the vxworks skin.<br>
Can I still somehow use these functions in the posix skin while I'm using others in the VxWorks skin?  <br>
<br>
the only functions I mis from vxworks are  clock_gettime  and localtime_r so if I can't use both skins simultaneously is there a way to work around that for these functions?<br>
<br>
regards,<br>
<br>
Anne van Lievenoogen<br>
</body></html>
--0__=4EBBF919DFCB46118f9e8a93df938690918c4EBBF919DFCB4611--


