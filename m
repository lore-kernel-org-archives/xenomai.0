Message-ID: <4E31B695.5060506@domain.hid>
Date: Thu, 28 Jul 2011 21:20:53 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] gdb and lost priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

i know that debugging a user application with gdb can broke the task 
priority but
also if i insert no breakpoints ?
I explain better, in the 2.5.6 version a see that if i launch an 
application with gdbserver a task that has an inferior priority execute
while another task with a high priority is running. It's possible or the 
task has switched on secondary mode ?

Thanks for all


