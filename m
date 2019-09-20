Subject: Re: [PATCH] cobalt/autotune: Rework autotune_ioctl_nrt/rt for more
 robust request handling
References: <81b7d4ea-6abe-31c1-8242-52e9fd7bb280@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1241a9f0-db1f-d309-feba-56ecb1c38e31@xenomai.org>
Date: Fri, 20 Sep 2019 19:10:45 +0200
MIME-Version: 1.0
In-Reply-To: <81b7d4ea-6abe-31c1-8242-52e9fd7bb280@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 9/13/19 8:35 PM, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Do not trigger any activity before a correct request has been
> identified, do not copy data from user space as well. Account for races
> between parallel IOCTL calls on the same device when changing or using
> the tuner reference.
> 

Looks ok. I did not test the specific cases these changes are supposed
to address, but no regression on the common working path observed here.

-- 
Philippe.

