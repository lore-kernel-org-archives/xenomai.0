References: <CA+K1mPHyTMSmiONU3yP3sEYx2oFktPqq5rHO8JPKa5deCX10-Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <61e05c7d-b1a6-bba1-b474-aaae2428d4b8@xenomai.org>
Date: Fri, 11 Nov 2016 18:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPHyTMSmiONU3yP3sEYx2oFktPqq5rHO8JPKa5deCX10-Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question regarding rt_dev_socket()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 11/11/2016 06:26 PM, C Smith wrote:
> Hello,
> 
> I have an existing Xenomai 2.6.4 application. I'm now developing a second
> Xenomai application that is to run at the same time as the existing one.
> They need to communicate, so I'm investigating IPC mechanisms:
> 
> I added the following lines to the existing application. However, the
> return value of the call to rt_dev_socket() always fails (returns -97,
> address family not supported).
> 
>      #include <rtdk.h>
>      #include <rtdm/rtipc.h>
>      err = rt_dev_socket(PF_RTIPC, SOCK_DGRAM, IPCPROTO_BUFP);
> 
> Is the return value indicative of a kernel that needs to be reconfigured?
> Must there be a device driver associated with the socket in some way?
> 
> Any help or reference to further documentation would be helpful. I know
> Xenomai 2 is deprecated, but I have mature, well tested application written
> with Xenomai 2.6.4, and don't have time to change it over to Xenomai 3.
> 

-97 is -EAFNOSUPPORT, likely meaning that the RTDM driver implementing
this Xenomai-specific protocol is absent from the kernel.

You need CONFIG_XENO_DRIVERS_RTIPC and CONFIG_XENO_DRIVERS_RTIPC_BUFP
set in your Kconfig, loading the module named xeno_rtipc.ko if you chose
to build this as a dynamic module.

-- 
Philippe.

