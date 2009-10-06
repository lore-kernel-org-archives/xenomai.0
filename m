From: oliver.schlenker@domain.hid
Date: Tue, 6 Oct 2009 15:10:25 +0000
Message-ID: <DIIE.000001AF0000AC52@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
Subject: [Xenomai-help] rt_printf with daemonized task
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




Hi,

we are using a xenomai system with kernel 2.6.22 and xenomai 2.4.7.

There is some strange behaviour when using rt_printf in one of our
application. The application is setup as a server process, which itself
is setting up several xenomai tasks. 
All rt_printf outputs are displayed correctly as long as the server process is not daemonized. 

If the server process is daemonized with code like

if( (pid=fork()) < 0 )
{
        return(-1);
}else
{
        if( pid != 0 )
        {
            exit(0);
        }
}

all rt_printf-output is printed only when the server process exits
and not during the time the server process is running.


Any idea ?



Thanks,


Oliver



