Subject: Re: [PATCH 1/2] cobalt: Return error from xnsched_setparam
References: <a0ae52fe-fa52-124e-b3e2-b82d2755fa10@siemens.com>
 <d90c8eb0-dce1-df0f-4e31-b4c8ba85425e@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4f8f9e52-02a6-2df7-04b3-96a0e6bf56a2@siemens.com>
Date: Fri, 23 Nov 2018 12:11:37 +0100
MIME-Version: 1.0
In-Reply-To: <d90c8eb0-dce1-df0f-4e31-b4c8ba85425e@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 23.11.18 11:56, Philippe Gerum wrote:
> On 11/22/18 6:57 PM, Jan Kiszka via Xenomai wrote:
>> This allows to remove the user-triggerable XENO_BUG from
>> xnsched_quota_setparam().
> 
> Could you elaborate on the user trigger point you detected in the code?

pthread_setschedparam_ex(pthread_self(), SCHED_QUOTA, <invalid-tgid>)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

