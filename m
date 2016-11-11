MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 11 Nov 2016 09:26:22 -0800
Message-ID: <CA+K1mPHyTMSmiONU3yP3sEYx2oFktPqq5rHO8JPKa5deCX10-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Question regarding rt_dev_socket()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have an existing Xenomai 2.6.4 application. I'm now developing a second
Xenomai application that is to run at the same time as the existing one.
They need to communicate, so I'm investigating IPC mechanisms:

I added the following lines to the existing application. However, the
return value of the call to rt_dev_socket() always fails (returns -97,
address family not supported).

     #include <rtdk.h>
     #include <rtdm/rtipc.h>
     err = rt_dev_socket(PF_RTIPC, SOCK_DGRAM, IPCPROTO_BUFP);

Is the return value indicative of a kernel that needs to be reconfigured?
Must there be a device driver associated with the socket in some way?

Any help or reference to further documentation would be helpful. I know
Xenomai 2 is deprecated, but I have mature, well tested application written
with Xenomai 2.6.4, and don't have time to change it over to Xenomai 3.

Thanks,
C. Smith
