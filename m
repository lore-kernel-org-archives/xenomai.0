Message-ID: <4820143B.6070403@domain.hid>
Date: Tue, 06 May 2008 10:18:03 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTAI Skin FIFO handler running as non-RT task
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I've been playing with the RTAI skin as I wanted a FIFO implementation
close to the one that used to exist in RTLinux.

I've setup an input handler to the FIFO, and this handler is trying to 
acquire some
Xenomai RT mutex that was previously (successfully) created by an RT task.

Acquisition of the handler always fails with -EPERM.
So I've checked the handler status through rtdm_in_rt_context () function
and it seems that the handler is always called from a non-RT context, which
obviously seems to be the reason of the permission denied result.

Is there a reason for the handler not being RT ?
Or any way to make it RT ?

Also, I'm using Xenomai native skin everywhere in my application, except
from FIFO handling which requires me to use RTAI skin for this input 
handler.
Native skin (through pipes) do not seem to provide capabilities to set 
an handler.
Is there a good reason for that ? And is there another way to simulate 
such a handler
than creating a dedicated task that would be wakeup each time something 
is written to the FIFO ?

Thanks for any help on this,

Regards,

Ben


