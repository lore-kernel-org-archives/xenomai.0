Message-ID: <448E7C42.3030504@domain.hid>
Date: Tue, 13 Jun 2006 10:50:10 +0200
From: Jean-Olivier Villemure <jean-olivier.villemure@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai integration to LTTng and LTTV
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, ltt-dev@domain.hid

Hello,

I'm currently working on my diploma thesis which will finish in December 
2006. The first goal of my project is to integrate Xenomai events to 
LTTng, a task quite simple since creating new events in LTTng is not 
very difficult. The second goal is to create a new module in the viewer, 
LTTV, to analyse these specifics events.

Our idea about the LTTV module is to create a new controlflow module 
representing realtime task behavior by identifying the start, end, 
suspend, resume, period, etc...The difference with the current 
controlflow is that we will not be showing the states of the process, 
but there will be a line for each task (multiple realtime tasks by 
process) and identifiers for each important events. Eventualy it will be 
good to detected problems relating to periodic tasks. If I have enough 
time, it could also be a good idea to add some statistics.

If you have any idea relating to Xenomai or LTTng/LTTV, I will 
considerate them.

Thank you!
Jean-Olivier Villemure

