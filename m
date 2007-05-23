Message-ID: <528bc2040705222310j179c996w9f7732032038886b@domain.hid>
Date: Wed, 23 May 2007 15:10:50 +0900
From: "manoj kumar" <manojkpanghal@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_63885_16422646.1179900650353"
Subject: [Xenomai-core] getting negative values in interrupt latency in
	xenomai
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

------=_Part_63885_16422646.1179900650353
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i am runnigthe latency test on i386 platform with 1 GB ram and intel pentium
4 runnig at 2.66GHz . i am getting some negative values as lat best and avg.
The results are as below

*    User space interrupt latency output*

*    == Sampling period: 10000 us*

*== Test mode: periodic user-mode task*

*== All results in microseconds*

*warming up...*

*RTT|  00:00:01  (periodic user-mode task, 10000 us period, priority 99)*

*RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst*

*RTD|      -1.775|      -1.374|       0.953|       0|      -1.775|
0.953*

*RTD|      -1.790|      -1.355|       3.142|       0|      -1.790|
3.142*

*RTD|      -1.812|      -1.266|       4.158|       0|      -1.812|
4.158*

*RTD|      -1.797|      -1.272|       6.602|       0|      -1.812|
6.602*

*RTD|      -1.764|      -1.365|       0.575|       0|      -1.812|
6.602*

*RTD|      -1.895|      -1.370|       0.859|       0|      -1.895|
6.602*

*RTD|      -1.857|      -1.421|       0.908|       0|      -1.895|
6.602*

*RTD|      -1.782|      -1.293|       5.845|       0|      -1.895|
6.602*

*RTD|      -1.929|      -1.362|       1.204|       0|      -1.929|
6.602*

*RTD|      -1.775|      -1.359|       0.844|       0|      -1.929|
6.602*

*RTD|      -1.794|      -1.346|       0.724|       0|      -1.929|
6.602*

*RTD|      -1.756|      -1.318|       1.021|       0|      -1.929|
6.602*

*RTD|      -1.775|      -1.269|       8.064|       0|      -1.929|
8.064*

*RTD|      -1.805|      -1.395|       0.893|       0|      -1.929|
8.064*

*RTD|      -1.779|       1.530|     281.147|       0|      -1.929|
281.147*

*RTD|      -1.959|      -1.362|       1.118|       0|      -1.959|
281.147*
Could any figure out why these negative values are coming and reason behind
that and how i can avoid these.

is it a configuration issuse.

Thanks & regards
Manoj

------=_Part_63885_16422646.1179900650353
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>i am runnigthe latency test on i386 platform with 1 GB ram and intel pentium 4 runnig at 2.66GHz&nbsp;. i am getting some negative values as lat best and avg.</div>
<div>The results are as below</div>
<div>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>User space interrupt latency output
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;"><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>== Sampling period: 10000 us
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">== Test mode: periodic user-mode task</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">== All results in microseconds</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">warming up...</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTT|<span style="mso-spacerun: yes">&nbsp; </span>00:00:01<span style="mso-spacerun: yes">
&nbsp; </span>(periodic user-mode task, 10000 us period, priority 99)</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.775|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.374|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.953|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.775|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.953
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.790| <span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>-1.355|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>3.142|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.790|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>3.142
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.812|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.266|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>4.158|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.812|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>4.158
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.797|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.272|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.812|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.764|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.365|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.575|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.812|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.895|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.370|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.859|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.895|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.857|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.421|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.908|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.895|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.782|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.293|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5.845|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.895|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.362|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1.204|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.775|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.359|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.844|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.794|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.346|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.724|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp; </span><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;</span>-1.756|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.318|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1.021|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|
<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6.602</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.775|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.269|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>8.064|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>8.064
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.805|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.395|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.893|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>8.064
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.779|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1.530|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>281.147|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.929|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>281.147
</span></b></p>
<p class="MsoNormal" style="MARGIN: 3pt 0cm 6pt"><b><span style="FONT-FAMILY: Arial; mso-bidi-font-size: 11.0pt; mso-bidi-font-family: &#39;Times New Roman&#39;">RTD|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.959|<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.362|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1.118|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>-1.959|<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>281.147
</span></b></p></div>
<div>Could any figure out why these negative values are coming and reason behind that and how i can avoid these.</div>
<div>&nbsp;</div>
<div>is it a configuration issuse.</div>
<div>&nbsp;</div>
<div>Thanks &amp; regards</div>
<div>Manoj</div>

------=_Part_63885_16422646.1179900650353--

