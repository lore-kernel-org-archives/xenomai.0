Subject: Re: RTUdp incoming msg are ok but unable to send UDP
References: <1472936151.691343.1558942077593.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c3d7d4a5-6446-1109-1100-39dd83cf862e@siemens.com>
Date: Mon, 27 May 2019 10:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <1472936151.691343.1558942077593.JavaMail.zimbra@wolfram.com>
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 27.05.19 09:27, Per Oberg via Xenomai wrote:
> Hi folks
> 
> I am having some troubles with UDP and rtnet. I think it used to work, but I'm not sure in what configuration. I had to update to meet some driver demands and now i am using the following versions:
> 
> Xenomai 3.0.7
> ipipe-core-4.9.90-x86-6
> Kernel 4.9.90
> 
> 
> When trying to send a UDP message I got a kernel paging request error so I tried adding nosmap to the boot parameters. This solved the kernel paging bug but no messages are coming out.
> 
> 
> Does anyone know if there went in some patches to rtudp lately that would fix this?
> 
> Any other tips out there ?
> 

Can you try if the issue is also present in stable/v3.0.x or master?

Jan

PS: 4.9 is EOL by now.

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

