Message-ID: <4965D20A.4070606@domain.hid>
Date: Thu, 08 Jan 2009 11:14:34 +0100
From: Axel Beierlein <belatronix@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_shadow prevents new child processes
Reply-To: belatronix@domain.hid
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

when i switch my main function with an rt_task_shadow into the xenomai 
domain, it is not possible to get an new child process.

For example: I start my program with the shadowed main function on the 
target Hardware (embedded PPC) and now i try to telnet to the machine, 
the login process stops until i kill the xenomai program.
When i don't shadow the main function this behavior doesn't occur.

What could be the reason of this behaviour?

thanks in advance

Axel

