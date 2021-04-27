Subject: Re: Updating fec driver for kernel 5.4 and I.MX8Q
References: <2dce9fd3-bc7e-d308-4485-7f7fe4df5eb7@alstefgroup.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <98f70f97-142c-1f18-f3cb-9cccf1bf55ca@siemens.com>
Date: Tue, 27 Apr 2021 18:34:40 +0200
MIME-Version: 1.0
In-Reply-To: <2dce9fd3-bc7e-d308-4485-7f7fe4df5eb7@alstefgroup.com>
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
To: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.04.21 14:21, Jean-Baptiste Tredez via Xenomai wrote:
> Hello,
> 
> Do you have plans for updating fec drivers on xenomai 3.1 ?
> 
> We tried to merge uptream linux driver and Philippe Gerum work (commit
> 1b7a4bd9598aa0d777016fda7e51d2e22aa51e77). Here is the result, it seems
> to work on kernel 5.4 (I.MX8Q target).
> 
> Any testing / help to improve this driver is welcomed.
> 

Unfortunately, the change you shared is massive and does not apply at
all to Xenomai (you patched in the kernel tree, not in Xenomai). Could
you rebase over next and provide that as patch for review?

I do not have any test targets, so we would definitely need feedback
from other users if there are no regressions. But as the change is so
significant, that will likely remain a 3.2 topic, nothing for stable
anymore (unless you can prove that current 3.1 is broken for anyone).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

