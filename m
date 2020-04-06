Subject: Re: Xenomai 3.1 missing munmap Posix wrapper
References: <freemail.20200406181540.86462.1@fmxmldata05.freemail.hu>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5c576a3-e61b-6b8d-c40d-2db14f811a7c@siemens.com>
Date: Mon, 6 Apr 2020 18:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <freemail.20200406181540.86462.1@fmxmldata05.freemail.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paal Tamas <paal_to@freemail.hu>, xenomai@xenomai.org

On 06.04.20 18:15, Paal Tamas via Xenomai wrote:
> Hello Everybody,
> 
> I just migrated from 2.6.2.1. to 3.1 and run into an issue in my user mode application.
> The Posix wrapper for the munmap() function is missing. I mean the cobalt.wrappers file does not have a --wrap munmap line and the library does not have the function either. Why is that?
> The mmap wrapper is there. I need to unmap the memory before closing the file descriptor. At least I did it this way in my old sources. Can I skip the munmap() call in this new Xenomai version before closing the descriptor?

You mmap memory against an RTDM device handle, the only difference to 
mmap against a Linux device is who provides the memory. Releasing that 
mapping is just the same as with Linux: call munmap.

If your driver has anything to do on release, register vmops with the 
backing vma. See e.g. spi_master_mmap.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

