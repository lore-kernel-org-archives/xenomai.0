Message-ID: <45547BD3.6070500@domain.hid>
Date: Fri, 10 Nov 2006 14:17:07 +0100
From: Philipp Keller <philipp.keller@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] troubles deleting tasks
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

Hello

We have troubles deleting the main task created with rt_task_shadow()
from user space.
In the course of initiating the program, we spawn two other threads from
the main task with rt_task_spawn().
When ending the application, both the spawned tasks can be deleted with
rt_task_delete(), but the main task returns with an unknown error code
when calling rt_task_delete().
We believe to have released all recources before deleting, closing all
sockets and file handlers.
The trouble is that we cannot initiate rt can socket communication again
after failing to delete the main thread.
Doeas anyone have an idea what the probelm may be here?

Thanks for any hint
Philipp

 
-- 
Philipp Keller
Software Development

Neuronics AG
Technoparkstrasse 1
8005 Zuerich / Switzerland
Tel +41 44 445 16 40
Fax +41 44 445 16 44
www.neuronics.ch
-- 



