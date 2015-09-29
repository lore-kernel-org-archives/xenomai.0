References: <CANWkrRMksLWR10fuM=M1Oc25GYzDHTzFqEq5cDJmGBpjdyxwyg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560A94E9.9080300@xenomai.org>
Date: Tue, 29 Sep 2015 15:40:57 +0200
MIME-Version: 1.0
In-Reply-To: <CANWkrRMksLWR10fuM=M1Oc25GYzDHTzFqEq5cDJmGBpjdyxwyg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops message on rtdm_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/29/2015 03:10 PM, Michael Smith wrote:
> Hi. I'm unclear what I am doing wrong. But I get a oops message when I am
> trying to do a read() (RTDM) from user space into my device driver.
> 
> The read function in the driver has been setup as follows:
> 
>     .ops = {
>             .open           = open_dev,
>             .close          = close_dev,
>             .ioctl_rt       = device_ioctl,
>             .ioctl_nrt      = device_ioctl,
>             .read_nrt       = read_dev,
>             .read_rt        = read_dev,
>             .write_nrt      = write_dev,
>             .write_rt       = write_dev,
> 
> As can be seen I call the same read routine in real-time and non
> real-time, because they both boil down to the same type of callback
> function nl.
> 
> ssize_t rtdm_read_handler(struct rtdm_fd * fd,void __user * buf,size_t size )
> 
> When the read() call is done from user space (non real-time) I get a
> oops as follows:
> 
> [62847.263710] I-pipe: Detected illicit call from head domain 'Xenomai'
> [62847.263710]         into a regular Linux service

The issue is with the runtime mode of the ioctl() caller in userland,
since this is a Cobalt thread, it is automatically switched to rt mode
(aka primary) if needed, before entering ioctl_rt() unconditionally.
There it enters the regular PCI config helpers which may not be called
from rt mode, hence the warning.

In short, you can't run regular PCI routines from a rt handler. If
running it from a non-rt context is an option, then you can ask RTDM to
switch to the proper mode dynamically by returning ENOSYS for specific
requests, this will hand them over to the nrt handler instead e.g.

int ioctl_rt(...unsigned int request...)
{
	switch (request) {
		case SOME_PCI_RELATED_IOCTL:
			return -ENOSYS; /* turn on adaptive call */
	}
...
}

int ioctl_nrt(...unsigned int request...)
{
	switch (request) {
		case SOME_PCI_RELATED_IOCTL:
			pci_whatever(...);
			break;
	}
...
}

-- 
Philippe.

