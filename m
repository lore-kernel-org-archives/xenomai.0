Message-ID: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
Date: Wed, 6 Jun 2007 17:01:46 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21459_5699596.1181142106881"
Subject: [Xenomai-help] Cyclictest
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

------=_Part_21459_5699596.1181142106881
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I launched the same application Cyclictest on a kernel Linux without Xenomai
and a kernel Linux with Xenomai and I noticed that the result is different.

Here is the result with a kernel Linux without xenomai :

> cyclictest -t 10 -c 1 -i 10500


T: 0 (  732) P:99 I:   10500 C:    2291 Min:      41 Act:    2281 Avg:    5075
Max:   10224

T: 1 (  733) P:98 I:   11000 C:    2187 Min:      66 Act:    1312 Avg:    5085
Max:   10236

T: 2 (  734) P:97 I:   11500 C:    2092 Min:      91 Act:     842 Avg:    5113
Max:   10311

T: 3 (  735) P:96 I:   12000 C:    2004 Min:     106 Act:    1384 Avg:    5134
Max:   10140

T: 4 (  736) P:95 I:   12500 C:    1924 Min:     116 Act:    9873 Avg:    5152
Max:   10306

T: 5 (  737) P:94 I:   13000 C:    1850 Min:     136 Act:     415 Avg:    5172
Max:   10376

T: 6 (  738) P:93 I:   13500 C:    1782 Min:     136 Act:    3873 Avg:    5180
Max:   10411

T: 7 (  751) P:92 I:   14000 C:    1722 Min:     156 Act:    3559 Avg:    5184
Max:   10190

T: 8 (  752) P:91 I:   14500 C:    1663 Min:     140 Act:    8454 Avg:    5216
Max:   10310

T: 9 (  753) P:90 I:   15000 C:    1608 Min:     184 Act:    2485 Avg:    5214
Max:   10490


And here is the result with a kernel Linux with xenomai :
> cyclictest -t 10 -c 1 -i 10000


T: 0 (  893) P:99 I:   10000 C:    1756 Min:   13407 Act:   13536 Avg:   13452
Max:   13693

T: 1 (  894) P:98 I:   10500 C:    1673 Min:    4955 Act:    7595 Avg:    9767
Max:   14727

T: 2 (  895) P:97 I:   11000 C:    1597 Min:    5461 Act:    7628 Avg:   10047
Max:   14793

T: 3 (  908) P:96 I:   11500 C:    1333 Min:    4987 Act:    5641 Avg:    9808
Max:   14779

T: 4 (  909) P:95 I:   12000 C:    1277 Min:    5478 Act:   11665 Avg:    9588
Max:   13864

T: 5 (  910) P:94 I:   12500 C:    1226 Min:    6016 Act:   11191 Avg:    9859
Max:   14135

T: 6 (  911) P:93 I:   13000 C:    1179 Min:    5526 Act:    9711 Avg:   10130
Max:   14901

T: 7 (  912) P:92 I:   13500 C:    1135 Min:    5061 Act:   14740 Avg:    9896
Max:   14852

T: 8 (  913) P:91 I:   14000 C:    1095 Min:    5549 Act:    7766 Avg:    9669
Max:   14198

T: 9 (  914) P:90 I:   14500 C:    1057 Min:    5107 Act:   11820 Avg:    9940
Max:   14984


We can see that with Xenomai, the results are less good.
Is there an explication to this?

Thanks

------=_Part_21459_5699596.1181142106881
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello, </div>
<div>&nbsp;</div>
<div>I launched the same application Cyclictest on a kernel Linux without Xenomai and a kernel Linux with Xenomai and I noticed that the result is different.</div>
<div>&nbsp;</div>
<div>Here is the result with a kernel Linux without xenomai : </div>
<div>&nbsp;</div>
<div>&gt; cyclictest -t 10 -c 1 -i 10500</div>
<div>&nbsp;
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 0 (<span style="mso-spacerun: yes">&nbsp; </span>732) P:99 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10500 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>2291 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>41 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>2281 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5075 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10224</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 1 (<span style="mso-spacerun: yes">&nbsp; </span>733) P:98 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11000 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>2187 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>66 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>1312 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5085 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10236</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 2 (<span style="mso-spacerun: yes">&nbsp; </span>734) P:97 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11500 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>2092 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>91 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>842 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5113 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10311</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 3 (<span style="mso-spacerun: yes">&nbsp; </span>735) P:96 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>12000 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>2004 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>106 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>1384 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5134 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10140</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 4 (<span style="mso-spacerun: yes">&nbsp; </span>736) P:95 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>12500 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1924 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>116 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9873 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5152 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10306</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 5 (<span style="mso-spacerun: yes">&nbsp; </span>737) P:94 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13000 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1850 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>136 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>415 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5172 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10376</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 6 (<span style="mso-spacerun: yes">&nbsp; </span>738) P:93 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13500 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1782 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>136 Act: <span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;</span>3873 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5180 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10411</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 7 (<span style="mso-spacerun: yes">&nbsp; </span>751) P:92 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14000 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1722 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>156 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>3559 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5184 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10190</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 8 (<span style="mso-spacerun: yes">&nbsp; </span>752) P:91 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14500 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1663 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>140 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>8454 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5216 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10310</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">T: 9 (<span style="mso-spacerun: yes">&nbsp; </span>753) P:90 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>15000 C:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; 
</span>1608 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>184 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>2485 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5214 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10490</font>
</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<div>And here is the result with a kernel Linux with xenomai : </div>
<div>&gt; cyclictest -t 10 -c 1 -i 10000</div>
<div>&nbsp;</div>
<div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 0 (<span style="mso-spacerun: yes">&nbsp; </span>893) P:99 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10000 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1756 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13407 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13536 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13452 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13693
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 1 (<span style="mso-spacerun: yes">&nbsp; </span>894) P:98 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10500 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1673 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>4955 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>7595 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9767 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14727
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 2 (<span style="mso-spacerun: yes">&nbsp; </span>895) P:97 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11000 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1597 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5461 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>7628 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10047 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14793
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 3 (<span style="mso-spacerun: yes">&nbsp; </span>908) P:96 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11500 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1333 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>4987 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5641 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9808 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14779
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 4 (<span style="mso-spacerun: yes">&nbsp; </span>909) P:95 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>12000 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1277 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5478 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11665 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9588 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13864
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 5 (<span style="mso-spacerun: yes">&nbsp; </span>910) P:94 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>12500 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1226 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>6016 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11191 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9859 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14135
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 6 (<span style="mso-spacerun: yes">&nbsp; </span>911) P:93 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13000 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1179 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5526 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9711 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>10130 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14901
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 7 (<span style="mso-spacerun: yes">&nbsp; </span>912) P:92 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>13500 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1135 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5061 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14740 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9896 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14852
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 8 (<span style="mso-spacerun: yes">&nbsp; </span>913) P:91 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14000 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1095 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5549 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>7766 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9669 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14198
</font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="COLOR: black"><font face="Times New Roman">T: 9 (<span style="mso-spacerun: yes">&nbsp; </span>914) P:90 I:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14500 C:<span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>1057 Min:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>5107 Act:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>11820 Avg:<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>9940 Max:<span style="mso-spacerun: yes">&nbsp;&nbsp; </span>14984
</font></span></p></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>We can see that with Xenomai, the results are less good. </div>
<div>Is there an explication to this?</div>
<div>&nbsp;</div>
<div>Thanks</div></div>

------=_Part_21459_5699596.1181142106881--

