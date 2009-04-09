Message-Id: <1E6B62F8-3C13-425C-A2E3-652E2FB0D6DE@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: multipart/alternative; boundary=Apple-Mail-5--1054565390
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 8 Apr 2009 22:53:59 -0400
Subject: [Xenomai-core] native syscalls
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


--Apple-Mail-5--1054565390
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Can xenomai preempt its own system calls? We ran latency with our  
app.  We had a thread waiting on a cond, and when we signaled that  
cond, the latency jumped from ~70us to almost 400us even though  
latency runs a higher priority thread than the thread that we wake up.  
Is there interrupt disabling that accounts for this?

Here are the results as taken by Mark S.

== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|--- 
lat worst
RTD|      14.934|      27.179|      65.767|       0|      14.934|       
65.767
RTD|      15.151|      26.798|      70.954|       0|      14.934|       
70.954
RTD|      15.409|      27.152|      66.890|       0|      14.934|       
70.954
RTD|      15.947|      27.316|      71.168|       0|      14.934|       
71.168
RTD|      15.746|      26.878|      71.188|       0|      14.934|       
71.188
RTD|      15.489|      26.631|      74.476|       0|      14.934|       
74.476
RTD|      16.659|      26.527|      67.425|       0|      14.934|       
74.476
RTD|      14.567|      26.972|      59.448|       0|      14.567|       
74.476
RTD|      15.987|      27.837|      74.092|       0|      14.567|       
74.476
RTD|      16.241|      28.352|      66.740|       0|      14.567|       
74.476
RTD|      13.982|      27.139|      65.630|       0|      13.982|       
74.476
RTD|      13.982|      33.355|      65.286|       3|      13.892|      
388.473
RTD|      13.982|      33.355|      65.286|       3|      13.892|      
388.473
RTD|      13.982|      33.355|      65.286|       3|      13.892|      
388.473
RTD|      13.982|      33.355|      65.286|       3|      13.892|      
388.473
RTD|      13.982|      33.355|      65.286|       3|      13.892|      
388.473
RTD|      13.791|      33.465|      67.351|       3|      12.702|      
388.473
RTD|      13.791|      33.465|      67.351|       3|      12.702|      
388.473
RTD|      13.791|      33.465|      67.351|       3|      12.702|      
388.473
RTD|      13.791|      33.465|      67.351|       3|      12.702|      
388.473
RTD|      13.761|      33.722|      90.066|       3|      12.702|      
388.473
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|--- 
lat worst
RTD|      13.283|      29.361|      59.140|       3|      12.702|      
388.473
RTD|      11.502|      29.040|      58.235|       3|      11.502|      
388.473
RTD|      10.530|      28.947|      67.027|       3|      10.530|      
388.473
RTD|      14.410|      31.760|      65.229|       3|      10.530|      
388.473
RTD|      13.207|      31.286|      73.607|       3|      10.530|      
388.473
RTD|      13.454|      30.678|      71.275|       3|      10.530|      
388.473
RTD|      14.730|      31.122|      64.090|       3|      10.530|      
388.473
RTD|      14.881|      30.397|      80.705|       3|      10.530|      
388.473
RTD|       9.848|      30.534|      66.659|       3|       9.848|      
388.473
RTD|      14.039|      30.678|      63.525|       3|       9.848|      
388.473
RTD|      13.290|      28.973|      71.589|       3|       9.848|      
388.473
RTD|      16.228|      23.957|      80.598|       3|       9.848|      
388.473
RTD|      17.304|      26.467|      74.018|       3|       9.848|      
388.473
RTD|      16.137|      26.494|      73.226|       3|       9.848|      
388.473
^ 
C 
---| 
------------| 
------------|------------|--------|-------------------------

Thanks,
Steven


--Apple-Mail-5--1054565390
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Can xenomai preempt its own =
system calls? We ran latency with our app. &nbsp;We had a thread waiting =
on a cond, and when we signaled that cond, the latency jumped from ~70us =
to almost 400us even though latency runs a higher priority thread than =
the thread that we wake up. Is there interrupt disabling that accounts =
for this?<div><br></div><div>Here are the results as taken by Mark =
S.</div><div><br></div><div><span class=3D"Apple-style-span" =
style=3D"font-size: 10px; ">=3D=3D All results in =
microseconds<br>warming up...<br>RTT|&nbsp; 00:00:01&nbsp; (periodic =
user-mode task, 100 us period, priority 99)<br>RTH|-----lat min|-----lat =
avg|-----lat max|-overrun|----lat best|---lat =
worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.179|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.767|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.767<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.151|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.798|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
70.954|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
70.954<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.409|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.152|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.890|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
70.954<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.947|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.316|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.168|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.168<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.746|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.878|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.188|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.188<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.489|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.631|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.659|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.527|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.425|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.934|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.567|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.972|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59.448|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.567|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15.987|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.837|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.092|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.567|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.241|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28.352|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.740|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.567|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
27.139|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.630|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.476<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.355|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.892|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.355|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.892|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.355|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.892|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.355|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.892|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.982|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.355|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13.892|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.791|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.465|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.351|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.791|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.465|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.351|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.791|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.465|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.351|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.791|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.465|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.351|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.761|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
33.722|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
90.066|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTT|&nbsp; 00:00:22&nbsp; (periodic user-mode task, 100 us =
period, priority 99)<br>RTH|-----lat min|-----lat avg|-----lat =
max|-overrun|----lat best|---lat =
worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.283|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
29.361|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
59.140|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.702|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11.502|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
29.040|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
58.235|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11.502|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10.530|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28.947|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
67.027|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.410|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
31.760|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
65.229|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.207|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
31.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
73.607|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.454|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.678|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.275|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.730|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
31.122|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
64.090|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.881|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.397|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
80.705|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.530|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.848|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.534|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
66.659|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
14.039|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
30.678|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
63.525|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13.290|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
28.973|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
71.589|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.228|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23.957|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
80.598|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17.304|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.467|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
74.018|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16.137|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
26.494|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
73.226|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.848|&nbsp;&nbsp;&nbsp;&nbsp; =
388.473<br>^C---|------------|------------|------------|--------|---------=
----------------<br></span></div><div><br></div><div>Thanks,</div><div>Ste=
ven</div><div><br></div></body></html>=

--Apple-Mail-5--1054565390--

