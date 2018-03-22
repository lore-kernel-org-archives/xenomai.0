References: <B89CCBE86D4F62448EE4F6367C6D3C894359247F@USIRVA0EM24MSX.ww017.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8fc783f8-aab0-6108-62c6-411e8c8e1bbc@xenomai.org>
Date: Thu, 22 Mar 2018 18:39:40 +0100
MIME-Version: 1.0
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C894359247F@USIRVA0EM24MSX.ww017.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about using UDD in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND" <makarand.pradhan@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/22/2018 06:09 PM, PRADHAN, MAKARAND wrote:
> Hi All,
> 
> I am working on upgrading our device from Xenomai 2 to Xenomai 3. I have been consulting the Xenomai web page. Based on reading the online documentation, I have a fair understanding of the UDD, All the same, I would highly appreciate a second opinion.
> 
> We have a user space interrupt handler and the Xenomai 3 documentation suggests use of UDD. So, I have tried to list down the things I should do.
> 
> In kernel space:
> Register with the udd using udd_register_device.
> I think, the udd_register_device would create /dev/udd/device_name which can be opened for ioctl. Can someone confirm this?
> 
> In User space:
> Open device /dev/udd/device_name

/dev/rtdm/device_name for the main control device,
/dev/rtdm/device_name,mapper<mem-region-number> for the MMIO mappers
responding to mmap() requests.

> ioctl to this device UDD_RTIOC_IRQSIG, providing the pid and the signal to be received by the User space process.

Only if the signal interface is preferred to read()ing. If you don't
enable event signaling, select() and/or read() remain usable to wait for
events.

> ioctl to this device UDD_RTIOC_IRQEN to enable the int.

Correct.

> Wait on the signal using sigwaitinfo or sigtimedwait.
> 
> Am I on the right path?

Yes.

-- 
Philippe.

