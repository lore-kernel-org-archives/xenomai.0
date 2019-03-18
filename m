Subject: Re: Cobalt compatible distribution
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
 <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
 <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
 <544217707.857557.1552467189711.JavaMail.zimbra@wolfram.com>
 <1283d7c0-b719-8c63-6c7f-abbefe269a7a@gmail.com>
 <192645678.5721329.1552685329163@mail.yahoo.com>
 <cece8f69-d8c5-7165-e918-444398bea154@gmail.com>
 <990066230.5891305.1552722294814@mail.yahoo.com>
From: Don Newbold <d.o.newbold@gmail.com>
Message-ID: <79b82a59-788d-e7b5-8465-8fb1d37bc20c@gmail.com>
Date: Mon, 18 Mar 2019 13:00:47 -0500
MIME-Version: 1.0
In-Reply-To: <990066230.5891305.1552722294814@mail.yahoo.com>
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
To: Alec Ari <neotheuser@ymail.com>, Xenomai--- via Xenomai <xenomai@xenomai.org>

Alec,

I do realize the kernel is modified as part of Cobalt installation. This 
is certainly why only specific kernels are supported. Which is why I was 
looking for a distribution which shipped with a supported kernel.

I was neither expecting nor looking to distrowatch for a distribution 
which included Cobalt. All I was looking to distriwatch for was a 
distribution which shipped with a kernel version supported by Cobalt. I 
found none, which is why I went to the community.

In the absence of any such distribution that ships with a supported 
kernel, I will fall back to selecting a distribution whose kernel can 
easily be updated to a Cobalt supported kernel version. At the moment, 
Ubuntu seems a very likely source. If you would suggest a specific 
distribution and version I would be most appreciative.

Thank you for your assistance.

Don

On 3/16/2019 2:44 AM, Alec Ari wrote:
> Hi,
> 
> Cobalt enabled vs cobalt supported, what is the difference here? Cobalt is part of Xenomai, you patch the kernel using prepare-kernel.sh and you enable the Cobalt kernel config option via Kconfig menu. If you want to write an RTDM driver, the kernel must be patched and configured appropriately.
> 
> The Xenomai/Cobalt stuff is all distro-independent, ipipe and all is kernel space. You won't find anything about Cobalt on distrowatch.
> 
> I didn't insult you, I said that if you're looking for a distribution with a Xenomai kernel shipped with it because building from scratch is too big a task, you're better off avoiding writing a driver.
> 
> If you're serious about doing this, just build the kernel yourself and work on your driver with whatever distro you want. Some distros/desktop environments offer lower latency than others by the time you're all done, but that's really about it. LXDE/LXQt might give you better scores than let's say GNOME/KDE.
> 
> Does this answer your question? If not, let me know what I'm missing as I'm doing my best to help.
> 
> Alec
> 
> ---
> This email has been checked for viruses by AVG.
> https://www.avg.com
> 
> 

