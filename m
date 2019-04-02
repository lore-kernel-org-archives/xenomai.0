Subject: Re: [PATCH] ipipe: Fix get_user_pages usage in __ipipe_pin_vma
References: <ecf9f46b-fe92-95d3-2234-ee6264bfc41e@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0ead089d-c204-26dd-7e1e-d6c16c91a27a@xenomai.org>
Date: Tue, 2 Apr 2019 19:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <ecf9f46b-fe92-95d3-2234-ee6264bfc41e@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 4/2/19 2:47 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since 9beae1ea8930, we are supposed to pass down flags, not just 0 or 1.
> Luckily, 1 happened to be FOLL_WRITE, so we did the right thing by
> chance.
> 
> Moreover, get_user_pages is deprecated in favor of its locked/unlocked/
> fast variants.
> 

merged, thanks.

-- 
Philippe.

