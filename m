References: <AM4PR0801MB15879E1D2256FFB403D89242F5110@AM4PR0801MB1587.eurprd08.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <714b476f-d6aa-730a-51f6-5c68d0973a87@xenomai.org>
Date: Wed, 26 Apr 2017 18:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <AM4PR0801MB15879E1D2256FFB403D89242F5110@AM4PR0801MB1587.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_mmap_to_user with default mapping address
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/26/2017 04:59 PM, Johann Obermayr wrote:
> Hallo,
> 
> We are using Xenomai V2.6.4 (i know, this is a old version)
> 

Ok, so I won't mention that installing a mapping at a hard coded virtual
address is a bad idea in most cases (especially if this is about sharing
a piece of shared memory containing pointers between processes).

> we are using rtdm_mmap_to_user to map a kmalloc memory  to user space over ioctl
> 
> Is there a way to tell rtdm_mmap_to_user, that he use a default address.
> 
> At mmap you can add a default address at the first parameter.
> 

*pptr can be preset for this purpose. However, MAX_FIXED is not given to
vm_mmap() internally by RTDM, so this value will always be considered as
a mere hint, and the call won't fail if this address can't be used for
the new mapping.

-- 
Philippe.

