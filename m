From: oliver.schlenker@domain.hid
Date: Wed, 7 Oct 2009 13:13:29 +0000
Message-ID: <DIIE.000001A80000AC7B@192.168.2.103>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Subject: [Xenomai-help] Re-2:  rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org





After tracking down the issue a little bit further, it seems not to be a problem of daemonizing a server task,
but to change a line of code in rtprint.c

What I would like to achieve :
- My server process is setting up two Xenomai threads
- Both Xenomai should report some messages with rt_printf()
- rt_printf-function should write not to stdout or stderr but to the syslog

Therefor I changed the code for output the message in rt_print.c from
   fprintf(head->dest, "%s", head->text); 
to
   syslog( LOG_ERR | LOG_LOCAL4, head->text ); 

Problem :
The syslog() call is not doing any output the syslog file, it doesn't matter
if the process is daemonized or not.




Oliver

To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org



