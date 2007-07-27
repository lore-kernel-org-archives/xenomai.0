Message-ID: <2862c2c80707270211n37c56aen22655708661ccd17@domain.hid>
Date: Fri, 27 Jul 2007 17:11:42 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2464_13185399.1185527502282"
Subject: [Xenomai-help] clocktest - Segmentation Fault & Meaning of TOD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_2464_13185399.1185527502282
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I have grabbed the xenomai trunk and compiled the clocktest testsuite. I
have "Segmentation Fault" during the clocktest execution, thus, making the
following modification on the pthread_create by submitting the attrib:

        pthread_attr_t attr;

        pthread_attr_init(&attr);
        pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);

        per_cpu_data[i].first_round = 1;
        pthread_create(&per_cpu_data[i].thread, &attr, cpu_thread,
               (void *)(long)i);

I don't know wether I am doing correctly or this is a Bug.

By the way, I have no idea of the meaning of this testing, such as ToD
offset. Can anyone explain this? Is this for testing the clock percision by
checking the drifting? what's the different between real time clock and
monotonic clock?

== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0              54141.9           -0.141          0            0.0
Xenomai: POSIX: destroyed thread c0540320

Thanks

regards,
chun yeow

------=_Part_2464_13185399.1185527502282
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>I have grabbed the xenomai trunk and compiled the clocktest testsuite. I have &quot;Segmentation Fault&quot; during the clocktest execution, thus, making the following modification on the pthread_create by submitting the attrib:
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_t attr;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_init(&amp;attr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setstacksize(&amp;attr, PTHREAD_STACK_MIN);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; per_cpu_data[i].first_round = 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_create(&amp;per_cpu_data[i].thread,
<span style="color: rgb(204, 0, 0);"> &amp;attr,</span> cpu_thread,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(long)i);<br><br>I don&#39;t know wether I am doing correctly or this is a Bug.<br><br>By the way, I have no idea of the meaning of this testing, such as ToD offset. Can anyone explain this? Is this for testing the clock percision by checking the drifting? what&#39;s the different between real time clock and monotonic clock?
<br><br>== Tested clock: 0 (CLOCK_REALTIME)<br>CPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ToD offset [us] ToD drift [us/s]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warps max delta [us]<br>--- -------------------- ---------------- ---------- --------------<br>&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 54141.9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
0.141&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0<br>Xenomai: POSIX: destroyed thread c0540320<br><br>Thanks<br><br>regards,<br>chun yeow<br>

------=_Part_2464_13185399.1185527502282--

