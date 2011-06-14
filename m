Message-ID: <4DF728B9.7000209@domain.hid>
Date: Tue, 14 Jun 2011 11:24:09 +0200
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_block
Reply-To: johann.obermayr@domain.hid
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

Hello,

we using xenomai 2.5.6.
we use mayday to interrupt some user task.
in the mayday handler we call siglongjmp to do a correct shutdown of the 
task.
But in shutdown the task must be delete from some list's. but the access 
to the list
was safed by a mutex. But after mayday, the task was in unblock mode.
is there a way to disable the unblock mode ?
rt_task_block ?

thanks for help.
   jimmy

