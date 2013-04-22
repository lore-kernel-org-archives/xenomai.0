Message-ID: <517536B8.4080508@gmail.com>
Date: Mon, 22 Apr 2013 15:10:16 +0200
From: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] How to use rtdm_(io/m)map_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

This is my first post on this mailing list. I am really new with 
xenomai, only
few month ago.

Currently we have a real-time application using xenomai which interacts with
hardware directly by mmaping /dev/mem.

Now, we want to write a real-time device driver that will simulate the 
hardware.
For keeping the same interface than /dev/mem, a conventional linux device
driver would register an mmap file operation, but this is not possible with
rtdm.

But I have seen in xenomai api the functions : rtdm_mmap_to_user and
rtdm_iomap_to_user. Could you explain how to use them, i.e. where do we 
need to
put the function call, do we need to use ioctl file operation to get mmaped
address, etc? Maybe you have an example (I have found nothing in xenomai 
trunk)?

In a near future, instead of use /dev/mem, we plan to use a real-time device
driver and rtdm_iomap_to_user (only to have the same code in client
application). In this case, is it necessary and possible to call
request_mem_region() in the real-time device driver?

Best regards,
Victor Hiairrassary

