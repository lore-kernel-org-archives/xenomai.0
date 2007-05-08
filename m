Message-ID: <46407EC1.6070809@domain.hid>
Date: Tue, 08 May 2007 15:44:33 +0200
From: Bernhard Michael <michael.bernhard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_create killed in user space
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

I've build a xenomai test application which consists of a kernel module
and a user space application. My target platform is a ARM XScale processor.

The kernel module is running fine but the user space application gets
always killed when calling rt_task_create. The use of the same
functionality in the kernel module is no problem.

Running the latency test is no problem however.

Did somebody experience the same problem? Help is much appreciated.

Michael

