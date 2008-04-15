Date: Tue, 15 Apr 2008 14:26:28 +0200
Message-Id: <1071035914@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] system() call allowed from within RT task ?
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

Hello,

within my application I use system() calls from within a xenomai task.
Is this allowed ?

The reason I'm asking this, is the following:
In my application I have multiple xenomai tasks. One of them is time critical (Task_A).
An other (non time critical) xenomai task (Task_B) is used to pass data back
and forth between Task_A and normal linux tasks. Task_B uses the system()-call
to accomplish certain requests.
I have set the T_WARNSW for Task_A in order to get a SIGXCPU, whenever it switches
to secondary mode. As long as Task_B is not executing a sytem() call, everything is fine.
But when for example Task_B executes a system("cp -R dirA dirB") the application terminates
due to a SIGXCPU signal.

I'm using 
- Linux Kernel 2.6.17 (I-PIPE 1.5-02)
- Xenomai 2.3.0
- Celeron 600MHz System


Regards

Jochen
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


