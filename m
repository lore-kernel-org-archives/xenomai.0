References: <CAHz_r8BsdosJE8obVZ05GP=hLenxndD9VTOG_O20Yb1xroQYrg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e4aaf123-7f0e-1b92-bac5-f36195f3cd86@xenomai.org>
Date: Wed, 26 Apr 2017 09:28:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAHz_r8BsdosJE8obVZ05GP=hLenxndD9VTOG_O20Yb1xroQYrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trouble unloading RTDM modules
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benjamin Alix <alixbenjamin53@gmail.com>, xenomai@xenomai.org

On 04/24/2017 11:37 AM, Benjamin Alix wrote:
> Hello,
> 
> I'm maintaining RTDM modules built under Xenomai 2.6.4 and I'm unable
> to unload them which is not the case with the others non-RTDM modules.
> Whenever I do :
> 
> rmmod my_RTDM_module.ko
> 
> The function rtdm_dev_unregister() return EPERM. So I tried to
> increase the poll_delay argument (which was 0) without success. In
> fact the module doesn't unload even after the time I entered in the
> poll_delay argument and I can't do anything in the terminal.
> 
> So first, I suppose that something is using the device managed by the
> driver but I'm unable to tell what. Is there any way I can find out
> what it is ?
> 

You may want to check /proc/rtdm/open_fildes. In addition, writing a fd
number to this file forces RTDM to close the corresponding descriptor.

> Secondly is there an other way that I'm missing to unload these RTDM modules ?
> 

No, you have to close all file descriptors first, then unregister the
driver.

-- 
Philippe.

