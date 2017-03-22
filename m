MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Mar 2017 16:43:36 -0400
From: andrija@stupar.com
Message-ID: <e6554f39de4ad302d6dd2173a561d33b@stupar.com>
Sender: andrija@stupar.com
Subject: [Xenomai] rt_dev_read() vs. rtdm_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have a user-space RT application reading/writing a device via a RTDM 
driver. I am thinking of moving some timing-critical parts of the 
application to kernel space. Now, as I understand the API documentation, 
if I'm in kernel space and wish to open/close/read/write/ioctl a device, 
I just use the Inter-Driver API instead of the User API, so I would use 
rtdm_open() instead of rt_dev_open(). In both cases the open handler of 
my driver gets called, is this correct? And the same for all the other 
handlers (read, write, etc.)?

If this is so, I am wondering about the behaviour of 
rtdm_copy_from_user() and rtdm_copy_to_user(). I use these in my 
open/close handlers as I expect calls from user space - but what if the 
__user *src argument of rtdm_copy_from_user() is not actually in 
user-space, but in kernel space since it was passed by rtdm_write() not 
rt_dev_write()?

Does rtdm_copy_from_user() behave as with a call from user space, or 
does it fail? Is there a way to know whether e.g. my write handler of 
the driver was called by rt_dev_write() or rtdm_write()?

I am asking because I am trying to remove as much overhead as possible 
in a time-critical section of my code to improve latency, hence the idea 
to move some bits to kernel space, and also to see whether I can just 
avoid calling rtdm_copy_from/to_user() if it's an unnecessary operation 
(i.e. just copying from one kernel space address to another).

Thanks for any help,

Andrija

