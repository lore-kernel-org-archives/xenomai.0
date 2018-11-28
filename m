Subject: Re: Unable to start RTnet
References: <CAHqFf+uBw8H+8tEq9-5hQod515gATdhb7nFwVrdSKWdAn2C3Sg@mail.gmail.com>
From: limingyu <myli@linx-info.com>
Message-ID: <a9246f50-c976-ac45-42f5-7734dc50bd58@linx-info.com>
Date: Wed, 28 Nov 2018 17:22:16 +0800
MIME-Version: 1.0
In-Reply-To: <CAHqFf+uBw8H+8tEq9-5hQod515gATdhb7nFwVrdSKWdAn2C3Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sakshi Bansal <sakshi.april5@gmail.com>
Cc: xenomai@xenomai.org, duanwujie <wjduan@linx-info.com>

As I can see, the existed rt_e1000e driver didn't support the I219 
device, the latest supported device is I218 devices. And I am working on 
porting the newer driver now.

On 11/28/18 4:35 PM, Sakshi Bansal via Xenomai wrote:
> Hello,
>
> Xenomai version - 3.0.5
> Build-in RTnet kernel module - rt_e1000e
> lspci -knn:
>
> * Ethernet Controller [0280] Intel Corporation Device [8086:24fd] (rev 02==78)
> * *Subsystem: Lenovo Ethernet Connection (2) I219-LM [17aa:310b]**
>   Kernel modules: e1000e*
>
> The rt_e1000e is not listed as a module. I suspect this is the reason why
> RTnet won't start. Any ideas on what needs to be done next?

-- 
Linx Software Co. Ltd. Sichuan Branch
E-mail: myli@linx-info.com


