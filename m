Message-ID: <4F5A3E40.4060803@domain.hid>
Date: Fri, 09 Mar 2012 18:30:40 +0100
From: Michael Heuer <michael.heuer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] find segmentation fault in real-time-task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi guys, I'm posting the first time and i hope you can help me.

At the moment i have a segmentation fault in the real-time part of my 
program (task created with rt_task_create, Xenomai 2.5.6).

Is there a way to register an signal to print the call-stack?

If its in the non real-time part the signal is raised and i get my 
information but in the real-time part i just get an Segmentation fault 
in the shell...

Or how can i determine at which position the error occurs?

Thanks in advance Michael

