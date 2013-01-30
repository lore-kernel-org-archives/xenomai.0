Message-ID: <5108D9AF.7030706@xenomai.org>
Date: Wed, 30 Jan 2013 09:28:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E065333175C3A5@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E065333175C3A5@mbx256-1.adm.swri.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sending data from RT ISR to Userland
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Poole Jr, Donald R." <donald.poole@swri.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/30/2013 07:22 AM, Poole Jr, Donald R. wrote:
> Hello All,
>
> I'm developing a Xenomai RTDM kernel driver (against Xenomai 2.6.1) that reads the pulse-width of a pulse-width modulation frames (or period) using an interrupt service routine. On the rising/falling edges of the pulse, I read the times using rtdm_clock_read() to measure the pulse-width.  Now, after making this measurement, I want to send this data to a user-land process/application for further processing and decision making.  I was going to use the Native Skin's message pipe API, but after doing some googling I found out that the message pipe API is deprecated.  That being the case, I've been reading through the documentation so more to find another solution, but I can't seem to find anything that would allow me to accomplish what I'm after.  What would be the best way to send data/information from the kernel driver to the user land process?
>

Check out the RTIPC driver implementing the XDDP protocol. It's a direct 
replacement for the deprecated RT_PIPE API, based on a socket I/O interface:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtipc.html

Some examples for userland usage can be found in 
examples/rtdm/profiles/ipc. For a kernel-based endpoint sending data, 
you would use the RTDM inter-driver API, e.g. rt_dev_socket(), 
rt_dev_sendmsg() etc. Userland would receive on /dev/rtpX via the 
standard POSIX I/O interface.

-- 
Philippe.

