Subject: Re: Finalizing 3.0.9 release
References: <39bd9ede-855c-6a06-73e5-8a79077e6a65@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a5491558-d405-47af-0b82-cc8a4d61c98c@siemens.com>
Date: Fri, 7 Jun 2019 07:11:17 +0200
MIME-Version: 1.0
In-Reply-To: <39bd9ede-855c-6a06-73e5-8a79077e6a65@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>

On 31.05.19 13:13, Jan Kiszka via Xenomai wrote:
> Hi all,
> 
> I'm planning to tag stable 3.0.9 early next week. If you have any 
> stable-relevant patches in your queue or would like to see some commits from 
> master in stable as well, now would be a good time to speak up.
> 

Unfortunately, I hit two show-stopper during tests yesterday: There is an issue 
with syscall restarting in clock_nanosleep and select which also affects stable. 
And there are is a bug when running smokey tests against RTnet which I need to 
understand again to assess its relevance for stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

