References: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: several questions about porting latmus
In-reply-to: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
Date: Mon, 01 Feb 2021 10:31:08 +0100
Message-ID: <87o8h4uobn.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Hongzhan,

Chen, Hongzhan <hongzhan.chen@intel.com> writes:

> Hi Philippe
>
> When I was trying to port latmus from evl to xenomai 3.2,  I met several issues that block porting
> and need your suggestions.
>
> 1. When I tried to replace function evl_run_kthread_on_cpu of latmus.c driver ,  I found that only rtdm_task_init  
>     can meet our requirements mostly  but we still cannot pass cpu affinity through it to pin task to required
>     cpu. Do we need to implement new API so that we can  pass cpu affinity to pin task to required cpu but
>     finish all functions  of rtdm_task_init?
>

We should probably introduce rtdm_task_init_on_cpu() in 3.2, since this
is a desirable feature which should be part of the CXP. Other ways to
pin the new kthread are fairly ugly ATM, ranging from pinning the parent
to the destination CPU before creating the child thread, or open coding
the spawning sequence based on the internal interface (xnthread_init,
xnthread_start). Please submit a patch for review of that change
specifically, prior to submitting any latmus-related bits.

> 2. Regarding replacement of evl_get_xbuf of latmus.c,  I would first call 
>      rtdm_socket (AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP); to create socket and then call rtdm_bind  to bind
>      it to XDDP_PORT=xfd that passed from user space  after call rtdm_setsockopt to do corresponding operation like
>       demo/posix/cobalt/xddp-stream.c.
>      Of course , I would replace evl_write_xbuf with rtdm_sendto  and corresponding xbuf variable type in related 
>      structure.  In addition , on userspace of latmus , I would  replace evl_create_xbuf with open ("/dev/rtp$xfd ",..) and then
>      read by returned handler to get data from socket.  Is such design OK for you?
>      Actually , I can not find any instance about rtdm_socket but description in doc/asciidoc/MIGRATION.adoc, I do not know
>     If such design is feasible. Please comment.
>

There is a general consensus that the kernel->kernel RTDM API is now on
its way out for the 3.x series, and won't be part of the CXP in any case
[1], so we should not rely on the rtdm_* kernel interface for new code.

I would suggest to use the low-level message pipe interface available
from the core instead. That stuff creates a rt-kernel <-> nrt-user
channel, allowing to exchange messages of arbitrary size between those
peers. The kernel should create its own endpoint first, before the
application in user-space can open its side of the channel. Therefore,
the logic flow could be as follows:

1. on some ioctl() request from the application (TBD), the driver
creates the kernel endpoint of a message pipe by a call to
xnpipe_connect(-1, &mpipe_ops, arg). This call returns a pipe "minor"
number, which is the identifier of the new channel. This minor value is
passed back to the application as a result of the ioctl() request.

      Regarding xnpipe_connect() --

      -1 means "find and pick the next free minor for me" to the core.
     
      mpipe_ops is an operation descriptor which can be zeroed for the
      most part, asking the core for default values, except
      .free_obuf. This particular handler will be called by the core for
      releasing every outgoing buffer, i.e. every buffer the driver will
      send via xnpipe_send(), which the application should read(2) (See
      below). Typically, if the data buffer you passed to xnpipe_send()
      was obtained from xnmalloc(), then your .free_obuf handler would
      dispose of it by calling xnfree().

      'arg' is an opaque handle you can use to pass your own "extended
      context" information, which handlers in mpipe_ops will receive as
      the 'xstate' argument.

      There is an example of such use in drivers/ipc/xddp.c, although it
      is more complex.

2. the application creates its endpoint for the same channel by a call
to open("/dev/rtp$minor", ...), obtaining a regular file descriptor
'pfd'.

loop-until-eof {

3. the kernel sends data bulks to the application using xnpipe_send().

4. the application reads those bulks using read(2).

}

5. to terminate the channel, the kernel side issues
xnpipe_disconnect(minor), the application issues close(pfd).

[1] https://xenomai.org/pipermail/xenomai/2020-December/043931.html

-- 
Philippe.

