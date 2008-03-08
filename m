Message-ID: <47D27C0A.2010507@domain.hid>
Date: Sat, 08 Mar 2008 12:44:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
In-Reply-To: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Posix skin and message queues operation
	mode	misunderstanding
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

juanba romance wrote:
> Hello all i am trying to use a POSIX message queue object to interface a
> couple of application modules and  i am fully confused.
> 
> The execution environment is configured with a fully operational 
> xenomai-2.4.2 /linux 2.6.24-2 framework
> 
> First at all a test program is written/assembled using the librt stuff
> without any xenomai component in order to check the "standard POSIX"
> behavior
> The program works in two modes via input switches
> the "r" mode creates a POSIX queue and attach a notifier through the
> method SIGEV_THREAD, the main sleeps a while before close the created object
> for each callback the notifier empties the queue dumping the values and
> register again the callback symbol up to main flow is timed out .
> the "w" mode tries to push a pattern data set into the created queue in
> burst mode
> So one pid empties the queue and the other apply data. The linux domain
> version using the librt works at expected.
> 
> The weird thing is when we compile the stuff using the xeno-config
> switches so we build xenomai domain message queues..
> Such stuff doesn't provide any feedback to the notifier symbol of the
> reader PID ??
> The writer PID however doesn't provide any error relative to queue
> open/send system calls
> 
> It seems that i am misunderstanding something really basic when these
> objects are applied on the Xenomai domain.
> 
> Could somebody provide me any hint ?

your mq_notify() call actually fails, because SIGEV_THREAD is not currently
supported. SIGEV_SIGNAL is. A bug in the interface library prevents you from
getting the right call status.

--- src/skins/posix/mq.c	(revision 3549)
+++ src/skins/posix/mq.c	(working copy)
@@ -191,6 +191,14 @@

 int __wrap_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 {
-	return -XENOMAI_SKINCALL2(__pse51_muxid,
-				  __pse51_mq_notify, mqdes, notification);
+	int err;
+
+	err = XENOMAI_SKINCALL2(__pse51_muxid,
+				__pse51_mq_notify, mqdes, notification);
+	if (err) {
+		errno = -err;
+		return -1;
+	}
+
+	return 0;
 }

-- 
Philippe.

