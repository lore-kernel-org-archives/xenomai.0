Message-ID: <508999F4.6060802@advaoptical.com>
Date: Thu, 25 Oct 2012 21:58:44 +0200
From: Oded Gabbay <ogabbay@advaoptical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Problem with rtdm_mmap_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm using Xenomai 2.6.1 and kernel 2.6.33 on mpc8309 (powerpc) processor.

I'm trying to map a kernel memory area to user space memory.

The call to rtdm_mmap_to_user inside the rt driver works but when I read 
the memory in the user space thread (rt thread), the contents of the 
memory area are wrong.

Here is the code in the driver:

         ret = rtdm_mmap_to_user(user_info, skb, sizeof(struct rtskb), 
PROT_READ|PROT_WRITE,
                                 (void **)&msg->msg_iov[1].iov_base, 
NULL, NULL);


msg->msg_iov[1].iov_base is a void* which points to NULL before the call 
to rtdm_mmap_to_user.

The result is in msg->msg_iov[1].iov_base. The address seems good, as it 
in the range of the addresses of other variables in my user space thread.

In the user-space thread I do:

             void *tmp;
             tmp = msg->msg_iov[1].iov_base;
             printf("tmp = %p:%x\n", tmp, *(int *)tmp);

The results is that tmp points to the same address I got at 
rtdm_mmap_to_user, but the contents of tmp are wrong.

Please help me...

Thanks,
Oded


