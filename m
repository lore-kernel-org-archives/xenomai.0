Subject: Re: [PATCH v2 0/9] y2038 groundwork and first steps
References: <cover.1620233588.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ed990049-2320-aaa1-2ab7-e99895be1c5c@siemens.com>
Date: Thu, 6 May 2021 07:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1620233588.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>

On 05.05.21 18:52, Jan Kiszka via Xenomai wrote:
> Picking up from Philippe's queue:
> 
> This patch series prepares the tree for the upcoming y2038 work,
> converting obsolete/ambiguous time specification types to the proper
> ones introduced upstream by the v5.x kernel series.
> 
> In v2, feedback on the first round has been addressed, primarily
> regarding folding fixing into the patches that need them.
> 
> In addition, this includes 3 patches from Florian that add
> sem_timedwait64 system call and a test suite for it.
> 

Seems we have some issue on ARM ("Illegal instruction" in smokey):
https://source.denx.de/Xenomai/xenomai-images/-/jobs/264219
https://source.denx.de/Xenomai/xenomai-images/-/jobs/264225

Florian, could you check that?

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

