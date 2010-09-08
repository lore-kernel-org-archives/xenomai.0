MIME-Version: 1.0
Date: Wed, 8 Sep 2010 13:45:57 +0200
Message-ID: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
From: Charles Clerdan <charles.clerdan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e65684be8b18bd048fbe0e70
Subject: [Xenomai-help] question about priorities
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

--0016e65684be8b18bd048fbe0e70
Content-Type: text/plain; charset=ISO-8859-1

Hi,


I have a technical question about priorities under Xenomai.

According to my research, Xenomai use priority levels from 0 to 99. 99 is
the highest effective priority and 0 the lowest.
But Linux uses levels from 0 to 139. For current task it uses levels 100 to
139 where 100 is highest priority than 139, and for "real time" threads 0 to
99 where 0 is highest than 99.s
So when a task jumps in secondary modes is there a conversion of its own
priority (100 - primary_mode_priority) or does she keep the same number.
When two tasks with two different priorities are in secondary modes, is
there a priority inversion between them or a crossed convertion of the
priorities?

Regards,

Charles

--0016e65684be8b18bd048fbe0e70
Content-Type: text/html; charset=ISO-8859-1

Hi,<br><br><br>I have a technical question about priorities under 
Xenomai.<br><br>According to my research, Xenomai use priority levels 
from 0 to 99. 99 is the highest effective priority and 0 the lowest. <br>
But Linux uses levels from 0 to 139. For current task it uses levels 100
 to 139 where 100 is highest priority than 139, and for &quot;real time&quot; 
threads 0 to 99 where 0 is highest than 99.s <br>So when a task jumps in
 secondary modes is there a conversion of its own priority (100 - 
primary_mode_priority) or does she keep the same number.<br>
When two tasks with two different priorities are in secondary modes, is 
there a priority inversion between them or a crossed convertion of the 
priorities?<br><br>Regards,<br><br>Charles<br>

--0016e65684be8b18bd048fbe0e70--

