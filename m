Message-ID: <4A157FD9.40106@domain.hid>
Date: Thu, 21 May 2009 18:22:49 +0200
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] About HARD real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I just wonder :
Why can we read everywhere that PREEMPT-RT patch offer HARD real time 
while in other papers we can read that it cannot ensure determinism  ?
(because it only seems to permit low latencies but not constant 
execution times, by the way why ? Is it because this patch still uses 
undeterministic parts of the kernel ? )
Considering this, how Xenomai 3 will be able to rely on PREEMPT-RT as 
real time enabling technology, allowing user to bypass ADEOS ?

Thanks for your work,
Antoine


