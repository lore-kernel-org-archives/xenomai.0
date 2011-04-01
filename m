From: davide doninelli <davide.doninelli@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Fri, 1 Apr 2011 10:46:58 +0200
Message-ID: <A537C502-9185-43A0-999B-A2DB8583008E@edu.hefr.ch>
MIME-Version: 1.0 (Apple Message framework v1084)
Subject: [Xenomai-help] process on linux
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

Hi 
i see in linux proces 3 xenomai processes per xenomai RT task .
I don't understand what are the first 2 process.
Is that right? What are used for? Tasks are like in envelope?
i don't find information about that.

#ps
....
 483 root     ./interrupt_xeno_userspacen 
  484 root     ./interrupt_xeno_userspacen 
  485 root     ./interrupt_xeno_userspacen 

# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          71         0     00500080  100.0  ROOT
  0  485    0          47         0     00320184    0.0  mytask
  0  0      0          1984       0     00000000    0.0  IRQ26: [timer]




tanks in advance
Davide Doninelli

