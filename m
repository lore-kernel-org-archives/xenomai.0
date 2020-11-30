Subject: Re: RTDM PCI information
References: <BN8PR15MB2915F1ACC0DB693A4BF23B20DBF50@BN8PR15MB2915.namprd15.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <916bf86c-b6ed-f3d7-f714-875b48c67566@siemens.com>
Date: Mon, 30 Nov 2020 20:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <BN8PR15MB2915F1ACC0DB693A4BF23B20DBF50@BN8PR15MB2915.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Faron <RobertF@Cmslaser.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 30.11.20 20:12, Robert Faron via Xenomai wrote:
> I have been struggling with creating a driver for my FPGA card.  My issue seems to be that I haven't been able to pass the pointer information for the pci_dev.  When registering the device there is no way, from my limited understanding, to attach information to the device that is created, in my case /dev/rtdm/cms_fpga .
> 
> So while the pci_probe works fine and show me the address of BAR0 there is no way to pass that data to my .open or .ioctl_rt.  I tried creating my stucture globally but that didn't seem to help. The following is a sample of the module as it currently is, any help would be greatly appreciated.
> 

Have a look at rtdm_fd_device():
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/driver_8h.html#ab0378feca734478fb704060e216e65db

>From there, it's just one step to device_data. In-tree drivers also
provide examples for that.

It seems these helper functions (also rtdm_fd_to_private() or
rtdm_private_to_fd()) are not properly categorized to show up more
prominently in the help.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

