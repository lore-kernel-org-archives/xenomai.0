Date: Tue, 5 Feb 2013 11:23:25 +0100
From: Wolfgang Jung <woju@Phantasia.org>
Message-ID: <20130205102325.GA25004@Mail.Phantasia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Behavior of rt_heap_bind
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

while doing some tests with memory heap servives I encountered the following:
a) documentation for rt_heap_bind() states "User-space task (switches to
   primary mode)" which is actually switching from primary-mode to
   secondary-mode. 
Reference:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__heap.html

b) rt_heap_bind() also switches silently from primary-mode to secondary-mode
   (SIGXPU will not be raised by rt_heap_bind() ) .

As far as I understand, mapping of memory needs to be done in secondary-mode.
Is there some major reason why a mode transition is done without raising
SIGXPU in __rt_heap_bind() (syscall.c:2648 (Release 2.6.2.1) ? 
(it is done silently at __rt_queue_bind as well)

W.


