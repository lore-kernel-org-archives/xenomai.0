Date: Wed, 16 Jul 2014 10:18:17 +0200
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20140716101817.B27E20C2@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] =?utf-8?q?Library_calls_in_real-time_thread?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello I have a problem with EtherCAT slave device.
It was supplied with a small driver (including sources), which uses uio and a library (without sources).
The library consists of some initialization and configuration functions.
It also includes one blocking function which represents "state machine" of the device. This function blocks until another stopping function is called.
During configuration, there is a possibility to pass some pointers to user defined callback functions. So everything is controlled from those callbacks.
The blocking function is called from xenomai real-time thread and I don't expect that the library creates another.
My problem is occasional high latencies of those callback, probably because of system calls in the library which switch it to the secondary mode.
I would like to know what are the possibilities to make it hard real-time.
I could probably port the device driver and uio driver to rtdm. But what has to be done with the library? I'm in contact with its developers, so I could suggest them to make necessary changes.
Thanks in advance
Petr

