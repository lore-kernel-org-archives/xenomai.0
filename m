Message-ID: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
From: stefano.franzoni@marposs.com
Date: Fri, 20 Sep 2013 17:28:31 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Xenomai] memory mapped IO and secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Dear experts

I am developing a system with arm architecture (atmel AT91SAM9G20) with
linux 2.6.30 and xenomai 2.5.4.

I have written a very simple user xenomai application that creates and
starts a real time task (rt_task_create and rt_task_start), with high
priority, that periodically access a memory mapped IO.

Using an oscilloscope I have seen a very little gitter but enabling the
trace on secondary mode switch I have seen that the access to memory mapped
IO, triggers the event of secondary mode switch.

I have used open /dev(mem and mmap outside the rt task and I have obtained
a virtual pointer.
Inside the rt task I write the location using the virtual pointer.

I obtain the same result using  xenomai latency example adding my memory
mapped IO functions.

I don't understand. Cannot I use this method to access memory mapped IO.

Any suggestion?

Thanks in advance



