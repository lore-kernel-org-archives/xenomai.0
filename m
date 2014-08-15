Message-ID: <53EE2CD3.507@xenomai.org>
Date: Fri, 15 Aug 2014 17:52:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1408010401.9958.xenomai@xenomai.org>
 <e3bdea6dcdb84852972a720789331cb2@CVEX13.valentin-carl.de>
In-Reply-To: <e3bdea6dcdb84852972a720789331cb2@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] access SPI and DMA hardware from application
 ("external abort...")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/15/2014 08:47 AM, Reitinger, Peter wrote:
> Hello,
> 
> meanwhile I have solved the issue on my own. I tried to access the
> SPI1 HW with traditional mmap approach from user space and had the
> same problem until I saw that I had to start the whole SPI1 module by
> setting a specific control bit to enable its clock. Sorry for posting
> this, but I was really puzzled then. I guess it will also be possible
> to access the hw registers of the SPI with the xenomai rtdm io user
> mapping now...

It is normally recommended to implement drivers in kernel-space using
the RTDM API: this forces you to define a standard interface
(open/read/write/ioctl) between application and driver, which makes it
easy to re-use the same driver in a different application, or to
implement a driver for a differrent hardware without changing your
application.

-- 
                                                                Gilles.

