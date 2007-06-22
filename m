Message-ID: <2a9546e00706212255p1287ae71oa84d922abdd1d1ab@domain.hid>
Date: Fri, 22 Jun 2007 11:25:02 +0530
From: "sanjeev sharma" <sanjeevsharmaengg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5859_31759003.1182491702768"
Subject: [Xenomai-help] Kernel crashing while loading RTDM
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

------=_Part_5859_31759003.1182491702768
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
Xenomai user,

we r facing one more problem.



We have Xenomai RTDM and User realtime application  in which we toggle a
GPIO pin, and we are able to generate the waveform of 500us, Xenomai is
configured for 500us tick value.



And this is stable , we want to load and see there is no drift in the
waveform, unluckly there is no Ethernet, so we created linux process making
while(1) loop given nice value 19, it works properly, no drift.



Actually after running Xenomai realtime application after instering RTDM
module, even if give ls command kernel panics, waveform keep generating ,
why should it fail even if a ls command should be given, please clearify or
any pointers on this. We have timer interrupt latency of 70 us without load,
with load 100 us.



Thanks And Regards

Sanjeev

------=_Part_5859_31759003.1182491702768
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi</span></font></div>
<div class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Xenomai user,</span></font></div>
<div class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial"></span></font>&nbsp;</div>
<div class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">we r facing one more problem.</span></font></div>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">We have Xenomai RTDM and User realtime application &nbsp;in which we toggle a GPIO pin, and we are able to generate the waveform of 500us, Xenomai is configured for 500us tick value.
</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">And this is stable , we want to load and see there is no drift in the waveform, unluckly there is no Ethernet, so we created linux process making while(1) loop given nice value 19, it works properly, no drift.
</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Actually after running Xenomai realtime application after instering RTDM module, even if give ls command kernel panics, waveform keep generating , why should it fail even if a ls command should be given, please clearify or any pointers on this. We have timer interrupt latency of 70 us without load, with load 100 us. 
</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks And Regards</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Sanjeev</span></font></p>
<p class="MsoNormal"><font face="Arial" size="2"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>

------=_Part_5859_31759003.1182491702768--

