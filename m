Message-ID: <20060612153100.61236.qmail@domain.hid>
Date: Mon, 12 Jun 2006 08:31:00 -0700 (PDT)
From: Cedric Herreman <glocker50@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-677057953-1150126260=:57594"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Compaq nc6120 timer frequency
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

--0-677057953-1150126260=:57594
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,

I have installed xenomai on my Compaq nc6120 portable. Everything seems to be working OK. There is only one issue :

When i create a periodic task, it runs with a higher period than expected (60 x). I have the impression that the ratio "ticks per ns" is not correct. The latencies are acceptable.

I am running xenomai-2.1.2 on a 2.6.16.20 kernel. 
 
 cat /proc/xenomai/timer:
 status=oneshot:setup=51:tickval=1:jiffies=42919216297
 
 cat /proc/xenomai/latency:
 2699
 
 cat /proc/cpufreq:
           minimum CPU frequency  -  maximum CPU frequency  -  policy
 CPU  0       800000 kHz ( 50 %)  -    1600000 kHz (100 %)  -  userspace
 
 cat /proc/cpuinfo:
 processor    : 0
 vendor_id    : GenuineIntel
 cpu family    : 6
 model        : 13
 model name    : Intel(R) Pentium(R) M processor 1.60GHz
 stepping    : 8
 cpu MHz        : 798.419
 cache size    : 2048 KB
 fdiv_bug    : no
 hlt_bug        : no
 f00f_bug    : no
 coma_bug    : no
 fpu        : yes
 fpu_exception    : yes
 cpuid level    : 2
 wp        : yes
 flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
 bogomips    : 1576.96

Can anyone give me a hint on this problem ? 
 
 Thanks,

Cedric.



 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-677057953-1150126260=:57594
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,<br><br>I have installed xenomai on my Compaq nc6120 portable. Everything seems to be working OK. There is only one issue :<br><br>When i create a periodic task, it runs with a higher period than expected (60 x). I have the impression that the ratio "ticks per ns" is not correct. The latencies are acceptable.<br><br>I am running xenomai-2.1.2 on a 2.6.16.20 kernel. <br> <br> cat /proc/xenomai/timer:<br> status=oneshot:setup=51:tickval=1:jiffies=42919216297<br> <br> cat /proc/xenomai/latency:<br> 2699<br> <br> cat /proc/cpufreq:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; minimum CPU frequency&nbsp; -&nbsp; maximum CPU frequency&nbsp; -&nbsp; policy<br> CPU&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 800000 kHz ( 50 %)&nbsp; -&nbsp;&nbsp;&nbsp; 1600000 kHz (100 %)&nbsp; -&nbsp; userspace<br> <br> cat /proc/cpuinfo:<br> processor&nbsp;&nbsp;&nbsp; : 0<br> vendor_id&nbsp;&nbsp;&nbsp; : GenuineIntel<br> cpu family&nbsp;&nbsp;&nbsp; : 6<br>
 model&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 13<br> model name&nbsp;&nbsp;&nbsp; : Intel(R) Pentium(R) M processor 1.60GHz<br> stepping&nbsp;&nbsp;&nbsp; : 8<br> cpu MHz&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 798.419<br> cache size&nbsp;&nbsp;&nbsp; : 2048 KB<br> fdiv_bug&nbsp;&nbsp;&nbsp; : no<br> hlt_bug&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : no<br> f00f_bug&nbsp;&nbsp;&nbsp; : no<br> coma_bug&nbsp;&nbsp;&nbsp; : no<br> fpu&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : yes<br> fpu_exception&nbsp;&nbsp;&nbsp; : yes<br> cpuid level&nbsp;&nbsp;&nbsp; : 2<br> wp&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : yes<br> flags&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2<br> bogomips&nbsp;&nbsp;&nbsp; : 1576.96<br><br>Can anyone give me a hint on this problem ? <br> <br> Thanks,<br><br>Cedric.<br><br><br><p>&#32;__________________________________________________<br>Do You
 Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-677057953-1150126260=:57594--

