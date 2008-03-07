Message-ID: <d3f72a390803070847w1a5152d1o9d316d8ada2cd12c@domain.hid>
Date: Fri, 7 Mar 2008 17:47:26 +0100
From: "axel axel" <softaxel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2071_9459335.1204908446143"
Subject: [Xenomai-core] ERROR ON COMPILING TRUNK XENOMAI
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_2071_9459335.1204908446143
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i'm compiling xenomai trunk with the gcc 3.4.3 for ARM.

I have the following error:

thread.c: In function `pse51_thread_init':
thread.c:285: error: `_CS_GNU_LIBPTHREAD_VERSION' undeclared (first use in
this function)
thread.c:285: error: (Each undeclared identifier is reported only once
thread.c:285: error: for each function it appears in.)
make[3]: *** [libpthread_rt_la-thread.lo] Error 1
make[2]: *** [all-recursive] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all-recursive] Error 1

What do you think about this?


Roberto Bielli

------=_Part_2071_9459335.1204908446143
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br><br>i&#39;m compiling xenomai trunk with the gcc 3.4.3 for ARM.<br><br>I have the following error:<br><br><span style="font-weight: bold;">thread.c: In function `pse51_thread_init&#39;:</span><br style="font-weight: bold;">
<span style="font-weight: bold;">thread.c:285: error: `_CS_GNU_LIBPTHREAD_VERSION&#39; undeclared (first use in this function)</span><br style="font-weight: bold;"><span style="font-weight: bold;">thread.c:285: error: (Each undeclared identifier is reported only once</span><br style="font-weight: bold;">
<span style="font-weight: bold;">thread.c:285: error: for each function it appears in.)</span><br style="font-weight: bold;"><span style="font-weight: bold;">make[3]: *** [libpthread_rt_la-thread.lo] Error 1</span><br style="font-weight: bold;">
<span style="font-weight: bold;">make[2]: *** [all-recursive] Error 1</span><br style="font-weight: bold;"><span style="font-weight: bold;">make[1]: *** [all-recursive] Error 1</span><br style="font-weight: bold;"><span style="font-weight: bold;">make: *** [all-recursive] Error 1</span><br>
<br>What do you think about this?<br><br><br>Roberto Bielli<br>

------=_Part_2071_9459335.1204908446143--

