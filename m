Message-ID: <20051125093348.40193.qmail@domain.hid>
Date: Fri, 25 Nov 2005 01:33:48 -0800 (PST)
From: Cedric Herreman <glocker50@domain.hid>
Subject: Re: [Xenomai-help] 2.6 kernel module with math functions
In-Reply-To: <E1Ed69H-0002kJ-J2@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1167556237-1132911228=:38466"
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--0-1167556237-1132911228=:38466
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

OK,
  
  I made an extra math module, copying some of the source code from newlib for the functions i needed. It works.
  
  Another question : if i create an application (in stead of kernel module) that starts a real time thread. Can i then use math functions inside the real time running part ?
  
  In the latency example, the sqrt function is used for displaying the results of the latency test.  This is outside the real time task. Is it possible to use this call in the real time function ? Or any other library function (that is not performing system calls) ?
  
  Cedric.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: Cedric Herreman wrote:
 > Hello,
 >  
 > I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6. I used some basic math functions in the original module. This is posing problems for me now.
 >  
 >  In the module source i include . I add -I/usr/include to the compiler flags and also "-ffast-math -mhard-float".
 >  
 >  If i compile this, i get warnings about double definitions of "__attribute_pure__" and "__attribute_used__".
 >  
 >  If i insert the kernel module, i get an error message :
 > "Xenomai: Invalid use of FPU in Xenomai context at " + probably the address of the instruction where the math function is called.
 >  
 >  Can anyone give me a hint ? Thanks.

You can only use floating point operations from real-time threads
contexts, not from module initialization and finalization routines, and
you have to signal Xenomai, when creating kernel space real-time
threads, that the thread will be allowed to use FPU. For the RTAI skin,
this is what the rt_task_init function 6th argument is for.

There is currently no math library module in Xenomai. So, the answer is
that you have to avoid math functions, or make a xeno_math module, the
way it is done in RTAI, i.e. using a math library such as the one made
by Sun and used by FreeBSD, or one among the various libcs available.
We once discussed this with Philippe, and a good candidate seemed to be
newlib at that time:

http://sourceware.org/newlib/

Looking at newlib sources, it seems that some of its contents come from
the Sun library too.

-- 


         Gilles Chanteperdrix.



		
---------------------------------
 Yahoo! Music Unlimited - Access over 1 million songs. Try it free.
--0-1167556237-1132911228=:38466
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">OK,<br>  <br>  I made an extra math module, copying some of the source code from newlib for the functions i needed. It works.<br>  <br>  Another question : if i create an application (in stead of kernel module) that starts a real time thread. Can i then use math functions inside the real time running part ?<br>  <br>  In the latency example, the sqrt function is used for displaying the results of the latency test.&nbsp; This is outside the real time task. Is it possible to use this call in the real time function ? Or any other library function (that is not performing system calls) ?<br>  <br>  Cedric.<br><br><b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Cedric Herreman wrote:<br> &gt; Hello,<br> &gt;  <br> &gt; I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6. I used some basic math functions in the
 original module. This is posing problems for me now.<br> &gt;  <br> &gt;  In the module source i include <math.h>. I add -I/usr/include to the compiler flags and also "-ffast-math -mhard-float".<br> &gt;  <br> &gt;  If i compile this, i get warnings about double definitions of "__attribute_pure__" and "__attribute_used__".<br> &gt;  <br> &gt;  If i insert the kernel module, i get an error message :<br> &gt; "Xenomai: Invalid use of FPU in Xenomai context at " + probably the address of the instruction where the math function is called.<br> &gt;  <br> &gt;  Can anyone give me a hint ? Thanks.<br><br>You can only use floating point operations from real-time threads<br>contexts, not from module initialization and finalization routines, and<br>you have to signal Xenomai, when creating kernel space real-time<br>threads, that the thread will be allowed to use FPU. For the RTAI skin,<br>this is what the rt_task_init function 6th argument is for.<br><br>There is currently no math library
 module in Xenomai. So, the answer is<br>that you have to avoid math functions, or make a xeno_math module, the<br>way it is done in RTAI, i.e. using a math library such as the one made<br>by Sun and used by FreeBSD, or one among the various libcs available.<br>We once discussed this with Philippe, and a good candidate seemed to be<br>newlib at that time:<br><br>http://sourceware.org/newlib/<br><br>Looking at newlib sources, it seems that some of its contents come from<br>the Sun library too.<br><br>-- <br><br><br>         Gilles Chanteperdrix.<br></math.h></blockquote><br></div><p>
		<hr size=1> <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=36035/*http://music.yahoo.com/unlimited/">Yahoo! Music Unlimited - Access over 1 million songs. Try it free.</a>
--0-1167556237-1132911228=:38466--

