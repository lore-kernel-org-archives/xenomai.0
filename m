Subject: Re: net/rtdev: Commit e972e78e reintroduces memory corruption fixed
 by 74464ee3
References: <HE1PR0301MB2140C55227286ADD137B6D56E54D0@HE1PR0301MB2140.eurprd03.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1489cdd-cba5-e564-cc7d-e002920149ee@siemens.com>
Date: Fri, 8 Mar 2019 13:55:05 +0100
MIME-Version: 1.0
In-Reply-To: <HE1PR0301MB2140C55227286ADD137B6D56E54D0@HE1PR0301MB2140.eurprd03.prod.outlook.com>
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
To: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>, "Philippe Gerum <rpm@xenomai.org> (rpm@xenomai.org)" <rpm@xenomai.org>, "'xenomai@xenomai.org'" <xenomai@xenomai.org>

On 08.03.19 13:47, Jouko Haapaluoma wrote:
> Hello
> 
> I have been investigating kernel memory corruption issues in our system (Xenomai 2.6.4 and RTnet 0.9.13.2).
> I traced the root cause into the rtdev_map_rtskb() function where a linked list is always grown but not shrinked.
> You have recently created a patch that fixes this: 74464ee3.
> 
> Additionally, there seemed to be a regression and that was fixed in e972e78e. However, this regression fix
> reintroduces the memory corruption in cases where the rtdev does not have the rtdev->map_rtskb function defined.
> Therefore we end up in the situation that was before the 74464ee3: The rtskb_mapwait_list will grow but not shrink.
> If sockets are destroyed and recreated, the rtskb_mapwait_list->next will point to a destroyed skb object which causes a
> use-after-free memory corruption when calling list_add().

Hmpf, right, too bad.

I suppose we should be fine by dropping the rtskb from the waitlist in 
rtdev_unmap_rtskb if it had no dma address set.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

