References: <CAFLxGvzkpeCRKVJ6O5LDpjFJ=oT7g4=5mQyCKVgwywtTchyvkQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a8f62c37-5c4c-a85a-1638-95efb38d55b3@siemens.com>
Date: Tue, 25 Sep 2018 22:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzkpeCRKVJ6O5LDpjFJ=oT7g4=5mQyCKVgwywtTchyvkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] compat_ioctl?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 25.09.18 21:30, Richard Weinberger wrote:
> Hi!
> 
> I'm evaluating how to migrate an 32-bit system to x86_64.
> The plan is having just the kernel 64-bit and userspace still 32-bit.
> Since we have plenty of custom kernel drivers which are used by the
> real-time application,
> I wonder whether Xenomai has a concept like Linux's compat_ioctl()?
> Somehow I have to convert data when userspace does ioctl() to 64-bit
> kernel drivers.

Yes, this exists in Xenomai / RTDM as well, see e.g. the drivers under 
kernel/drivers/ipc.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

