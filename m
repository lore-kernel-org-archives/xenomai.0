From: "Krause, Holger" <holger.krause@sieb-meyer.de>
Date: Thu, 22 Jan 2015 11:30:08 +0000
Message-ID: <2DC6992080CF3541B10F42EBF0B5C30342F6386F@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Corrupted files when using fwrite() or fprintf()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all Xenomai developers.

We run Xenomai 2.6.3 with posix skin activated.
In one thread with priority 0 - so it runs in secondary mode -=20
we use file io with fopen, fwrite, fclose instructions.

When writing a file via fwrite or fprintf we get a problem :
Just one part (the first) of the file has been written. The rest of the=20
file is missing although the fwrites/fprintfs have been executed.

The sequence is like this:

// Open file
fopen();

// Write the first part=20
fwrite();

// Switch the state machine to the next state to prepare the next part
// to be written to the file.
// So the system can do other things - other threads come up and so on

// Write the second part
fwrite()

// Switch the state machine to the next state to prepare the next part
// to be written to the file.
// So the system can do other things - other threads come up and so on

...

// Finally close the file
fclose();

In this situation we get some kind of a timing issue:
Only the first part of the file has been written - but the file is=20
closed correctly.
The statemachine works correctly so all the fwrites haben been executed
but ony the first fwrite works on the filesytem.

In another thread we use the same mechanism but everythings works there.

When I debug the code everythings works.

When I switch all the threads to linux everything works
(of course without realtime) - the file is OK.

When I insert a rt_task_sleep() after the fwrites everythings works if=20
the delay time is big enough (>100ms).

Switching all threads in our system to priority 0 (so that an RT thread=20
cannot catch the hole CPU time and the system cannot write data to=20
disk) does not change anything.

Does anybody have similar problems?

Best regards,
Holger Krause.

