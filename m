Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 15 Feb 2016 11:41:21 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160215174121.GA10070@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.

The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.

When I run the cross-link demo the system hangs after an error in read_task.

Here is the output that I get:
main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : strating read-task
 Nr |   write-irq    |    irq->read    |   write->read   |
----------------------------------------------------------
read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
main : /dev/rtdm/rtser1 (read) -> closed
read_task: exit

Any ideas why this would happen?

I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.

